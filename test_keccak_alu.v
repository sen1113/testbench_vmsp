/*
This module is testbench for or1200_alu.v
 or1200_alu.v is modified for keccak.

 */

`timescale 1ns / 1ps
`define P 20

`define width 32;
`define OR1200_ALUOP_WIDTH   5
`define OR1200_ALUOP2_WIDTH  4
`define OR1200_COMPOP_WIDTH   4
module test_keccak_alu;

   // Inputs
//   reg clk;
//   reg reset;
   reg [width-1:0] a;
   reg [width-1:0] b;
   reg [width-1:0] mult_mac_result;
   reg 		   macrc_op;
   reg [`OR1200_ALUOP_WIDTH-1:0]    alu_op;
   reg [`OR1200_ALUOP2_WIDTH-1:0]   alu_op2;
   reg [`OR1200_COMPOP_WIDTH-1:0]   comp_op;
   reg [4:0] 			    cust5_op;
   reg [5:0] 			    cust5_limm;
   reg 				    carry;

   // Outputs
   wire [width-1:0] 		    result;
   wire 			    flagforw;
   wire 			    flag_we;
   wire 			    cyforw;
   wire 			    cy_we;
   wire 			    ovforw;
   wire 			    ov_we;

   wire 			    keccak_en;
   wire 			    out32;
   wire 			    in_ready;
   wire 			    is_last;
   wire 			    hash_num;



   // Instantiate the Unit Under Test (UUT)
   or1200_alu or1200_alu(a, b, mult_mac_result, macrc_op,
	alu_op, alu_op2, comp_op,
	cust5_op, cust5_limm,
	result, flagforw, flag_we,
	ovforw, ov_we,
	cyforw, cy_we, carry, flag,
		  keccak_en,out32,in_ready,is_last,hash_num);

   initial begin
      // Initialize Inputs
      a = 0;
      b = 0;
      mult_mac_result = 0;
      macrc_op = 0;
      alu_op = 0;
      alu_op2 = 0;
      comp_op = 0;
      cust5_op= 0;
      cust5_limm = 0;
      carry = 0;
      flag = 0;

      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      @ (negedge clk);

      //test vector
      reset = 1; #(`P); reset = 0;
      cust5_limm = 5'b00001;

      #10;
      cust5_op = 5'b00100;
      #10;
      cust5_op = 5'b00010;
      #10;
      cust5_op = 5'b00001;
      #100;
      cust5_op = 5'b01000;
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
