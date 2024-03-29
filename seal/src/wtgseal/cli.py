"""Command-Line-Interface for wtg-seal.

This module provides a command line interface for wtg-seal.
Particularly, it manages some options and defines the main function.

"""

import argparse
import sys
from pathlib import Path
from typing import Dict, List

import locust.stats

from . import __version__ as wtgseal_version
from . import maker, utils


def add_default_args(parser: argparse.ArgumentParser) -> None:
    """Add default options and arguments to the CLI parser.

    Parameters
    ----------
    parser : {argparse.ArgumentParser}
        CLI parser object

    """
    parser.add_argument(
        'docdef',
        help='file with documents definitions',
        metavar='DEFINITIONS')
    parser.add_argument(
        'docseq',
        help='file with sequence of documents requests',
        metavar='REQUESTS')
    parser.add_argument(
        '-l',
        '--locust',
        help='class name for Locust (default: WebsiteUser)',
        default='WebsiteUser')
    parser.add_argument(
        '-t',
        '--taskset',
        help='class name for Taskset (default: UserBehaviour)',
        default='UserBehaviour')
    parser.add_argument(
        '-w',
        '--weight',
        help='weight for Locust (default: 1)',
        default=1,
        type=int)
    parser.add_argument(
        '-s',
        '--seed',
        help='seed for wait time values generator (default: 1)',
        default=1,
        type=int,
        metavar='SEED',
        dest='wait_seed')
    parser.add_argument(
        '--csv-stats-interval',
        help='the frequency (in seconds) with which stats data are written to '
             'CSV file',
        type=int,
        metavar='INTERVAL',
        dest='csv_stats_interval')
    parser.add_argument(
        '--group-by-doc',
        help='group URLs together in Locust\'s statistics according to '
        'document id',
        action='store_true',
        dest='group_by_doc')
    parser.add_argument(
        '-o',
        '--output',
        help='output file name (default: locustfile.py)',
        metavar='OUTFILE',
        default='locustfile.py')
    parser.add_argument(
        '-f',
        '--force',
        help='force overwriting an existing file',
        action='store_true')
    parser.add_argument(
        '-V',
        '--version',
        action='version',
        version=f'wtg-seal {wtgseal_version}')


def parse_args(args: List[str]) -> Dict:
    """Parse command line arguments.

    Parameters
    ----------
    args : {List[str]}
        Command line arguments as list of strings.

    Returns
    -------
    Dict
        Command line arguments as dictionary.

    """
    parser = argparse.ArgumentParser(
        description='Create a locust file based on outputs from '
                    'SURGE for web traffic generation.',
        epilog='Note: see the documentation for more information about SURGE '
               'and expected format for input files.')
    parser.set_defaults(command=run_wtgseal)
    add_default_args(parser)
    opts = vars(parser.parse_args(args))
    return opts


def validate_file(path: Path) -> None:
    """Validate a given file path.

    Validate if a given path exists and it is a file, throwing an
    exception otherwise.

    Parameters
    ----------
    path : {Path}
        The file represented as a Path object.

    Raises
    ------
    FileNotFoundError
        If file does not exist or it is not a file.

    """
    if not path.exists() or not path.is_file():
        raise FileNotFoundError(f'{path} not found or it is not a file.')


def run_wtgseal(opts: Dict) -> None:
    """Create a locust file.

    Call the python API to create a locust file, according to the
    inputs provided.

    Parameters
    ----------
    opts : {Dict}
        Command line arguments as a dictionary.

    Raises
    ------
    FileExistsError
        If output file exists and option ``--force`` was not given.

    """
    # setup input/output paths
    docdef = Path(opts['docdef'])
    docseq = Path(opts['docseq'])
    outfile = Path(opts['output'])
    # validate input files
    validate_file(docdef)
    validate_file(docseq)
    # validate output file
    if outfile.exists() and not opts['force']:
        raise FileExistsError(f'{outfile} already exists.')

    with docseq.open(mode='r') as fd:
        freq = utils.count_requests(fd)
    weights = utils.calc_weights(freq)

    out = []
    out.extend(maker.setup_header())
    out.extend(maker.setup_blank_line())
    out.extend(maker.setup_import())
    if (opts['csv_stats_interval'] is not None
            and opts['csv_stats_interval']
            != locust.stats.CSV_STATS_INTERVAL_SEC):
        out.extend(maker.setup_csv_stats_interval(opts['csv_stats_interval']))
    out.extend(maker.setup_blank_line())
    out.extend(maker.setup_blank_line())
    out.extend(maker.setup_taskset(opts['taskset']))
    with docdef.open(mode='r') as fd:
        docs = utils.parse_documents(fd)
        for i, doc in enumerate(docs):
            if opts['group_by_doc']:
                out.extend(maker.setup_task(f'getdoc{i}', doc,
                                            weight=weights[i], indlevel=1,
                                            group_name=f'doc#{i}'))
            else:
                out.extend(maker.setup_task(f'getdoc{i}', doc,
                                            weight=weights[i], indlevel=1))
            out.extend(maker.setup_blank_line())
    out.extend(maker.setup_blank_line())
    out.extend(maker.setup_user(opts['locust'], opts['taskset'],
               weight=opts['weight'], wait_seed=opts['wait_seed']))
    maker.write_locust(outfile, out)


def main(args: List[str]):
    """Set main entry point for external applications.

    Parameters
    ----------
    args : {List[str]}
        Command line arguments.

    """
    opts = parse_args(args)
    opts['command'](opts)


def run():
    """Entry point for console script."""
    main(sys.argv[1:])


if __name__ == '__main__':
    main(sys.argv[1:])
