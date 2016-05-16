
from basetest import DevTestCase 

from time import time

class TestSpeed(DevTestCase):
    """
        This class verifies raw USB speed for reading and writing to the FPGA.
        Expected minimum speeds are 35 mb/s for USB2 and 100 mb/s for USB3
        read and write.  These are conservative but sufficient to determine if 
        the device is operating in USB3 mode properly.
    """

    def _testSpeed(self,t,f):
        """
            f is read/write, 
        """
        fx3 = self.dev.get_pid() == 0x1330
        usb3 = fx3 and self.dev.get('FX3','USB3')

        MB=300

        buf='\x00'*1024*1024*MB

        t1=time()
        f(t,0,buf, 4000)
        t2=time()
        mbs=float(MB)/(t2-t1) 

        if usb3 and f==self.dev.read:
            target_min = 100
        else:
            target_min = 35

        self.assertGreaterEqual( mbs, target_min, "USB speed slower than expected: %0.2f" % mbs )
        print "speed", mbs

    def testFX3Read(self):
        self._testSpeed('DUMMY_FX3',self.dev.read)

    def testFX3Write(self):
        self._testSpeed('DUMMY_FX3',self.dev.write)

    def testFPGARead(self):
        self._testSpeed('DUMMY_FPGA',self.dev.read)

    def testFPGAWrite(self):
        self._testSpeed('DUMMY_FPGA',self.dev.write)

    def testUSB(self):
        """
            This test fails if a USB3 device is attached but is not recognized
            as a USB3 device on the bus.
        """
        if self.dev.get_pid() == 0x1330 and \
           not self.dev.get('FX3','USB3'):
            self.fail ( "USB3 device but recognized as USB2 on bus." )


