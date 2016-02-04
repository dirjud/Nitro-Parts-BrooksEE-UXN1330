
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
        size=16*1024*1024
        r=numpy.asarray(numpy.random.randint(2**32,size=size),dtype=numpy.uint32)
        #r=numpy.zeros((size,),dtype=numpy.uint32)
        self.dev.write('DRAM',0,r)
        buf=numpy.zeros( (size,), dtype=numpy.uint32)
        self.dev.read('DRAM',0,buf)
        bad=(buf-r).nonzero()[0]
        if (len(bad)>0):
            print "bad elements: %d" % len(bad)
            for i in range(10 if len(bad)>10 else len(bad)):
                print "buf[%d]=%08x r[%d]=%08x" % ( bad[i], buf[bad[i]], bad[i], r[bad[i]] )
        self.assertTrue ( (r==buf).all(), 'DRAM read data mismatch' )


        


