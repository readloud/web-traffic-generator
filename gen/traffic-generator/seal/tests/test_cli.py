import sys

import pytest

from wtgseal import __version__ as dist_version
from wtgseal import cli


def test_main(tmp_path, shared_datadir, datadir):
    outfile = tmp_path / 'locustfile.py'
    docdef = shared_datadir / 'objout.txt'
    docseq = shared_datadir / 'name.txt'
    cli.main([
        '-o',
        str(outfile),
        '-t',
        'UserTestSet',
        '-l',
        'WebUserLocust',
        '-w',
        '2',
        '-s',
        '2',
        str(docdef),
        str(docseq)])
    expected = (datadir / 'locustfile.py').read_text().format(dist_version)
    result = outfile.read_text()
    assert result == expected


def test_main_csv_group(tmp_path, shared_datadir, datadir):
    outfile = tmp_path / 'locustfile.py'
    docdef = shared_datadir / 'objout.txt'
    docseq = shared_datadir / 'name.txt'
    cli.main([
        '-o',
        str(outfile),
        '-t',
        'UserTestSet',
        '-l',
        'WebUserLocust',
        '-w',
        '2',
        '-s',
        '2',
        '--csv-stats-interval',
        '5',
        '--group-by-doc',
        str(docdef),
        str(docseq)])
    expected = (datadir / 'locustfile_csv_group.py').read_text().format(
        dist_version)
    result = outfile.read_text()
    assert result == expected


def test_main_invalid_file(shared_datadir):
    with pytest.raises(FileNotFoundError, match=r'.*nonexistent not found.*'):
        cli.main([str(shared_datadir / 'objout.txt'),
                  str(shared_datadir / 'nonexistent')])


def test_main_existing_file(tmp_path, shared_datadir, datadir):
    outfile = tmp_path / 'locustfile.py'
    docdef = shared_datadir / 'objout.txt'
    docseq = shared_datadir / 'name.txt'
    cli.main([
        '-o',
        str(outfile),
        str(docdef),
        str(docseq)])
    with pytest.raises(FileExistsError):
        cli.main([
            '-o',
            str(outfile),
            str(docdef),
            str(docseq)])


def test_run(tmp_path, shared_datadir):
    sys.argv = ['wtgseal', '-o', str(tmp_path / 'locustfile.py'),
                str(shared_datadir / 'objout.txt'),
                str(shared_datadir / 'name.txt')]
    cli.run()
    assert (tmp_path / 'locustfile.py').exists()
