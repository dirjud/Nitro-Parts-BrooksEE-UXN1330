from unittest import TestCase

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
        cls.dev=get_dev() 

    @classmethod
    def tearDownClass(cls):
        """
            Closes the device
        """
        cls.dev.close()

