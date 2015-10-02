
from basetest import DevTestCase 

from time import time

class TestSpeed(DevTestCase):
    """
        This class verifies raw USB speed for reading and writing to the FPGA.
        Expected minimum speeds are 35 mb/s for USB2 and 100 mb/s for USB3
        read and write.  These are conservative but sufficient to determine if 
        the device is operating in USB3 mode properly.
    """

    def _testSpeed(self,f):
        """
            f is read/write, 
        """
        fx3 = self.dev.get_pid() == 0x1330
        usb3 = fx3 and self.dev.get('FX3','USB3')

        buf='\x00'*1024*1024*100

        t1=time()
        f('DUMMY_FPGA',0,buf)
        t2=time()
        mbs=100.0/(t2-t1) 

        if usb3:
            target_min = 100
        else:
            target_min = 35

        self.assertGreaterEqual( mbs, target_min, "USB speed slower than expected: %0.2f" % mbs )
        print "speed", mbs

    def testRead(self):
        self._testSpeed(self.dev.read)

    def testWrite(self):
        self._testSpeed(self.dev.write)

    def testUSB(self):
        """
            This test fails if a USB3 device is attached but is not recognized
            as a USB3 device on the bus.
        """
        if self.dev.get_pid() == 0x1330 and \
           not self.dev.get('FX3','USB3'):
            self.fail ( "USB3 device but recognized as USB2 on bus." )


