"""
    Test module for FX3/UXN1330 device tests.  

    Prerequisites
    -------------

    * This module requires only that a UXN1330 board is plugged in.
"""

import types
import unittest

from test_Speed import *
from test_DRAM import *

#  quick hack to allow tests to 
# share the same module name in case desired
# to add a setUp and/or tearDown Module function
for t in dir():
    obj=locals().get(t,None)
    if type(obj) == types.TypeType and \
       issubclass(obj,unittest.TestCase):
        obj.__module__ = __name__

