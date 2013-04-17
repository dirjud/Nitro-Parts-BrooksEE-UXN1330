#
# Copyright (C) 2009 Ubixum, Inc. 
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

di = nitro.load_di ( "Cypress/fx3/fx3.xml" )
di.name='UXN1330'

# add M25P terminals in
di = nitro.load_di ( "Numonyx/M25P/M25P.xml", di )
di['DATA'].name = 'FPGA_PROM_DATA'
di['CTRL'].name = 'FPGA_PROM_CTRL'

