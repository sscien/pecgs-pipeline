import argparse
import os
import logging
import random
from pathlib import Path

import pandas as pd

import wombat.pecgs as pecgs

logging.basicConfig(format='%(asctime)s - %(message)s', level=logging.INFO)

PIPELINE_IDENTIFIERS = [
    'pecgs_TN_wxs_fq',
    'pecgs_TN_wxs_bam',
    'pecgs_TN_wgs_bam',
    'pecgs_T_rna_fq',
]

parser = argparse.ArgumentParser()

parser.add_argument('mode', type=str, choices=['make-run', 'tidy-run', 'summarize-run', 'move-run'],
    help='Which command to execute. make-run will generate scripts needed to run pipeline. tidy-run will clean up large, uneccessary input files. summarize-run will create summary files with run metadata. move-run will transfer the results of the run to another directory and update filepaths in all summary/results files accordingly.')

parser.add_argument('pipeline_name', type=str, choices=PIPELINE_IDENTIFIERS,
    help='Which pipeline version to run.')

parser.add_argument('run_list', type=str,
    help='Filepath of table containing run inputs.')

parser.add_argument('run_dir', type=str,
    help='Directory on compute1 that will be used for the pipeline runs.')

parser.add_argument('--sequencing-info', type=str,
    help='Sequencing info for fastqs if you want aligned bams to have correct metadata')

parser.add_argument('--input-config', type=str,
    help='YAML file containing inputs that will override the default pipeline parameters.')

parser.add_argument('--proxy-run-dir', type=str,
    help='Use if running this script on a system that is not compute1. Will write inputs to a proxy directory that can then be copied to compute1.')

parser.add_argument('--additional-volumes', type=str,
    help='Additional volumnes to map on compute1 on top of /storage1/fs1/dinglab and /scratch1/fs1/dinglab')

parser.add_argument('--queue', type=str, default='general',
    help='Which queue to use. Default is general.')

parser.add_argument('--target-dir', type=str,
    help='Which directory to move the run directory to after run is complete. Used in move-run')

args = parser.parse_args()


def make_run():
    run_list = pd.read_csv(args.run_list, sep='\t', index_col='run_id')
    run_map = run_list.transpose().to_dict()
    run_map = {k: {c.replace('.filepath', ''): val
                   for c, val in v.items() if 'filepath' in c}
               for k, v in run_map.items()}

    if args.sequencing_info is not None:
        sequencing_info = pd.read_csv(
                args.sequencing_info, sep='\t', index_col='run_id')
    else:
        sequencing_info = None

    # get pecgs-pipeline root
    fp = os.path.realpath(__file__)
    tool_root = '/'.join(fp.split('/')[:-3])

    if args.pipeline_name == 'pecgs_TN_wxs_fq':
        job_cmds = pecgs.from_run_list(
            run_map, args.run_dir, tool_root, args.pipeline_name,
            sequencing_info=sequencing_info, proxy_run_dir=args.proxy_run_dir,
            queue=args.queue)
    elif args.pipeline_name in ['pecgs_TN_wxs_bam', 'pecgs_TN_wgs_bam', 'pecgs_T_rna_fq']:
        job_cmds = pecgs.from_run_list(
            run_map, args.run_dir, tool_root, args.pipeline_name,
            proxy_run_dir=args.proxy_run_dir, queue=args.queue)


def tidy_run():
    pecgs.tidy_run(args.run_dir, os.path.join(args.run_dir, '2.tidy_run.sh'))


def summarize_run():
    run_list = pd.read_csv(args.run_list, sep='\t', index_col='run_id')
    # get pecgs-pipeline root
    fp = os.path.realpath(__file__)
    tool_root = '/'.join(fp.split('/')[:-3])

    analysis_summary, run_summary = pecgs.generate_analysis_summary(
        tool_root, run_list, args.run_dir, args.pipeline_name)

    if run_summary is not None:
        analysis_summary.to_csv(os.path.join(
            args.run_dir, 'analysis_summary.txt'), sep='\t', index=False)
        run_summary.to_csv(os.path.join(
            args.run_dir, 'run_summary.txt'), sep='\t', index=False)

def alter_dataframe_filepaths(df, run_dir, target_dir):
    for i in df.index.to_list():
        for c in df.columns:
            fp = df.loc[i, c]
            if isinstance(fp, str) and run_dir in fp:
                print('run and target', run_dir, target_dir)
                new_fp = fp.replace(run_dir, '')
                new_fp = os.path.join(target_dir, new_fp.strip('/'))
                df.loc[i, c] = new_fp
    return df


def move_run():
    Path(args.target_dir).mkdir(parents=True, exist_ok=True)

    run_summary = pd.read_csv(
        os.path.join(args.run_dir, 'run_summary.txt'), sep='\t')
    analysis_summary = pd.read_csv(
        os.path.join(args.run_dir, 'analysis_summary.txt'), sep='\t')

    run_summary = alter_dataframe_filepaths(
        run_summary, args.run_dir, args.target_dir)
    analysis_summary = alter_dataframe_filepaths(
        analysis_summary, args.run_dir, args.target_dir)

    analysis_summary.to_csv(os.path.join(
        args.target_dir, 'analysis_summary.txt'), sep='\t', index=False)
    run_summary.to_csv(os.path.join(
        args.target_dir, 'run_summary.txt'), sep='\t', index=False)



def main():
    if args.mode == 'make-run':
        make_run()
    elif args.mode == 'tidy-run':
        tidy_run()
    elif args.mode == 'summarize-run':
        summarize_run()
    elif args.mode == 'move-run':
        move_run()


if __name__ == '__main__':
    main()
