
from basetest import DevTestCase 

from time import time
import numpy, random

class TestRdwr(DevTestCase):
    """
        These tests read and write data to the DRAM and verifies that 
        data integrity is maintained.
    """

    def _sizes(self):
        yield 2
        yield 4
        yield 512
        yield 1024
        yield 1025
        yield 1023
        yield 2048
        for i in xrange ( 10 ):
            yield random.randint ( 2, 10*1024*1024 ) 


    def _testw(self,t):
        for s in self._sizes():
            r=numpy.asarray(numpy.random.randint(2**32,size=s),dtype=numpy.uint8)
            try:
                print t, "write", s
                self.dev.write(t,0,r,10000)
            except Exception, _inst:
                self.fail ( "Write to %s bytes=%d fail: %s" % ( t, s, str(_inst) ) )
    def _testr(self,t):
        for s in self._sizes():
            d=numpy.zeros( (s,), dtype=numpy.uint8)
            try:
                print t, "read", s
                self.dev.read(t,0,d,10000)
            except Exception, _inst:
                self.fail ( "Read from %s bytes=%d fail: %s" % ( t, s, str(_inst) ) )


    def testFX3write(self):
        """
            Write random data to the fx3 dummy terminals 
        """
        self._testw('DUMMY_FX3')
    def testFX3read(self):
        self._testr('DUMMY_FX3')
    def testFPGAread(self):
        self._testr('DUMMY_FPGA')

    def testFPGAwrite(self):
        self.skipTest('Causes usb reset.')
        self._testw('DUMMY_FPGA')


        


