#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author: Arne Neumann <nlpbox.programming@arne.cl>

import pytest
import sh


EXPECTED_OUTPUT = """( Root (span 1 2)
  ( Satellite (leaf 1) (rel2par Contrast) (text _!Although they did n't like it ,_!) )
  ( Nucleus (leaf 2) (rel2par span) (text _!they accepted the offer ._!) )
)
"""


def test_codra():
    """The DPLP parser produces the expected output."""
    parser = sh.Command('./codra.sh')
    result = parser('input_short.txt')
    assert result.stdout == EXPECTED_OUTPUT, result.stderr.encode('utf-8')

