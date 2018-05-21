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

EXPECTED_RS3 = """<?xml version='1.0' encoding='UTF-8'?>
<rst>
  <header>
    <relations>
      <rel name="Contrast" type="rst"/>
    </relations>
  </header>
  <body>
    <segment id="3" parent="5" relname="Contrast">Although they did n't like it ,</segment>
    <segment id="5" parent="1" relname="span">they accepted the offer .</segment>
    <group id="1" type="span"/>
  </body>
</rst>
"""

def test_codra():
    """The DPLP parser produces the expected output."""
    parser = sh.Command('./codra.sh')
    result = parser('input_short.txt')
    passed = result.stdout == EXPECTED_OUTPUT
    if not passed:
        return passed, result.stderr.encode('utf-8')

    converter = sh.Command('./codra2rs3.sh')
    result = converter('input_short.txt.dis')

    with open('input_short.txt.rs3', 'r') as rs3_file:
        return rs3_file.read() == EXPECTED_RS3, result.stderr.encode('utf-8')


if __name__ == '__main__':
    passed, err = test_codra()
    if not passed:
        sys.stderr.write("test_codra(): '{}' does not match expected output.\n".format(err))
        sys.exit(1)

