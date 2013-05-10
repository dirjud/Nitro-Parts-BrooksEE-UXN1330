#
# Copyright (C) 2013 BrooksEE, LLC
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#

import nitro
from nitro import DeviceInterface, Terminal, Register, SubReg

di=DeviceInterface(
    name='UXN1330', 

    terminal_list=[
        ########################################################################
        Terminal(
            name='UXN1330',
            regAddrWidth=8,
            regDataWidth=8, # NOTE need to fix nitro get width
            register_list=[
                Register(name='version',
                         type='int',
                         mode='read',
                         subregs=[SubReg(name='minor', width=16),
                                  SubReg(name='major', width=16)],
                         comment="FX3 release version"
                         ),
                Register(name='lp_b',
                         mode='write',
                         type='int',
                         width=1,
                         addr=26,
                         comment='Write 0 to enable, 1 to disable low power mode' 
                         ),
                Register(name='v18_en',
                         mode='write',
                         type='int',
                         width=1,
                         addr=27,
                         comment='Write 1 or 0 to enable/disable 1.8 volts'
                         ),
            ]
        ),
	
        ########################################################################
        Terminal(
            name="SLAVE_I2C",
            regAddrWidth=8,
            regDataWidth=32,
            addr = 43,
            register_list = [
                Register(name = "uid",
                         type = "int",
                         mode = "read",
                         width = 32,
                         ),
                ]
            ),
        Terminal(
            name='DUMMY_FPGA',
            comment='Dummy FPGA Terminal',
            regAddrWidth=32, 
            regDataWidth=32,
            addr = 1023,
            ),
        Terminal(
            name='FPGA',
            comment='FPGA registers',
            addr=0x1,
            regAddrWidth=32, 
            regDataWidth=32,
            register_list=[
                Register(name='version',
                         type='int',
                         mode='read',
                         subregs=[SubReg(name="minor", width=16),
                                  SubReg(name="major", width=16),],
                         comment='FPGA release version',
                         ),
                Register(name='sw_reset',
                         type='int',
                         mode='write',
                         width=1,
                         comment='Software reset of the FPGA.',
                         init=0,
                         ),
                Register(name="led_sel",
                         type="int",
                         mode="write",
                         width=4, 
                         init=0, 
                         ),
                ]),

        ########################################################################
        Terminal(
            name='DRAM',
            comment='DRAM Read/Write Port',
            regAddrWidth=32, 
            regDataWidth=32,
            addr=509,
            ),

        Terminal(
            name='DRAM_CTRL',
            comment='DRAM control and status registers',
            regAddrWidth=32, 
            regDataWidth=32,
            addr=508,
            register_list=[
                Register(name='status',
                         type='int',
                         mode='read',
                         subregs=[SubReg(name="mcb", width=32, comment="Status Regsiter from MCB block"),
                                  SubReg(name="write_error", width=4, comment="Status indicator from dram fifo"),
                                  SubReg(name="write_underrun", width=4, comment="Status indicator from dram fifo"),
                                  SubReg(name="read_error", width=4, comment="Status indicator from dram fifo"),
                                  SubReg(name="read_overflow", width=4, comment="Status indicator from dram fifo"),
                                  SubReg(name='pll_locked',   width=1, comment='Indicates whether PLL generating SDRAM clock is locked.'),
                                  SubReg(name='calib_done',   width=1, comment='Indicates whether calibration is done so that MCB can be used.'),
                                  SubReg(name='selfrefresh_mode',   width=1, comment='Indicates whether PLL generating SDRAM clock is locked.'),
                                  SubReg(name="rst", width=1, comment="rst returned from the infrastructure block"),
                                  ],
                         comment='Status Register',
                         ),
                Register(name='mcb_reset',
                         type='trigger',
                         mode='write',
                         width=1,
                         comment="Resets the dram memory controller block (MCB).",
                         ),
                Register(name='mode',
                         type='int',
                         mode='write',
                         subregs=[SubReg(name='selfrefresh',init=0,width=1,comment='Puts dram controller in self refresh mode. See Xilinx UG388 MCB User Guide for more information'),
                                  ],
                         comment='Mode Register',
                         ),
                ]),

        ],
    )

di = nitro.load_di ( "Cypress/fx3/fx3.xml", di )
di = nitro.load_di("Xilinx/Spartan/Spartan.xml", di)
# parallel programming not supported on fx3
del di['PROGRAM_FPGA']

# add M25P terminals in
di = nitro.load_di ( "Numonyx/M25P/M25P.xml", di )
di['DATA'].name = 'FPGA_PROM_DATA'
di['CTRL'].name = 'FPGA_PROM_CTRL'



