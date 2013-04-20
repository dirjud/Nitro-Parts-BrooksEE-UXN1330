/**
 * Copyright (C) 2009 BrooksEE, LLC
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


/* Desciption: These are some verilog self-checking tests of gets and
 sets.  They are written in behavioral verilog, so they are simulator
 neutral. They do not work with verilator.
 */

`timescale 1ps/1ps
`include "terminals_defs.v"

module isim_tests;
   integer i;
   reg [`WIDTH_FPGA_version-1:0] version;
   reg [`WIDTH_DRAM_CTRL_status-1:0] dram_status;
   reg                               pll_locked, calib_done;

   parameter BUF_LEN=516;
   

   reg [29:0]                        addr;
   
   reg [7:0]                         wr_buf[BUF_LEN-1:0];
   reg                               passing;
   
   initial begin
      dram_status = 0;
      pll_locked = 0;
      calib_done = 0;
      passing = 1;

`ifdef TRACE      
      $dumpfile ( "isim.vcd" );
      $dumpvars ( 3, UXN1330_tb );
      $display( "Running Simulation" );
`endif

      UXN1330_tb.UXN1330.ProjectTop.reset_count = 0;
      
      while (UXN1330_tb.UXN1330.ProjectTop.resetb == 0)
        #10000 $display("Waiting for device to come out of reset");
      
      UXN1330_tb.fx2.getW(`TERM_FPGA, `FPGA_version,  `WIDTH_FPGA_version, version);
      $display("FPGA Version=0x%x", version);


      $display("Waiting for Memory Controller Block (MCB) to calibrate to SDRAM");
      while(calib_done !== 1) begin
         get_status();
         $display("%d: Status = 0x%x, pll_locked=%d calib_done=%d", $time, dram_status, pll_locked, calib_done);
      end


      check_dram_write_read();
      check_dram_rw_addr();
      
      
      if(passing)
        $display("PASS: All Tests");
      else
        $display("FAIL: All Tests");
      
      
      $display("DONE");
      $finish;
   end


   task get_status();
      begin
         UXN1330_tb.fx2.getW(`TERM_DRAM_CTRL, `DRAM_CTRL_status, `WIDTH_DRAM_CTRL_status, dram_status);
         pll_locked = dram_status[`DRAM_CTRL_status_pll_locked];
         calib_done = dram_status[`DRAM_CTRL_status_calib_done];
      end
   endtask // get_status

   task check_dram_write_read();
      integer results;
      begin

         $display("Performing dram write/read tests of random data to random locations.");
         addr = 30'h3FFFFFC & $random;
         for(i=0; i<BUF_LEN; i=i+1) begin
            wr_buf[i] = $random;
            UXN1330_tb.fx2.rdwr_data_buf[i] = wr_buf[i];
         end
         
         $display("Writing %d random bytes to address 0x%x in DRAM", BUF_LEN, addr);
         UXN1330_tb.fx2.write(`TERM_DRAM, addr, BUF_LEN);

         for(i=0; i<BUF_LEN; i=i+1) begin
            UXN1330_tb.fx2.rdwr_data_buf[i] = 8'hXX;
         end
         
         $display("Reading %d bytes from address 0x%x in DRAM", BUF_LEN, addr);
         UXN1330_tb.fx2.read(`TERM_DRAM,  addr, BUF_LEN);

         
         results = 1;
         for(i=0; i<BUF_LEN; i=i+1) begin
            if(wr_buf[i] !== UXN1330_tb.fx2.rdwr_data_buf[i]) begin
               results = 0;
               $display(" write/read error at position %d: wrote 0x%x  read:0x%x", i, wr_buf[i], UXN1330_tb.fx2.rdwr_data_buf[i]);
            end
         end

	 #100000

         $display("Again Reading %d bytes from address 0x%x in DRAM", BUF_LEN, addr);
         UXN1330_tb.fx2.read(`TERM_DRAM,  addr, BUF_LEN);
         for(i=0; i<BUF_LEN; i=i+1) begin
            if(wr_buf[i] !== UXN1330_tb.fx2.rdwr_data_buf[i]) begin
               results = 0;
               $display(" 2nd pass write/read error at position %d: wrote 0x%x  read:0x%x", i, wr_buf[i], UXN1330_tb.fx2.rdwr_data_buf[i]);
            end
         end

         if(results) begin
            $display("PASS: dram write/read test");
         end else begin
            $display("FAIL: dram write/read test");
            passing= 0;

         end
      end
   endtask

   task check_dram_rw_addr();
      integer results;
      integer offset;
      
      begin
         offset = 24;
         
         $display("Performing dram write/read address tests.");
         addr = 100;
         for(i=0; i<BUF_LEN; i=i+1) begin
            wr_buf[i] = 8'hAA;
            UXN1330_tb.fx2.rdwr_data_buf[i] = wr_buf[i];
         end
         
         $display("Writing %d 8'hAA bytes to address 0x%x in DRAM", BUF_LEN, addr);
         UXN1330_tb.fx2.write(`TERM_DRAM, addr, BUF_LEN);

         for(i=0; i<BUF_LEN; i=i+1) begin
            wr_buf[i] = 8'h55;
            UXN1330_tb.fx2.rdwr_data_buf[i] = wr_buf[i];
         end

         UXN1330_tb.fx2.write(`TERM_DRAM, addr-offset, offset);
         
         for(i=0; i<BUF_LEN; i=i+1) begin
            UXN1330_tb.fx2.rdwr_data_buf[i] = 8'hXX;
         end
         
         $display("Reading %d bytes from address 0x%x in DRAM", BUF_LEN, addr-offset);
         UXN1330_tb.fx2.read(`TERM_DRAM,  addr-offset, BUF_LEN+offset);
         
         results = 1;
         for(i=0; i<offset; i=i+1) begin
            if(UXN1330_tb.fx2.rdwr_data_buf[i] !== 8'h55) begin
               results = 0;
               $display(" write/read error at position %d: wrote 0x55  read:0x%x", i, UXN1330_tb.fx2.rdwr_data_buf[i]);
            end
         end
         for(i=offset; i<BUF_LEN+offset; i=i+1) begin
            if(UXN1330_tb.fx2.rdwr_data_buf[i] !== 8'hAA) begin
               results = 0;
               $display(" write/read error at position %d: wrote 0xAA  read:0x%x", i, UXN1330_tb.fx2.rdwr_data_buf[i]);
            end
         end
         if(results) begin
            $display("PASS: dram write/read addr test");
         end else begin
            $display("FAIL: dram write/read addr test");
            passing= 0;

         end
      end
   endtask

endmodule
