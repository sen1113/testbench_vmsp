/*
This module is testbench for or1200_wbmux.v
 or1200_wbmux.v is modified for keccak.

 */

`timescale 1ns / 1ps
`define P 20
`include "or1200_defines.v"

parameter width = `OR1200_OPERAND_WIDTH;

module test_keccak_wbmux;

   // Inputs
   reg clk;
   reg rst;

   reg wb_freeze;
   reg [`OR1200_RFWBOP_WIDTH-1:0] rfwb_op;
   reg [width-1:0] 		  muxin_a;//alu_dataout
   reg [width-1:0] 		  muxin_b;//lsu_dataout
   reg [width-1:0] 		  muxin_c;//sprs_dataout
   reg [width-1:0] 		  muxin_d;//ex_pc
   reg [width-1:0] 		  muxin_e;//fpu_dataout

   reg [31:0] 			  muxin_keccak;//keccak_dataout
   // Outputs
   wire [width-1:0] 		  muxout;//rf_dataw
   wire [width-1:0] 		  muxreg;//wb_forw
   wire 			  muxreg_valid;//wbforw_valid


   // Instantiate the Unit Under Test (UUT)
module or1200_wbmux(
		    // Clock and reset
		    clk, rst,

		    // Internal i/f
		    wb_freeze, rfwb_op,
		    muxin_a, muxin_b, muxin_c, muxin_d, muxin_e,
		    muxout, muxreg, muxreg_valid,
		    muxin_keccak
		    );
   initial begin
      // Initialize Inputs
      clk = 0;
      rst = 0;
      wb_freeze = 0;
      rfwb_op = 0;
      muxin_a = 32'h1000_0000_0000_0000;
      muxin_b = 32'h0100_0000_0000_0000;
      muxin_c = 32'h0010_0000_0000_0000;
      muxin_d = 32'h0001_0000_0000_0000;
      muxin_e = 32'h1001_0000_0000_0000;
      muxin_keccak = 32'h1111_1111_1111_1111;
      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      @ (negedge clk);

      //test vector
      rst = 1;#(`P);rst = 0;

      //test muxin_keccak
      #10;
      rfwb_op = 0001;//ALU
      #10;
      rfwb_op = 0011;//LSU
      #10;
      rfwb_op = 0101;//SPRS
      #10;
      rfwb_op = 0111;//LR
      #10;
      rfwb_op = 1001;//FPU
      #100;
      rfwb_op = 1111;//KECCAK
      #100;
      rfwb_op = 1110;//if rfwb_op[0] = 0,wb is not enabled.

      #100;
      wb_freeze = 1;
   end


//   initial $monitor($time, " num = %h out32 = %h",num,out32);



   always #(`P/2) clk = ~ clk;

   task error;
      begin
         $display("E");
         $finish;
      end
   endtask


endmodule

`undef P
