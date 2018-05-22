#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: Arne Neumann <nlpbox.programming@arne.cl>

import sh
import sys


EXPECTED_OUTPUT = """( Root (span 1 2)
  ( Satellite (leaf 1) (rel2par Contrast) (text _!Although they did n't like it ,_!) )
  ( Nucleus (leaf 2) (rel2par span) (text _!they accepted the offer ._!) )
)
"""

def test_codra():
    """The DPLP parser produces the expected output."""
    parser = sh.Command('./codra.sh')
    result = parser('input_short.txt')
    return result.stdout == EXPECTED_OUTPUT, result.stderr.encode('utf-8')

if __name__ == '__main__':
    passed, err = test_codra()
    if not passed:
        sys.stderr.write("test_codra(): '{}' does not match expected output.\n".format(err))
        sys.exit(1)

