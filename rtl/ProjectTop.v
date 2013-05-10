`include "terminals_defs.v"

module ProjectTop
  (
   output resetb,    // Async active low reset sent to FX3 controller logic. Tie high if you do not create an internal reset signal.

   input  ifclk,        // 48MHz clock from FX3.
   output fx3_int_b, // interrupt signal to fx3. Tie low if not using

   input [15:0] di_term_addr,
   input [31:0] di_reg_addr,
   input [31:0] di_len,
   input di_read_mode,
   input di_read_req,
   input di_read,
   input di_write_mode,
   input di_write,
   input [31:0] di_reg_datai,
   output reg di_read_rdy,
   output reg [31:0] di_reg_datao,
   output reg di_write_rdy,
   output reg [15:0] di_transfer_status,

   input button,
   output led_b,
   inout [15:0] header, // change to input/output/inout as appropriate.
   
   // The following pX_XXX ports provide access to the DDR2 memory
   // controller built into the spartan6 FPGA. See UG388 user guide
   // on how to use these ports.
   output        p1_clk,
   output        p1_cmd_en,
   output [2:0]  p1_cmd_instr,
   output [5:0]  p1_cmd_bl,
   output [29:0] p1_cmd_byte_addr,
   input         p1_cmd_empty,
   input         p1_cmd_full,
   output        p1_wr_en,
   output [3:0]  p1_wr_mask,
   output [31:0] p1_wr_data,
   input         p1_wr_full,
   input         p1_wr_empty,
   input [6:0]   p1_wr_count,
   input         p1_wr_underrun,
   input         p1_wr_error,
   output        p1_rd_en,
   input [31:0]  p1_rd_data,
   input         p1_rd_full,
   input         p1_rd_empty,
   input [6:0]   p1_rd_count,
   input         p1_rd_overflow,
   input         p1_rd_error,

   output        p2_clk,
   output        p2_cmd_en,
   output [2:0]  p2_cmd_instr,
   output [5:0]  p2_cmd_bl,
   output [29:0] p2_cmd_byte_addr,
   input         p2_cmd_empty,
   input         p2_cmd_full,
   output        p2_wr_en,
   output [3:0]  p2_wr_mask,
   output [31:0] p2_wr_data,
   input         p2_wr_full,
   input         p2_wr_empty,
   input [6:0]   p2_wr_count,
   input         p2_wr_underrun,
   input         p2_wr_error,
   output        p2_rd_en,
   input [31:0]  p2_rd_data,
   input         p2_rd_full,
   input         p2_rd_empty,
   input [6:0]   p2_rd_count,
   input         p2_rd_overflow,
   input         p2_rd_error,

   output        p3_clk,
   output        p3_cmd_en,
   output [2:0]  p3_cmd_instr,
   output [5:0]  p3_cmd_bl,
   output [29:0] p3_cmd_byte_addr,
   input         p3_cmd_empty,
   input         p3_cmd_full,
   output        p3_wr_en,
   output [3:0]  p3_wr_mask,
   output [31:0] p3_wr_data,
   input         p3_wr_full,
   input         p3_wr_empty,
   input [6:0]   p3_wr_count,
   input         p3_wr_underrun,
   input         p3_wr_error,
   output        p3_rd_en,
   input [31:0]  p3_rd_data,
   input         p3_rd_full,
   input         p3_rd_empty,
   input [6:0]   p3_rd_count,
   input         p3_rd_overflow,
   input         p3_rd_error,

   // These are generic I/O ports for bank X
   inout  l10n,
   inout  l10p,
   inout  l11n,
   inout  l11p,
   inout  l1p,
   inout  l1n,
   inout  l2n,
   inout  l2p,
   inout  l32n,
   inout  l32p,
   inout  l33n,
   inout  l33p,
   inout  l34n,
   inout  l34p,
   inout  l35n,
   inout  l35p,
   inout  l36n,
   inout  l36p,
   inout  l37n,
   inout  l37p,
   inout  l38n,
   inout  l38p,
   inout  l39n,
   inout  l39p,
   inout  l3n,
   inout  l3p,
   inout  l40n,
   inout  l40p,
   inout  l41n,
   inout  l41p,
   inout  l42n,
   inout  l42p,
   inout  l47n,
   inout  l47p,
   inout  l4n,
   inout  l4p,
   inout  l50n,
   inout  l50p,
   inout  l51n,
   inout  l51p,
   inout  l5n,
   inout  l5p,
   inout  l62n,
   inout  l62p,
   inout  l63n,
   inout  l63p,
   inout  l64n,
   inout  l64p,
   inout  l65n,
   inout  l65p,
   inout  l66n,
   inout  l66p,
   inout  l6n,
   inout  l6p,
   inout  l7n,
   inout  l7p,
   inout  l8n,
   inout  l8p,
   inout  l9n,
   inout  l9p,
   
   // These are generic I/O ports for bank X
   inout  n1n,
   inout  n1p,
   inout  n29n,
   inout  n29p,
   inout  n30n,
   inout  n30p,
   inout  n31n,
   inout  n31p,
   inout  n32n,
   inout  n32p,
   inout  n33n,
   inout  n33p,
   inout  n34n,
   inout  n34p,
   inout  n35n,
   inout  n35p,
   inout  n36n,
   inout  n36p,
   inout  n37n,
   inout  n37p,
   inout  n38n,
   inout  n38p,
   inout  n39n,
   inout  n39p,
   inout  n40n,
   inout  n40p,
   inout  n41n,
   inout  n41p,
   inout  n42n,
   inout  n42p,
   inout  n43n,
   inout  n43p,
   inout  n44n,
   inout  n44p,
   inout  n45n,
   inout  n45p,
   inout  n46n,
   inout  n46p,
   inout  n47n,
   inout  n47p,
   inout  n48n,
   inout  n48p,
   inout  n49n,
   inout  n49p,
   inout  n50n,
   inout  n50p,
   inout  n51n,
   inout  n51p,
   inout  n52n,
   inout  n52p,
   inout  n53n,
   inout  n53p,
   inout  n61n,
   inout  n61p,
   inout  n74n,
   inout  n74p
   );

   wire di_clk = ifclk;
   wire [15:0]          version_minor = 16'h02;
   wire [15:0]          version_major = 16'h01;
   wire [31:0]          version = {version_major, version_minor };
   
`include "FPGATerminalInstance.v"

   assign fx3_int_b = 1'b0; // Change these if necessary
   assign header = 0; // Change these if you implement logic to/from the
   
   // Create a simple reset counter to hold part in reset for a few
   // clock cycles when the fpga comes on-line and when the user
   // issues a reset from the PC.
   reg [1:0] reset_count;
   assign resetb = &reset_count;
   always @(posedge ifclk) begin
      if(sw_reset && !di_write_mode) begin
         reset_count   <= 0;
      end else if(!resetb) begin
         reset_count   <= reset_count + 1;
      end
   end

   always @(*) begin
      if(di_term_addr == `TERM_FPGA) begin
         di_reg_datao = FPGATerminal_reg_datao;
         di_read_rdy  = 1;  // always ready on other registers
         di_write_rdy = 1;
         di_transfer_status = 0;
      end else begin
         di_reg_datao = 32'hAAAAAAAA;
         di_read_rdy  = 1;
         di_write_rdy = 1;
         di_transfer_status = 16'hFFFF; // undefined terminal, return error code
      end
   end
   

   // LED blink logic
   reg [22:0] led_count;    // Divider clock for LED blinking ouput
   always @(posedge ifclk or negedge resetb) begin
      if(!resetb) begin
         led_count <= 0;
      end else begin
         led_count <= led_count + 1;
      end
   end

   // LED driver mux
   wire led_mux = (led_sel == 0) ? led_count[22] :
                  (led_sel == 1) ? 1'b1 :
                  0;

   assign led_b = ~led_mux;


   // change these assignments as necessary
   assign  l10n = 0;
   assign  l10p = 0;
   assign  l11n = 0;
   assign  l11p = 0;
   assign  l1p  = 0;
   assign  l1n  = 0;
   assign  l2n  = 0;
   assign  l2p  = 0;
   assign  l32n = 0;
   assign  l32p = 0;
   assign  l33n = 0;
   assign  l33p = 0;
   assign  l34n = 0;
   assign  l34p = 0;
   assign  l35n = 0;
   assign  l35p = 0;
   assign  l36n = 0;
   assign  l36p = 0;
   assign  l37n = 0;
   assign  l37p = 0;
   assign  l38n = 0;
   assign  l38p = 0;
   assign  l39n = 0;
   assign  l39p = 0;
   assign  l3n  = 0;
   assign  l3p  = 0;
   assign  l40n = 0;
   assign  l40p = 0;
   assign  l41n = 0;
   assign  l41p = 0;
   assign  l42n = 0;
   assign  l42p = 0;
   assign  l47n = 0;
   assign  l47p = 0;
   assign  l4n  = 0;
   assign  l4p  = 0;
   assign  l50n = 0;
   assign  l50p = 0;
   assign  l51n = 0;
   assign  l51p = 0;
   assign  l5n  = 0;
   assign  l5p  = 0;
   assign  l62n = 0;
   assign  l62p = 0;
   assign  l63n = 0;
   assign  l63p = 0;
   assign  l64n = 0;
   assign  l64p = 0;
   assign  l65n = 0;
   assign  l65p = 0;
   assign  l66n = 0;
   assign  l66p = 0;
   assign  l6n  = 0;
   assign  l6p  = 0;
   assign  l7n  = 0;
   assign  l7p  = 0;
   assign  l8n  = 0;
   assign  l8p  = 0;
   assign  l9n  = 0;
   assign  l9p  = 0;
   
   assign  n1n  = 0;
   assign  n1p  = 0;
   assign  n29n = 0;
   assign  n29p = 0;
   assign  n30n = 0;
   assign  n30p = 0;
   assign  n31n = 0;
   assign  n31p = 0;
   assign  n32n = 0;
   assign  n32p = 0;
   assign  n33n = 0;
   assign  n33p = 0;
   assign  n34n = 0;
   assign  n34p = 0;
   assign  n35n = 0;
   assign  n35p = 0;
   assign  n36n = 0;
   assign  n36p = 0;
   assign  n37n = 0;
   assign  n37p = 0;
   assign  n38n = 0;
   assign  n38p = 0;
   assign  n39n = 0;
   assign  n39p = 0;
   assign  n40n = 0;
   assign  n40p = 0;
   assign  n41n = 0;
   assign  n41p = 0;
   assign  n42n = 0;
   assign  n42p = 0;
   assign  n43n = 0;
   assign  n43p = 0;
   assign  n44n = 0;
   assign  n44p = 0;
   assign  n45n = 0;
   assign  n45p = 0;
   assign  n46n = 0;
   assign  n46p = 0;
   assign  n47n = 0;
   assign  n47p = 0;
   assign  n48n = 0;
   assign  n48p = 0;
   assign  n49n = 0;
   assign  n49p = 0;
   assign  n50n = 0;
   assign  n50p = 0;
   assign  n51n = 0;
   assign  n51p = 0;
   assign  n52n = 0;
   assign  n52p = 0;
   assign  n53n = 0;
   assign  n53p = 0;
   assign  n61n = 0;
   assign  n61p = 0;
   assign  n74n = 0;
   assign  n74p = 0;

   assign p1_clk = 0;
   assign p1_cmd_en = 0;
   assign p1_cmd_instr = 0;
   assign p1_cmd_bl = 0;
   assign p1_cmd_byte_addr = 0;
   assign p1_wr_en = 0;
   assign p1_wr_mask = 0;
   assign p1_wr_data = 0;
   assign p1_rd_en = 0;
   assign p2_clk = 0;
   assign p2_cmd_en = 0;
   assign p2_cmd_instr = 0;
   assign p2_cmd_bl = 0;
   assign p2_cmd_byte_addr = 0;
   assign p2_wr_en = 0;
   assign p2_wr_mask = 0;
   assign p2_wr_data = 0;
   assign p2_rd_en = 0;
   assign p3_clk = 0;
   assign p3_cmd_en = 0;
   assign p3_cmd_instr = 0;
   assign p3_cmd_bl = 0;
   assign p3_cmd_byte_addr = 0;
   assign p3_wr_en = 0;
   assign p3_wr_mask = 0;
   assign p3_wr_data = 0;
   assign p3_rd_en = 0;

   
endmodule // ProjectTop
