from unittest import TestCase

import os

from nitro_parts.BrooksEE.UXN1330 import get_dev

class DevTestCase(TestCase):
    """
        Classes in this module can derive from this
        class to automate retrieving a device.  The device
        is opened but not initialized.  Any initialization should
        be performed at the TestCase level.
    """
    
    @classmethod
    def setUpClass(cls):
        """
            Opens a device and attaches to class for usage as 
            `self.dev`
        """
        pid=os.environ.has_key('PID') and int(os.environ['PID'],16) or 0x1330
        cls.dev=get_dev(PID=pid) 

    @classmethod
    def tearDownClass(cls):
        """
            Closes the device
        """
        cls.dev.close()

