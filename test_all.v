/*
This module is testbench for or1200_ctrl.v
 or1200_ctrl.v is modified for keccak.

 */

`timescale 1ns / 1ps
`define P 20
`include "or1200_defines.v"


module test_all;

   // Inputs
   reg clk;
   reg rst;
   reg id_freeze;
   reg ex_freeze /* verilator public */;
   reg wb_freeze /* verilator public */;

   reg extend_flush;
   reg except_flushpipe;
   reg abort_mvspr ;
   reg [31:0] if_insn;
   reg 	      ex_branch_taken;
   reg 	      pc_we;
   reg [31:0] id_pc;
   reg [31:0] ex_pc;
   reg 	      wbforw_valid;
   reg 	      du_hwbkpt;
   reg [31:0] spr_cs;
   // Outputs
   wire [31:0] rf_dataw;//test this signal
 
   // Instantiate the Unit Under Test (UUT)
  or1200_cpu_keccak or1200_cpu_keccak(
  	// Clk & Rst 
	clk, rst,
//for test input
   id_freeze,
   ex_freeze,
   wb_freeze,
   extend_flush,
   except_flushpipe,
   abort_mvspr,
   if_insn,
   ex_branch_taken,
   pc_we,
   id_pc,
   ex_pc,
   wbforw_valid,
   du_hwbkpt,
   
   spr_cs,
//for test output
rf_dataw

  );
   initial begin
      // Initialize Inputs
      clk = 0;
      rst = 0;
      id_freeze = 0;
      ex_freeze = 0 /* verilator public */;
      wb_freeze = 0 /* verilator public */;

      extend_flush = 0;
      except_flushpipe = 0;
      abort_mvspr = 0;
      if_insn = 0;
      ex_branch_taken = 0;
      pc_we = 0;
      id_pc = 0;
      ex_pc = 0;
      wbforw_valid = 1;
      du_hwbkpt = 0;
      spr_cs = 0;//test   

      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      @ (negedge clk);

      //test vector
      rst = 1;#(`P);rst = 0;

      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00001_00000_0000000000000001;//00001 <- 1
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00010_00000_0000000000000010;//00010 <- 2
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00011_00000_0000000000000011;//00011 <- 3
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00100_00000_0000000000000100;//00100 <- 4
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00101_00000_0000000000000101;//00101 <- 5
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00110_00000_0000000000000110;//00110 <- 6
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00111_00000_0000000000000111;//00111 <- 7


      //l.cust5 D A B cust5_limm cust5_op(start)
      #(`P);
      if_insn = 32'b 111100_10000_00001_00000_000000_00100;//start
      #(`P);
      if_insn = 32'b 111100_10000_00010_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00011_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00100_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00101_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00110_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00111_00000_000000_00001;//end

      //l.cust5 (store)
      #(`P*50);
      #(`P);
      if_insn = 32'b 111100_01000_00000_00000_001111_01000;
      #(`P);
      //l.sw(0x35) I A B I
      if_insn = 32'b 110101_00000_00000_00001_00000000000;

      #(`P);
      if_insn = 32'b 111100_00010_00000_00000_001110_01000;
      #(`P);
      if_insn = 32'b 110101_00000_00000_00010_00000000100;

      #(`P);
      if_insn = 32'b 111100_00100_00000_00000_001101_01000;
      #(`P);
      if_insn = 32'b 110101_00000_00000_00100_00000000100;

      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001100_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001011_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001010_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001001_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001000_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000111_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000110_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000101_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000100_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000011_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000010_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000001_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000000_01000;
   #(`P*50);
      //test vector
      //rst = 1;#(`P);rst = 0;
     
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00001_01000_0000000000000000;//00000 <- 1
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00010_00000_0000000000000010;//00010 <- 2
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00011_00000_0000000000000011;//00011 <- 3
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00100_00000_0000000000000100;//00100 <- 4
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00101_00000_0000000000000101;//00101 <- 5
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00110_00000_0000000000000110;//00110 <- 6
      //l.addi(0x27)
      #(`P);
      if_insn = 32'b 100111_00111_00000_0000000000000111;//00111 <- 7
#(`P);
 if_insn = 32'b 111100_00000_00000_00000_000000_00000;//reset Keccak
      //l.cust5 D A B cust5_limm cust5_op(start)
      #(`P);
      if_insn = 32'b 111100_10000_00001_11111_111111_00100;//start
      #(`P);
      if_insn = 32'b 111100_10000_00010_XXXXX_XXXXXX_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00011_XXXXX_XXXXXX_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00100_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00101_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00110_00000_000000_00010;//middle
      #(`P);
      if_insn = 32'b 111100_10000_00111_00000_000000_00001;//end

      //l.cust5 (store)
      #(`P*50);
      #(`P);
      if_insn = 32'b 111100_00001_11111_11111_001111_01000;
      //#(`P);
      //l.sw(0x35) I A B I
      //if_insn = 32'b 110101_00000_00000_00001_00000000000;

      #(`P);
      if_insn = 32'b 111100_00010_XXXXX_XXXXX_001110_01000;
      //#(`P);
      //if_insn = 32'b 110101_00000_00000_00010_00000000100;

      #(`P);
      if_insn = 32'b 111100_00100_XXXXX_XXXXX_001101_01000;
      //#(`P);
      //if_insn = 32'b 110101_00000_00000_00100_00000000100;

      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001100_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001011_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001010_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001001_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_001000_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000111_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000110_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000101_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000100_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000011_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000010_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000001_01000;
      #(`P);
      if_insn = 32'b 111100_00001_00000_00000_000000_01000;
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
