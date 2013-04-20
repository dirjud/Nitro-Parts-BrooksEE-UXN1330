/**
 * Copyright (C) 2009 BrooksEE, LLC.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 **/
`timescale 1ps/1ps

module UXN1330_tb
  (

`ifdef USER_DATA_WIDTH
   inout [`USER_DATA_WIDTH-1:0] user_data
`endif

   
`ifdef verilator   
 `ifdef USER_DATA_WIDTH
   ,
 `endif
   input clk
`endif   

   );

`ifndef verilator
   reg   clk;
   initial clk=0;
   always #10417 clk = !clk; // # 48MHz clock
`endif

   wire [31:0] fx3_fd;
   wire [1:0]  fx3_fifo_addr;
   wire   fx3_dma_rdy_b;
   wire        fx3_ifclk, fx3_hics_b, fx3_sloe_b, fx3_slrd_b, fx3_slwr_b;
   wire        fx3_pktend_b, fx3_clkout, fx3_int_b;

   wire        sda, scl;
   wire        button = 0;
//   pullup pu1(sda);
//   pullup pu2(scl);
   
   wire [15:0]          header;         
   wire l10n,l10p,l11n,l11p,l1n,l1p,l2n,l2p,l32n,l32p,l33n,l33p,l34n,l34p;
   wire l35n,l35p,l36n,l36p,l37n,l37p,l38n,l38p,l39n,l39p,l3n,l3p,l40n,l40p;
   wire l41n,l41p,l42n,l42p,l47n,l47p,l4n,l4p,l50n,l50p,l51n,l51p,l5n,l5p;
   wire l62n,l62p,l63n,l63p,l64n,l64p,l65n,l65p,l66n,l66p,l6n,l6p,l7n,l7p;
   wire l8n,l8p,l9n,l9p;

   wire n1n, n1p, n29n, n29p, n30n, n30p, n31n, n31p, n32n, n32p, n33n, n33p;
   wire n34n, n34p, n35n, n35p, n36n, n36p, n37n, n37p, n38n, n38p, n39n, n39p;
   wire n40n, n40p, n41n, n41p, n42n, n42p, n43n, n43p, n44n, n44p, n45n, n45p;
   wire n46n, n46p, n47n, n47p, n48n, n48p, n49n, n49p, n50n, n50p, n51n, n51p;
   wire n52n, n52p, n53n, n53p, n61n, n61p, n74n, n74p;
   
   wire           led_b;          
   wire [14:0]          sdram_addr;     
   wire [2:0]           sdram_ba;
   wire [15:0]          sdram_dq;       
   wire sdram_cas_n, sdram_ck, sdram_ck_n, sdram_cke;
   wire sdram_ldm, sdram_ldqs, sdram_ldqs_n, sdram_odt, sdram_ras_n;
   wire sdram_rzq, sdram_udm, sdram_udqs, sdram_udqs_n, sdram_we_n, sdram_zio;  
   
   fx3 fx3
     (
      .clk                                 (clk),
      .fx3_ifclk                           (fx3_ifclk),
      .fx3_hics_b                          (fx3_hics_b),
      .fx3_sloe_b                          (fx3_sloe_b),
      .fx3_slrd_b                          (fx3_slrd_b),
      .fx3_slwr_b                          (fx3_slwr_b),
      .fx3_pktend_b                        (fx3_pktend_b),
      .fx3_fifo_addr                       (fx3_fifo_addr),
      .fx3_fd                              (fx3_fd),
      .fx3_dma_rdy_b                       (fx3_dma_rdy_b),
      .SCL                                 (scl),
      .SDA                                 (sda)
      );
   
   UXN1330 UXN1330
     (
      .fx3_ifclk                        (fx3_ifclk),
      .fx3_dma_rdy_b                    (fx3_dma_rdy_b),
      .fx3_hics_b                       (fx3_hics_b),
      .fx3_fifo_addr                    (fx3_fifo_addr),
      .fx3_pktend_b                     (fx3_pktend_b),
      .fx3_slrd_b                       (fx3_slrd_b),
      .fx3_slwr_b                       (fx3_slwr_b),
      .fx3_sloe_b                       (fx3_sloe_b),
      .fx3_int_b                        (fx3_int_b),
      .fx3_fd                           (fx3_fd),

      .button                           (button),
      .led_b                            (led_b),

      .sdram_addr                       (sdram_addr),
      .sdram_ba                         (sdram_ba),
      .sdram_cas_n                      (sdram_cas_n),
      .sdram_ck                         (sdram_ck),
      .sdram_ck_n                       (sdram_ck_n),
      .sdram_cke                        (sdram_cke),
      .sdram_ldm                        (sdram_ldm),
      .sdram_ldqs                       (sdram_ldqs),
      .sdram_ldqs_n                     (sdram_ldqs_n),
      .sdram_odt                        (sdram_odt),
      .sdram_ras_n                      (sdram_ras_n),
      .sdram_udm                        (sdram_udm),
      .sdram_udqs                       (sdram_udqs),
      .sdram_udqs_n                     (sdram_udqs_n),
      .sdram_we_n                       (sdram_we_n),
      .sdram_dq                         (sdram_dq),
      .sdram_rzq                        (sdram_rzq),
      .sdram_zio                        (sdram_zio),

      .l10n                             (l10n),
      .l10p                             (l10p),
      .l11n                             (l11n),
      .l11p                             (l11p),
      .l1p                              (l1p),
      .l1n                              (l1n),
      .l2n                              (l2n),
      .l2p                              (l2p),
      .l32n                             (l32n),
      .l32p                             (l32p),
      .l33n                             (l33n),
      .l33p                             (l33p),
      .l34n                             (l34n),
      .l34p                             (l34p),
      .l35n                             (l35n),
      .l35p                             (l35p),
      .l36n                             (l36n),
      .l36p                             (l36p),
      .l37n                             (l37n),
      .l37p                             (l37p),
      .l38n                             (l38n),
      .l38p                             (l38p),
      .l39n                             (l39n),
      .l39p                             (l39p),
      .l3n                              (l3n),
      .l3p                              (l3p),
      .l40n                             (l40n),
      .l40p                             (l40p),
      .l41n                             (l41n),
      .l41p                             (l41p),
      .l42n                             (l42n),
      .l42p                             (l42p),
      .l47n                             (l47n),
      .l47p                             (l47p),
      .l4n                              (l4n),
      .l4p                              (l4p),
      .l50n                             (l50n),
      .l50p                             (l50p),
      .l51n                             (l51n),
      .l51p                             (l51p),
      .l5n                              (l5n),
      .l5p                              (l5p),
      .l62n                             (l62n),
      .l62p                             (l62p),
      .l63n                             (l63n),
      .l63p                             (l63p),
      .l64n                             (l64n),
      .l64p                             (l64p),
      .l65n                             (l65n),
      .l65p                             (l65p),
      .l66n                             (l66n),
      .l66p                             (l66p),
      .l6n                              (l6n),
      .l6p                              (l6p),
      .l7n                              (l7n),
      .l7p                              (l7p),
      .l8n                              (l8n),
      .l8p                              (l8p),
      .l9n                              (l9n),
      .l9p                              (l9p),

      .n1n                              (n1n),
      .n1p                              (n1p),
      .n29n                             (n29n),
      .n29p                             (n29p),
      .n30n                             (n30n),
      .n30p                             (n30p),
      .n31n                             (n31n),
      .n31p                             (n31p),
      .n32n                             (n32n),
      .n32p                             (n32p),
      .n33n                             (n33n),
      .n33p                             (n33p),
      .n34n                             (n34n),
      .n34p                             (n34p),
      .n35n                             (n35n),
      .n35p                             (n35p),
      .n36n                             (n36n),
      .n36p                             (n36p),
      .n37n                             (n37n),
      .n37p                             (n37p),
      .n38n                             (n38n),
      .n38p                             (n38p),
      .n39n                             (n39n),
      .n39p                             (n39p),
      .n40n                             (n40n),
      .n40p                             (n40p),
      .n41n                             (n41n),
      .n41p                             (n41p),
      .n42n                             (n42n),
      .n42p                             (n42p),
      .n43n                             (n43n),
      .n43p                             (n43p),
      .n44n                             (n44n),
      .n44p                             (n44p),
      .n45n                             (n45n),
      .n45p                             (n45p),
      .n46n                             (n46n),
      .n46p                             (n46p),
      .n47n                             (n47n),
      .n47p                             (n47p),
      .n48n                             (n48n),
      .n48p                             (n48p),
      .n49n                             (n49n),
      .n49p                             (n49p),
      .n50n                             (n50n),
      .n50p                             (n50p),
      .n51n                             (n51n),
      .n51p                             (n51p),
      .n52n                             (n52n),
      .n52p                             (n52p),
      .n53n                             (n53n),
      .n53p                             (n53p),
      .n61n                             (n61n),
      .n61p                             (n61p),
      .n74n                             (n74n),
      .n74p                             (n74p)
      );

`ifndef verilator
   pulldown rzq_pulldown(sdram_rzq);

   ddr2_model_c3 u_mem_c3
     (
      .ck         (sdram_ck),
      .ck_n       (sdram_ck_n),
      .cke        (sdram_cke),
      .cs_n       (1'b0),
      .ras_n      (sdram_ras_n),
      .cas_n      (sdram_cas_n),
      .we_n       (sdram_we_n),
      .dm_rdqs    ({sdram_udm, sdram_ldm}),
      .ba         (sdram_ba[1:0]),
      .addr       (sdram_addr[12:0]),
      .dq         (sdram_dq),
      .dqs        ({sdram_udqs,  sdram_ldqs}),
      .dqs_n      ({sdram_udqs_n,sdram_ldqs_n}),
      .rdqs_n     (),
      .odt        (sdram_odt)
      );
`endif
   
   UXN1330DaughterBoard UXN1330DaughterBoard
     (
      .scl                              (scl),
      .sda                              (sda),
`ifdef USER_DATA_WIDTH
      .user_data(user_data),
`endif      
      
      .l10n                             (l10n),
      .l10p                             (l10p),
      .l11n                             (l11n),
      .l11p                             (l11p),
      .l1p                              (l1p),
      .l1n                              (l1n),
      .l2n                              (l2n),
      .l2p                              (l2p),
      .l32n                             (l32n),
      .l32p                             (l32p),
      .l33n                             (l33n),
      .l33p                             (l33p),
      .l34n                             (l34n),
      .l34p                             (l34p),
      .l35n                             (l35n),
      .l35p                             (l35p),
      .l36n                             (l36n),
      .l36p                             (l36p),
      .l37n                             (l37n),
      .l37p                             (l37p),
      .l38n                             (l38n),
      .l38p                             (l38p),
      .l39n                             (l39n),
      .l39p                             (l39p),
      .l3n                              (l3n),
      .l3p                              (l3p),
      .l40n                             (l40n),
      .l40p                             (l40p),
      .l41n                             (l41n),
      .l41p                             (l41p),
      .l42n                             (l42n),
      .l42p                             (l42p),
      .l47n                             (l47n),
      .l47p                             (l47p),
      .l4n                              (l4n),
      .l4p                              (l4p),
      .l50n                             (l50n),
      .l50p                             (l50p),
      .l51n                             (l51n),
      .l51p                             (l51p),
      .l5n                              (l5n),
      .l5p                              (l5p),
      .l62n                             (l62n),
      .l62p                             (l62p),
      .l63n                             (l63n),
      .l63p                             (l63p),
      .l64n                             (l64n),
      .l64p                             (l64p),
      .l65n                             (l65n),
      .l65p                             (l65p),
      .l66n                             (l66n),
      .l66p                             (l66p),
      .l6n                              (l6n),
      .l6p                              (l6p),
      .l7n                              (l7n),
      .l7p                              (l7p),
      .l8n                              (l8n),
      .l8p                              (l8p),
      .l9n                              (l9n),
      .l9p                              (l9p),

      .n1n                              (n1n),
      .n1p                              (n1p),
      .n29n                             (n29n),
      .n29p                             (n29p),
      .n30n                             (n30n),
      .n30p                             (n30p),
      .n31n                             (n31n),
      .n31p                             (n31p),
      .n32n                             (n32n),
      .n32p                             (n32p),
      .n33n                             (n33n),
      .n33p                             (n33p),
      .n34n                             (n34n),
      .n34p                             (n34p),
      .n35n                             (n35n),
      .n35p                             (n35p),
      .n36n                             (n36n),
      .n36p                             (n36p),
      .n37n                             (n37n),
      .n37p                             (n37p),
      .n38n                             (n38n),
      .n38p                             (n38p),
      .n39n                             (n39n),
      .n39p                             (n39p),
      .n40n                             (n40n),
      .n40p                             (n40p),
      .n41n                             (n41n),
      .n41p                             (n41p),
      .n42n                             (n42n),
      .n42p                             (n42p),
      .n43n                             (n43n),
      .n43p                             (n43p),
      .n44n                             (n44n),
      .n44p                             (n44p),
      .n45n                             (n45n),
      .n45p                             (n45p),
      .n46n                             (n46n),
      .n46p                             (n46p),
      .n47n                             (n47n),
      .n47p                             (n47p),
      .n48n                             (n48n),
      .n48p                             (n48p),
      .n49n                             (n49n),
      .n49p                             (n49p),
      .n50n                             (n50n),
      .n50p                             (n50p),
      .n51n                             (n51n),
      .n51p                             (n51p),
      .n52n                             (n52n),
      .n52p                             (n52p),
      .n53n                             (n53n),
      .n53p                             (n53p),
      .n61n                             (n61n),
      .n61p                             (n61p),
      .n74n                             (n74n),
      .n74p                             (n74p)
            );
   
   

endmodule
// Local Variables:
// verilog-library-flags:("-y ../rtl")
// End:

