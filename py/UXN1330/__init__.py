import nitro
import logging, time
log = logging.getLogger(__name__)
from nitro_parts.Cypress import fx3 
from nitro_parts.Cypress.fx3 import program_fx3, program_fx3_prom
from nitro_parts.Numonyx import M25P

default_di_file = "BrooksEE/UXN1330/UXN1330.xml"
default_VID = 0x1fe1
default_PID = 0x1330

################################################################################
def get_dev(di_file=default_di_file, serial_num=None, bus_addr=None, VID=default_VID, PID=default_PID, timeout=10):
    """Opens a device and loads the DI file. If a serial_num is
       provided, this opens that device. You can also specify the VID
       and PID. This will wait until 'timeout' seconds for a device to
       connect."""

    dev=fx3.get_dev(di_file=di_file, serial_num=serial_num, bus_addr=bus_addr, VID=VID, PID=PID, timeout=timeout)
    return UXN1330(dev)


################################################################################
def init_dev(dev, di_file=default_di_file):
    """Initializes the device with the di files."""

    fx3.init_dev(dev,di_file)


################################################################################
def program_new_pcb(fx3_firmware, fpga_firmware, VID=default_VID, PID=default_PID, di_file=default_di_file):
    """
        This function does not require an open device.  It looks
        for the 1st unprogrammed pcb (by using the default Cypress
        Vendor ID/Product ID and attempts to load the fx2 firmware
        and fpga firmware files specified.

        :param fx3_firmware: The fx2 firmare ihx file. 
        :param fpga_firmware: The FPGA prom file for spi flash.
    """
    fx3.program_new_pcb(fx3_firmware, VID=VID, PID=PID, di_file=di_file)

################################################################################
def set_vcon (dev, volts=3.3, enable=True):
    """
        This function calculates the right potentiometer value for the vcon
        circuit and then enables the vcon chip. Provides approximately the
        intended voltage to the daughter board.

        r1 = D/127*100e3
        r2 = 22e3
        vout = 0.62*(r1/r2+1)
        D=22e3*(vout/.62-1) / 100e3 * 127
    """
    if enable:
        v=float(volts)
        d=int(round(22e3*(v/.62-1) / 100e3 * 127))
        d=max(d,0)
        d=min(d,127)
        log.debug ( "vcon pot value: %d" % d )
        dev.set('UXN1330','vcon_pot', d )

    dev.set('UXN1330','vcon_en', 1 if enable else 0 )
    # convert back to volts so user can check against input
    return 0 if not enable else .62*(d/127.*100e3/22e3+1)


################################################################################
class UXN1330(nitro.DevBase):


    ###################### FPGA methods ########################################
    def reboot_fpga(self):
        """Reboots the FPGA from its PROM"""
        log.info("Booting FPGA from SPI prom")
        self.set("FPGA_CTRL", "boot_fpga", 1);

    def program_fpga_prom(self, filename):
        """Reprograms spi flash with new prom file.  Forces a reboot the FPGA to run this bitfile when it is complete"""
        from nitro_parts.Numonyx import M25P
        self.set("FPGA_CTRL", "reset_fpga", 1) # reset FPGA
        M25P.program(self, filename, "FPGA_PROM_DATA", "FPGA_PROM_CTRL")
        self.reboot_fpga()
    

    def set_vcon(self,volts=3.3, enable=True):
        return set_vcon(self,volts, enable)
