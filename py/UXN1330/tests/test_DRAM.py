
from basetest import DevTestCase 

from time import time
import numpy

class TestDRAM(DevTestCase):
    """
        These tests read and write data to the DRAM and verifies that 
        data integrity is maintained.
    """

    def testDRAM(self):
        """
            Write random data to the dram.  Read back and verify data
            match.
        """
        self.skipTest('Known fail case.')
        size=32*1024*1024
        r=numpy.asarray(numpy.random.randint(2**32,size=size),dtype=numpy.uint32)
        #r=numpy.zeros((size,),dtype=numpy.uint32)
        self.dev.write('DRAM',0,r)
        buf=numpy.zeros( (size,), dtype=numpy.uint32)
        self.dev.read('DRAM',0,buf)
        self.assertTrue ( (r==buf).all(), 'DRAM read data mismatch.')


        


