"""Utilities for wtg-seal.

This module offers utilities function for wtg-seal, mainly focused on
file parsing.

"""

from typing import Counter, Generator, List, TextIO  # noqa


def parse_documents(file: TextIO,
                    /) -> Generator[List[str], None, None]:  # noqa: E225
    """Parse a text file containing documents definitions into lists.

    Read a file containing web documents representations and generates
    lists of URIs related to each object.

    Parameters
    ----------
    file : {TextIO}
        A file handler to the file to be parsed. The file should contain
        one or more lines, which being a space-separated list of
        integers. Each line represents a document to be retrieved from a
        web server. A document is made of one or more files, given by
        the integers.

    Yields
    ------
    List[str]
        The representation of the next document, *i.e.* the URIs of the
        files that compose the document.

    Notes
    -----
    Ideally, `file` is the file `objout.txt` generated by the program
    `objects`, part of SURGE [1]_.

    References
    ----------
    .. [1] Barford, P., & Crovella, M. (1998, June). Generating
       representative web workloads for network and server performance
       evaluation. In *Proceedings of the 1998 ACM SIGMETRICS joint
       international conference on Measurement and modeling of computer
       systems* (pp. 151-160).

    """
    for line in file:
        yield [f'/{x}.txt' for x in line.split()]


def parse_requests(file: TextIO,
                   /) -> Generator[int, None, None]:  # noqa: E225
    """Parse a text file containing a sequence of documents requests.

    Read a file containing a sequence of documents identifiers which was
    to be requested to a web server.

    Parameters
    ----------
    file : {TextIO}
        A file handler to the file to be parsed. The file should contain
        one or more lines with an integer in each of them.

    Yields
    ------
    int
        The index of the next document to be requested.

    Notes
    -----
    Ideally, `file` is the file `name.txt` generated by the program
    `lru`, part of SURGE [1]_.

    References
    ----------
    .. [1] Barford, P., & Crovella, M. (1998, June). Generating
       representative web workloads for network and server performance
       evaluation. In *Proceedings of the 1998 ACM SIGMETRICS joint
       international conference on Measurement and modeling of computer
       systems* (pp. 151-160).

    """
    for x in file:
        yield int(x)


def count_requests(file: TextIO, /) -> Counter:  # noqa: E225
    """Count the number of requests for each document.

    Count the number of requests made for each document based on a
    given sequence of document requests.

    Parameters
    ----------
    file : {TextIO}
        A file containing a sequence of integers representing indexes of
        documents in a web server.

    Returns
    -------
    Frequency

        A `collection.Counter` with the frequencies for each document.

    See Also
    --------
        parse_requests

    """
    parser = parse_requests(file)
    frequencies = Counter(parser)
    return frequencies


def calc_weights(freqs: Counter) -> Counter:
    """Calculate weights for locust tasks.

    Calculate locust task weights based on the frequency that each
    document was requested, as given by `freqs`.

    Parameters
    ----------
    freqs : {Counter}
        The number of requests for each document.

    Returns
    -------
    Counter
        The weight for each document when mapped as a locust task.

    """
    weights = Counter(freqs)
    _, least = freqs.most_common()[-1]
    for key in weights:
        weights[key] = round(weights[key] / least)
    return weights