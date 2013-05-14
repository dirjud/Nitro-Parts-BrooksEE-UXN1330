import VUXN1330_tb as tb
from nitro_parts.BrooksEE import UXN1330
#from nitro_parts.BrooksEE.UXN1330 import ubitest
import logging
logging.basicConfig(level=logging.DEBUG)
import numpy, conf


if 1:
    tb.init("sim.vcd")
else:
    tb.init()

dev = UXN1330.UXN1330(tb.get_dev())
d = {}
execfile("../terminals.py", d)
dev.set_di(d["di"])


#t = ubitest.DramPatTest(config)
try:
    ## TEST DRAM access
    buf1 = numpy.random.random_integers(0, 0xFFFFFFFF, 32).astype(numpy.uint32)
    dev.write("DRAM", 0, buf1, 2)
    
    buf2 = numpy.zeros_like(buf1)
    dev.read("DRAM", 0, buf2, 1)
    
    if (buf1 == buf2).all():
        print "**** DRAM TEST PASSED ****"
    else:
        raise Exception("**** DRAM TEST FAILED ****")

    ## Test DUMMY_FGPA Access
    M = 4*10
    dev.write("DUMMY_FPGA", 0, numpy.random.randint(0,255,M).astype(numpy.uint8))
    
    x = numpy.zeros(40, dtype=numpy.uint32)
    dev.read("DUMMY_FPGA", 0, x)
    if (x == 0xBBAA9988).all():
        print "**** FPGA DUMMY TERM READ PASSED ****"
    else:
        raise Exception("**** FPGA DUMMY TERM READ PASSED ****")

    ## Test FPGA terminal access
    version = numpy.zeros(2, dtype=numpy.uint16)
    dev.read("FPGA", "version", version)
    print "FGPA version: " + str(version)
    

finally:

    tb.adv(100)
    tb.end()
