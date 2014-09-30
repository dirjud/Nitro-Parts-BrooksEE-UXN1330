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

// This modules the top level FPGA implementation for the board UXN1330.
// This instantiates the host interface module to control communication
// with the Cypress FX3. This module is reusable for different designs.
// The user must implement the ProjectTop module.
//
// If the `define DISABLE_SDRAM is defined, then the sdram module is
// not implemented and sdram signals are tied off to save the logic.

//`define DISABLE_SDRAM

`include "terminals_defs.v"

module UXN1330
  (
   input 	 fx3_ifclk,
   input 	 fx3_dma_rdy_b,
   input 	 fx3_hics_b,
   output [1:0]  fx3_fifo_addr,
   output 	 fx3_pktend_b,
   output 	 fx3_slrd_b,
   output 	 fx3_slwr_b,
   output 	 fx3_sloe_b,
   output 	 fx3_int_b,
   inout [31:0]  fx3_fd,

   input         button,
   output 	 led_b,
   inout [15:0]  header,
   
`ifndef DISABLE_SDRAM
   output [14:0] sdram_addr,
   output [2:0]  sdram_ba,
   output 	 sdram_cas_n,
   output 	 sdram_ck,
   output 	 sdram_ck_n,
   output 	 sdram_cke,
   output 	 sdram_ldm,
   output 	 sdram_ldqs,
   output 	 sdram_ldqs_n,
   output 	 sdram_odt,
   output 	 sdram_ras_n,
   output 	 sdram_udm,
   output 	 sdram_udqs,
   output 	 sdram_udqs_n,
   output 	 sdram_we_n,
   inout [15:0]  sdram_dq,
   inout 	 sdram_rzq,
   inout 	 sdram_zio,
`endif
   
   inout 	 l10n,
   inout 	 l10p,
   inout 	 l11n,
   inout 	 l11p,
   inout 	 l1p,
   inout 	 l1n,
   inout 	 l2n,
   inout 	 l2p,
   inout 	 l32n,
   inout 	 l32p,
   inout 	 l33n,
   inout 	 l33p,
   inout 	 l34n,
   inout 	 l34p,
   inout 	 l35n,
   inout 	 l35p,
   inout 	 l36n,
   inout 	 l36p,
   inout 	 l37n,
   inout 	 l37p,
   inout 	 l38n,
   inout 	 l38p,
   inout 	 l39n,
   inout 	 l39p,
   inout 	 l3n,
   inout 	 l3p,
   inout 	 l40n,
   inout 	 l40p,
   inout 	 l41n,
   inout 	 l41p,
   inout 	 l42n,
   inout 	 l42p,
   inout 	 l47n,
   inout 	 l47p,
   inout 	 l4n,
   inout 	 l4p,
   inout 	 l50n,
   inout 	 l50p,
   inout 	 l51n,
   inout 	 l51p,
   inout 	 l5n,
   inout 	 l5p,
   inout 	 l62n,
   inout 	 l62p,
   inout 	 l63n,
   inout 	 l63p,
   inout 	 l64n,
   inout 	 l64p,
   inout 	 l65n,
   inout 	 l65p,
   inout 	 l66n,
   inout 	 l66p,
   inout 	 l6n,
   inout 	 l6p,
   inout 	 l7n,
   inout 	 l7p,
   inout 	 l8n,
   inout 	 l8p,
   inout 	 l9n,
   inout 	 l9p,
   
   inout 	 n1n,
   inout 	 n1p,
   inout 	 n29n,
   inout 	 n29p,
   inout 	 n30n,
   inout 	 n30p,
   inout 	 n31n,
   inout 	 n31p,
   inout 	 n32n,
   inout 	 n32p,
   inout 	 n33n,
   inout 	 n33p,
   inout 	 n34n,
   inout 	 n34p,
   inout 	 n35n,
   inout 	 n35p,
   inout 	 n36n,
   inout 	 n36p,
   inout 	 n37n,
   inout 	 n37p,
   inout 	 n38n,
   inout 	 n38p,
   inout 	 n39n,
   inout 	 n39p,
   inout 	 n40n,
   inout 	 n40p,
   inout 	 n41n,
   inout 	 n41p,
   inout 	 n42n,
   inout 	 n42p,
   inout 	 n43n,
   inout 	 n43p,
   inout 	 n44n,
   inout 	 n44p,
   inout 	 n45n,
   inout 	 n45p,
   inout 	 n46n,
   inout 	 n46p,
   inout 	 n47n,
   inout 	 n47p,
   inout 	 n48n,
   inout 	 n48p,
   inout 	 n49n,
   inout 	 n49p,
   inout 	 n50n,
   inout 	 n50p,
   inout 	 n51n,
   inout 	 n51p,
   inout 	 n52n,
   inout 	 n52p,
`ifndef VREF_BANKN
   inout  	 n53n, // synthesis attribute LOC of n53n is N14 */
`endif
   inout 	 n53p,
   inout 	 n61n,
   inout 	 n61p,
   inout 	 n74n,
   inout 	 n74p
   );

   
   wire [31:0]  di_len, di_reg_addr, di_reg_datai, pt_di_reg_datao;
   wire [15:0]  di_term_addr, pt_di_transfer_status;
   
   reg [31:0] 	di_reg_datao;
   reg [15:0]	di_transfer_status;
   reg          di_read_rdy,  di_write_rdy;
   wire di_read, di_read_mode, pt_di_read_rdy, di_read_req;
   wire di_write, di_write_mode, pt_di_write_rdy;
   wire ifclk, resetb;                  

   wire         p0_cmd_en;
   wire [2:0]   p0_cmd_instr;
   wire [5:0]   p0_cmd_bl;
   wire [29:0]  p0_cmd_byte_addr;
   wire         p0_cmd_empty;
   wire         p0_cmd_full;
   wire         p0_wr_en;
   wire [3:0]   p0_wr_mask = 4'h0;
   wire [31:0]  p0_wr_data;
   wire         p0_wr_full;
   wire         p0_wr_empty;
   wire [6:0]   p0_wr_count;
   wire         p0_wr_underrun;
   wire         p0_wr_error;
   wire         p0_rd_en;
   wire [31:0]  p0_rd_data;
   wire         p0_rd_full;
   wire         p0_rd_empty;
   wire [6:0]   p0_rd_count;
   wire         p0_rd_overflow;
   wire         p0_rd_error;

   wire         p1_clk          , p2_clk          , p3_clk          ;
   wire         p1_cmd_en       , p2_cmd_en       , p3_cmd_en       ;
   wire [2:0]   p1_cmd_instr    , p2_cmd_instr    , p3_cmd_instr    ;
   wire [5:0]   p1_cmd_bl       , p2_cmd_bl       , p3_cmd_bl       ;
   wire [29:0]  p1_cmd_byte_addr, p2_cmd_byte_addr, p3_cmd_byte_addr;
   wire         p1_cmd_empty    , p2_cmd_empty    , p3_cmd_empty    ;
   wire         p1_cmd_full     , p2_cmd_full     , p3_cmd_full     ;
   wire         p1_wr_en        , p2_wr_en        , p3_wr_en        ;
   wire [3:0]   p1_wr_mask      , p2_wr_mask      , p3_wr_mask      ;
   wire [31:0]  p1_wr_data      , p2_wr_data      , p3_wr_data      ;
   wire         p1_wr_full      , p2_wr_full      , p3_wr_full      ;
   wire         p1_wr_empty     , p2_wr_empty     , p3_wr_empty     ;
   wire [6:0]   p1_wr_count     , p2_wr_count     , p3_wr_count     ;
   wire         p1_wr_underrun  , p2_wr_underrun  , p3_wr_underrun  ;
   wire         p1_wr_error     , p2_wr_error     , p3_wr_error     ;
   wire         p1_rd_en        , p2_rd_en        , p3_rd_en        ;
   wire [31:0]  p1_rd_data      , p2_rd_data      , p3_rd_data      ;
   wire         p1_rd_full      , p2_rd_full      , p3_rd_full      ;
   wire         p1_rd_empty     , p2_rd_empty     , p3_rd_empty     ;
   wire [6:0]   p1_rd_count     , p2_rd_count     , p3_rd_count     ;
   wire         p1_rd_overflow  , p2_rd_overflow  , p3_rd_overflow  ;
   wire         p1_rd_error     , p2_rd_error     , p3_rd_error     ;
   
   BUFG ifclk_bufg(.I(fx3_ifclk), .O(ifclk));
   
   wire [31:0] 	fx3_fd_out, fx3_fd_in;
   wire 	fx3_fd_oe;
   assign fx3_fd    = (fx3_fd_oe) ? fx3_fd_out : 32'bZZZZ;
   assign fx3_fd_in = fx3_fd;

`ifdef MULTI_HOST
   wire [15:0] 	di_term_addr0      , di_term_addr1      ;
   wire [31:0] 	di_reg_addr0       , di_reg_addr1       ;
   wire [31:0] 	di_len0            , di_len1            ;
   wire 	di_read_mode0      , di_read_mode1      ;
   wire 	di_read_req0       , di_read_req1       ;
   wire 	di_read0           , di_read1           ;
   wire 	di_read_rdy0       , di_read_rdy1       ;
   wire [31:0] 	di_reg_datao0      , di_reg_datao1      ;
   wire 	di_write0          , di_write1          ;
   wire 	di_write_rdy0      , di_write_rdy1      ;
   wire 	di_write_mode0     , di_write_mode1     ;
   wire [31:0] 	di_reg_datai0      , di_reg_datai1      ;
   wire [15:0] 	di_transfer_status0, di_transfer_status1;
`endif
	
   Fx3HostInterface Fx3HostInterface
     (
      .ifclk(ifclk),
      .resetb(resetb),

`ifdef MULTI_HOST
      .di_term_addr (di_term_addr0 ),
      .di_reg_addr  (di_reg_addr0  ),
      .di_len       (di_len0       ),
      .di_read_mode (di_read_mode0 ),
      .di_read_req  (di_read_req0  ),
      .di_read      (di_read0      ),
      .di_read_rdy  (di_read_rdy0  ),
      .di_reg_datao (di_reg_datao0 ),
      .di_write     (di_write0     ),
      .di_write_rdy (di_write_rdy0 ),
      .di_write_mode(di_write_mode0),
      .di_reg_datai (di_reg_datai0 ),
      .di_transfer_status(di_transfer_status0),
`else
      .di_term_addr (di_term_addr ),
      .di_reg_addr  (di_reg_addr  ),
      .di_len       (di_len       ),
      .di_read_mode (di_read_mode ),
      .di_read_req  (di_read_req  ),
      .di_read      (di_read      ),
      .di_read_rdy  (di_read_rdy  ),
      .di_reg_datao (di_reg_datao ),
      .di_write     (di_write     ),
      .di_write_rdy (di_write_rdy ),
      .di_write_mode(di_write_mode),
      .di_reg_datai (di_reg_datai ),
      .di_transfer_status(di_transfer_status),
`endif      

      .fx3_hics_b(fx3_hics_b),
      .fx3_dma_rdy_b(fx3_dma_rdy_b),
      .fx3_sloe_b(fx3_sloe_b),
      .fx3_slrd_b(fx3_slrd_b),
      .fx3_slwr_b(fx3_slwr_b), 
      .fx3_pktend_b(fx3_pktend_b),
      .fx3_fifo_addr(fx3_fifo_addr),
      .fx3_fd_out(fx3_fd_out),
      .fx3_fd_in(fx3_fd_in),
      .fx3_fd_oe(fx3_fd_oe)

      );

`ifdef MULTI_HOST
   wire 	O_di_read_rdy[0:1];
   wire 	O_di_write_rdy[0:1];
   wire [31:0] 	O_di_reg_datao[0:1];
   wire [15:0] 	O_di_transfer_status[0:1];
   assign di_read_rdy0        = O_di_read_rdy[0];
   assign di_write_rdy0       = O_di_write_rdy[0];
   assign di_reg_datao0       = O_di_reg_datao[0];
   assign di_transfer_status0 = O_di_transfer_status[0];
   assign di_read_rdy1        = O_di_read_rdy[1];
   assign di_write_rdy1       = O_di_write_rdy[1];
   assign di_reg_datao1       = O_di_reg_datao[1];
   assign di_transfer_status1 = O_di_transfer_status[1];
   
   hi_arbitor #(.NUM_HOSTS(2))
   hi_arbitor
     (
      .ifclk(ifclk),
      .resetb(resetb),
      .I_di_term_addr ('{ di_term_addr1  , di_term_addr0  }),
      .I_di_reg_addr  ('{ di_reg_addr1   , di_reg_addr0   }),
      .I_di_len       ('{ di_len1        , di_len0        }),
      .I_di_read_mode ('{ di_read_mode1  , di_read_mode0  }),
      .I_di_read_req  ('{ di_read_req1   , di_read_req0   }),
      .I_di_read      ('{ di_read1       , di_read0       }),
      .I_di_write     ('{ di_write1      , di_write0      }),
      .I_di_write_mode('{ di_write_mode1 , di_write_mode0 }),
      .I_di_reg_datai ('{ di_reg_datai1  , di_reg_datai0  }),
      .O_di_read_rdy       (O_di_read_rdy       ),
      .O_di_write_rdy      (O_di_write_rdy      ),
      .O_di_reg_datao      (O_di_reg_datao      ),
      .O_di_transfer_status(O_di_transfer_status),
      .di_term_addr,
      .di_reg_addr,
      .di_len,
      .di_read_mode,
      .di_read_req,
      .di_read,
      .di_write,
      .di_write_mode,
      .di_reg_datai,
      .di_read_rdy,
      .di_write_rdy,
      .di_reg_datao,
      .di_transfer_status
   );
`endif

   
   ProjectTop ProjectTop
     (
      .resetb                           (resetb),
      .ifclk                            (ifclk),

      .fx3_int_b                        (fx3_int_b),
      .di_term_addr                     (di_term_addr),
      .di_reg_addr                      (di_reg_addr),
      .di_len                           (di_len),
      .di_read_mode                     (di_read_mode),
      .di_read_req                      (di_read_req),
      .di_read                          (di_read),
      .di_write_mode                    (di_write_mode),
      .di_write                         (di_write),
      .di_reg_datai                     (di_reg_datai),
      .di_read_rdy                      (pt_di_read_rdy),
      .di_reg_datao                     (pt_di_reg_datao),
      .di_write_rdy                     (pt_di_write_rdy),
      .di_transfer_status               (pt_di_transfer_status),

      .button                           (button),
      .led_b                            (led_b),
      .header                           (header),
      
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
`ifndef VREF_BANKN
      .n53n                             (n53n),
`endif
      .n53p                             (n53p),
      .n61n                             (n61n),
      .n61p                             (n61p),
      .n74n                             (n74n),
      .n74p                             (n74p),

`ifdef MULTI_HOST
      .di_term_addr1                    (di_term_addr1),
      .di_reg_addr1                     (di_reg_addr1),
      .di_len1                          (di_len1),
      .di_read_mode1                    (di_read_mode1),
      .di_read_req1                     (di_read_req1),
      .di_read1                         (di_read1),
      .di_write_mode1                   (di_write_mode1),
      .di_write1                        (di_write1),
      .di_reg_datai1                    (di_reg_datai1),
      .di_read_rdy1                     (di_read_rdy1),
      .di_reg_datao1                    (di_reg_datao1),
      .di_write_rdy1                    (di_write_rdy1),
      .di_transfer_status1              (di_transfer_status1),
`endif      
      
      .p1_clk                           (p1_clk),
      .p1_cmd_en                        (p1_cmd_en),
      .p1_cmd_instr                     (p1_cmd_instr[2:0]),
      .p1_cmd_bl                        (p1_cmd_bl[5:0]),
      .p1_cmd_byte_addr                 (p1_cmd_byte_addr[29:0]),
      .p1_wr_en                         (p1_wr_en),
      .p1_wr_mask                       (p1_wr_mask[3:0]),
      .p1_wr_data                       (p1_wr_data[31:0]),
      .p1_rd_en                         (p1_rd_en),
      .p2_clk                           (p2_clk),
      .p2_cmd_en                        (p2_cmd_en),
      .p2_cmd_instr                     (p2_cmd_instr[2:0]),
      .p2_cmd_bl                        (p2_cmd_bl[5:0]),
      .p2_cmd_byte_addr                 (p2_cmd_byte_addr[29:0]),
      .p2_wr_en                         (p2_wr_en),
      .p2_wr_mask                       (p2_wr_mask[3:0]),
      .p2_wr_data                       (p2_wr_data[31:0]),
      .p2_rd_en                         (p2_rd_en),
      .p3_clk                           (p3_clk),
      .p3_cmd_en                        (p3_cmd_en),
      .p3_cmd_instr                     (p3_cmd_instr[2:0]),
      .p3_cmd_bl                        (p3_cmd_bl[5:0]),
      .p3_cmd_byte_addr                 (p3_cmd_byte_addr[29:0]),
      .p3_wr_en                         (p3_wr_en),
      .p3_wr_mask                       (p3_wr_mask[3:0]),
      .p3_wr_data                       (p3_wr_data[31:0]),
      .p3_rd_en                         (p3_rd_en),

      .p1_cmd_empty                     (p1_cmd_empty),
      .p1_cmd_full                      (p1_cmd_full),
      .p1_wr_full                       (p1_wr_full),
      .p1_wr_empty                      (p1_wr_empty),
      .p1_wr_count                      (p1_wr_count[6:0]),
      .p1_wr_underrun                   (p1_wr_underrun),
      .p1_wr_error                      (p1_wr_error),
      .p1_rd_data                       (p1_rd_data[31:0]),
      .p1_rd_full                       (p1_rd_full),
      .p1_rd_empty                      (p1_rd_empty),
      .p1_rd_count                      (p1_rd_count[6:0]),
      .p1_rd_overflow                   (p1_rd_overflow),
      .p1_rd_error                      (p1_rd_error),
      .p2_cmd_empty                     (p2_cmd_empty),
      .p2_cmd_full                      (p2_cmd_full),
      .p2_wr_full                       (p2_wr_full),
      .p2_wr_empty                      (p2_wr_empty),
      .p2_wr_count                      (p2_wr_count[6:0]),
      .p2_wr_underrun                   (p2_wr_underrun),
      .p2_wr_error                      (p2_wr_error),
      .p2_rd_data                       (p2_rd_data[31:0]),
      .p2_rd_full                       (p2_rd_full),
      .p2_rd_empty                      (p2_rd_empty),
      .p2_rd_count                      (p2_rd_count[6:0]),
      .p2_rd_overflow                   (p2_rd_overflow),
      .p2_rd_error                      (p2_rd_error),
      .p3_cmd_empty                     (p3_cmd_empty),
      .p3_cmd_full                      (p3_cmd_full),
      .p3_wr_full                       (p3_wr_full),
      .p3_wr_empty                      (p3_wr_empty),
      .p3_wr_count                      (p3_wr_count[6:0]),
      .p3_wr_underrun                   (p3_wr_underrun),
      .p3_wr_error                      (p3_wr_error),
      .p3_rd_data                       (p3_rd_data[31:0]),
      .p3_rd_full                       (p3_rd_full),
      .p3_rd_empty                      (p3_rd_empty),
      .p3_rd_count                      (p3_rd_count[6:0]),
      .p3_rd_overflow                   (p3_rd_overflow),
      .p3_rd_error                      (p3_rd_error)
      );


`ifndef DISABLE_SDRAM
   wire status_pll_locked, status_calib_done_wire, status_selfrefresh_mode;
   wire [3:0] status_write_error    = { p3_wr_error,   p2_wr_error,   p1_wr_error,   p0_wr_error    };
   wire [3:0] status_write_underrun = { p3_wr_underrun,p2_wr_underrun,p1_wr_underrun,p0_wr_underrun };
   wire [3:0] status_read_error     = { p3_rd_error,   p2_rd_error,   p1_rd_error,   p0_rd_error    };
   wire [3:0] status_read_overflow  = { p3_rd_overflow,p2_rd_overflow,p1_rd_overflow,p0_rd_overflow };
//   wire       status_rst_wire;
   reg 	      status_rst;
   
   reg  status_calib_done;
   wire [31:0]  status_mcb = 0;
   wire         di_clk = ifclk;
   assign status_pll_locked = 1;
   assign status_selfrefresh_mode = 0;
   
   `include "DRAM_CTRLTerminalInstance.v"
   
   wire         c3_clk0;
   wire         c3_rst0;
   wire         c3_async_rst;

   always @(posedge ifclk) begin
      status_calib_done <= status_calib_done_wire;
      status_rst <= 1'b0; //status_rst_wire;
   end
   
   assign sdram_addr[14:13] = 0;
   assign sdram_ba[2] = 0;

   mig_38 #
     (
      .C3_MEMCLK_PERIOD(3200), // Memory data transfer clock period
      .C3_SIMULATION("FALSE"), // # = TRUE, Simulating the design. Useful to reduce the simulation time,
                               // # = FALSE, Implementing the design.
      .C3_RST_ACT_LOW(1) // # = 1 for active low reset,
                          // # = 0 for active high reset.
      )
     mig_38
       (
        .mcb3_dram_dq                        (sdram_dq),
        .mcb3_dram_a                         (sdram_addr[12:0]),
        .mcb3_dram_ba                        (sdram_ba[1:0]),
        .mcb3_dram_ras_n                     (sdram_ras_n),
        .mcb3_dram_cas_n                     (sdram_cas_n),
        .mcb3_dram_we_n                      (sdram_we_n),
        .mcb3_dram_odt                       (sdram_odt),
        .mcb3_dram_cke                       (sdram_cke),
        .mcb3_dram_dm                        (sdram_ldm),
        .mcb3_dram_udqs                      (sdram_udqs),
        .mcb3_dram_udqs_n                    (sdram_udqs_n),
        .mcb3_rzq                            (sdram_rzq),
        .mcb3_zio                            (sdram_zio),
        .mcb3_dram_udm                       (sdram_udm),
        .mcb3_dram_dqs                       (sdram_ldqs),
        .mcb3_dram_dqs_n                     (sdram_ldqs_n),
        .mcb3_dram_ck                        (sdram_ck),
        .mcb3_dram_ck_n                      (sdram_ck_n),
      

	.c3_calib_done                       (status_calib_done_wire),
	.c3_rst0                             (), //status_rst_wire),
	.c3_sys_clk                          (ifclk),
	.c3_sys_rst_i                        (resetb && !mcb_reset),

	
        .c3_p0_cmd_clk                          (ifclk),
        .c3_p0_cmd_en                           (p0_cmd_en),
        .c3_p0_cmd_instr                        (p0_cmd_instr),
        .c3_p0_cmd_bl                           (p0_cmd_bl),
        .c3_p0_cmd_byte_addr                    (p0_cmd_byte_addr),
        .c3_p0_cmd_empty                        (p0_cmd_empty),
        .c3_p0_cmd_full                         (p0_cmd_full),
        .c3_p0_wr_clk                           (ifclk),
        .c3_p0_wr_en                            (p0_wr_en),
        .c3_p0_wr_mask                          (p0_wr_mask),
        .c3_p0_wr_data                          (p0_wr_data),
        .c3_p0_wr_full                          (p0_wr_full),
        .c3_p0_wr_empty                         (p0_wr_empty),
        .c3_p0_wr_count                         (p0_wr_count),
        .c3_p0_wr_underrun                      (p0_wr_underrun),
        .c3_p0_wr_error                         (p0_wr_error),
        .c3_p0_rd_clk                           (ifclk),
        .c3_p0_rd_en                            (p0_rd_en),
        .c3_p0_rd_data                          (p0_rd_data),
        .c3_p0_rd_full                          (p0_rd_full),
        .c3_p0_rd_empty                         (p0_rd_empty),
        .c3_p0_rd_count                         (p0_rd_count),
        .c3_p0_rd_overflow                      (p0_rd_overflow),
        .c3_p0_rd_error                         (p0_rd_error),

        .c3_p1_cmd_clk                          (p1_clk),
        .c3_p1_cmd_en                           (p1_cmd_en),
        .c3_p1_cmd_instr                        (p1_cmd_instr),
        .c3_p1_cmd_bl                           (p1_cmd_bl),
        .c3_p1_cmd_byte_addr                    (p1_cmd_byte_addr),
        .c3_p1_cmd_empty                        (p1_cmd_empty),
        .c3_p1_cmd_full                         (p1_cmd_full),
        .c3_p1_wr_clk                           (p1_clk),
        .c3_p1_wr_en                            (p1_wr_en),
        .c3_p1_wr_mask                          (p1_wr_mask),
        .c3_p1_wr_data                          (p1_wr_data),
        .c3_p1_wr_full                          (p1_wr_full),
        .c3_p1_wr_empty                         (p1_wr_empty),
        .c3_p1_wr_count                         (p1_wr_count),
        .c3_p1_wr_underrun                      (p1_wr_underrun),
        .c3_p1_wr_error                         (p1_wr_error),
        .c3_p1_rd_clk                           (p1_clk),
        .c3_p1_rd_en                            (p1_rd_en),
        .c3_p1_rd_data                          (p1_rd_data),
        .c3_p1_rd_full                          (p1_rd_full),
        .c3_p1_rd_empty                         (p1_rd_empty),
        .c3_p1_rd_count                         (p1_rd_count),
        .c3_p1_rd_overflow                      (p1_rd_overflow),
        .c3_p1_rd_error                         (p1_rd_error),

        .c3_p2_cmd_clk                          (p2_clk),
        .c3_p2_cmd_en                           (p2_cmd_en),
        .c3_p2_cmd_instr                        (p2_cmd_instr),
        .c3_p2_cmd_bl                           (p2_cmd_bl),
        .c3_p2_cmd_byte_addr                    (p2_cmd_byte_addr),
        .c3_p2_cmd_empty                        (p2_cmd_empty),
        .c3_p2_cmd_full                         (p2_cmd_full),
        .c3_p2_wr_clk                           (p2_clk),
        .c3_p2_wr_en                            (p2_wr_en),
        .c3_p2_wr_mask                          (p2_wr_mask),
        .c3_p2_wr_data                          (p2_wr_data),
        .c3_p2_wr_full                          (p2_wr_full),
        .c3_p2_wr_empty                         (p2_wr_empty),
        .c3_p2_wr_count                         (p2_wr_count),
        .c3_p2_wr_underrun                      (p2_wr_underrun),
        .c3_p2_wr_error                         (p2_wr_error),
        .c3_p2_rd_clk                           (p2_clk),
        .c3_p2_rd_en                            (p2_rd_en),
        .c3_p2_rd_data                          (p2_rd_data),
        .c3_p2_rd_full                          (p2_rd_full),
        .c3_p2_rd_empty                         (p2_rd_empty),
        .c3_p2_rd_count                         (p2_rd_count),
        .c3_p2_rd_overflow                      (p2_rd_overflow),
        .c3_p2_rd_error                         (p2_rd_error),

        .c3_p3_cmd_clk                          (p3_clk),
        .c3_p3_cmd_en                           (p3_cmd_en),
        .c3_p3_cmd_instr                        (p3_cmd_instr),
        .c3_p3_cmd_bl                           (p3_cmd_bl),
        .c3_p3_cmd_byte_addr                    (p3_cmd_byte_addr),
        .c3_p3_cmd_empty                        (p3_cmd_empty),
        .c3_p3_cmd_full                         (p3_cmd_full),
        .c3_p3_wr_clk                           (p3_clk),
        .c3_p3_wr_en                            (p3_wr_en),
        .c3_p3_wr_mask                          (p3_wr_mask),
        .c3_p3_wr_data                          (p3_wr_data),
        .c3_p3_wr_full                          (p3_wr_full),
        .c3_p3_wr_empty                         (p3_wr_empty),
        .c3_p3_wr_count                         (p3_wr_count),
        .c3_p3_wr_underrun                      (p3_wr_underrun),
        .c3_p3_wr_error                         (p3_wr_error),
        .c3_p3_rd_clk                           (p3_clk),
        .c3_p3_rd_en                            (p3_rd_en),
        .c3_p3_rd_data                          (p3_rd_data),
        .c3_p3_rd_full                          (p3_rd_full),
        .c3_p3_rd_empty                         (p3_rd_empty),
        .c3_p3_rd_count                         (p3_rd_count),
        .c3_p3_rd_overflow                      (p3_rd_overflow),
        .c3_p3_rd_error                         (p3_rd_error)
	);

   wire [15:0] dram_transfer_status;
   wire [31:0] dram_reg_datao;
   wire        dram_read_rdy, dram_write_rdy;
`endif 
   
   always @(*) begin
`ifndef DISABLE_SDRAM
      if(di_term_addr == `TERM_DRAM) begin
         di_reg_datao = dram_reg_datao;
         di_read_rdy  = dram_read_rdy;
         di_write_rdy = dram_write_rdy;
         di_transfer_status = dram_transfer_status;
      end else if(di_term_addr == `TERM_DRAM_CTRL) begin
         di_reg_datao = DRAM_CTRLTerminal_reg_datao;
         di_read_rdy  = 1;
         di_write_rdy = 1;
         di_transfer_status = 0;
      end else
`endif      
     if(di_term_addr == `TERM_DUMMY_FPGA) begin
	 di_reg_datao = (di_reg_addr[0]) ? 32'hBBAA9988 : ~32'hBBAA9988;
	 di_read_rdy  = 1;
	 di_write_rdy = 1;
	 di_transfer_status = 0;
      end else begin
         di_reg_datao = pt_di_reg_datao;
         di_read_rdy  = pt_di_read_rdy;
         di_write_rdy = pt_di_write_rdy;
         di_transfer_status = pt_di_transfer_status;
      end
   end
   
`ifndef DISABLE_SDRAM
   wire term_dram       = (di_term_addr == `TERM_DRAM);
   wire dram_write      = term_dram && di_write;
   wire dram_write_mode = term_dram && di_write_mode;
   wire dram_read       = term_dram && di_read;
   wire dram_read_mode  = term_dram && di_read_mode;

   di2mig #(.DATA_WIDTH(32)) di2mig
     (
      .ifclk                            (ifclk),
      .resetb                           (resetb),
      .di_read_mode                     (dram_read_mode),
      .di_read                          (dram_read),
      .di_write_mode                    (dram_write_mode),
      .di_write                         (dram_write),
      .di_reg_addr                      (di_reg_addr),
      .di_read_rdy                      (dram_read_rdy),
      .di_read_req                      (di_read_req),
      .di_reg_datao                     (dram_reg_datao),
      .di_transfer_status               (dram_transfer_status),
      .di_write_rdy                     (dram_write_rdy),
      .di_reg_datai                     (di_reg_datai),
      
      .pX_cmd_en                        (p0_cmd_en),
      .pX_cmd_instr                     (p0_cmd_instr[2:0]),
      .pX_cmd_bl                        (p0_cmd_bl[5:0]),
      .pX_cmd_byte_addr                 (p0_cmd_byte_addr[29:0]),
      .pX_cmd_full                      (p0_cmd_full),
      .pX_cmd_empty                     (p0_cmd_empty),

      .pX_wr_en                         (p0_wr_en),
      .pX_wr_data                       (p0_wr_data),
      
      .pX_rd_en                         (p0_rd_en),
      .pX_rd_data                       (p0_rd_data[31:0]),
      .pX_rd_empty                      (p0_rd_empty)
      );
   
   

`endif

endmodule


