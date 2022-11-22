from collections import Counter

from wtgseal import utils


def test_parse_documents(shared_datadir):
    expected = [
        ['/1.txt'],
        ['/1.txt', '/2.txt', '/3.txt'],
        ['/4.txt', '/5.txt', '/6.txt', '/7.txt', '/8.txt', '/9.txt', '/10.txt']
    ]
    with (shared_datadir / 'objout.txt').open() as f:
        it = utils.parse_documents(f)
        for i, obj in enumerate(it):
            assert obj == expected[i]


def test_parse_requests(shared_datadir):
    expected = [1, 5, 3, 1, 1]
    with (shared_datadir / 'name.txt').open() as f:
        it = utils.parse_requests(f)
        assert expected == list(it)


def test_count_requests(shared_datadir):
    expected = Counter({1: 3, 3: 1, 5: 1})
    with (shared_datadir / 'name.txt').open() as f:
        frequencies = utils.count_requests(f)
        expected_sort = sorted(expected.most_common())
        freq_sort = sorted(frequencies.most_common())
        assert expected_sort == freq_sort


def test_calc_weights(shared_datadir):
    expected = Counter({1: 3, 3: 1, 5: 1})
    with (shared_datadir / 'name.txt').open() as f:
        frequencies = utils.count_requests(f)
        expected_sort = sorted(expected.most_common())
        weights_sort = sorted(utils.calc_weights(frequencies).most_common())
        assert expected_sort == weights_sort
