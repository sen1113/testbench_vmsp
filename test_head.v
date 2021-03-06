/*
This is testbench for or1200_alu.v to keccak_ctrl


 */

`timescale 1ns / 1ps
`define P 20

`define width 32
`define OR1200_ALUOP_WIDTH   5
`define OR1200_ALUOP2_WIDTH  4
`define OR1200_COMPOP_WIDTH   4
module test_head;

    // Inputs
   reg clk;
   reg rst;
   reg [`width-1:0] operand_a;
   reg [`width-1:0] operand_b;
   reg [`width-1:0] mult_mac_result;
   reg 		    macrc_op;
   reg [`OR1200_ALUOP_WIDTH-1:0] alu_op;
   reg [`OR1200_ALUOP2_WIDTH-1:0] alu_op2;
   reg [`OR1200_COMPOP_WIDTH-1:0] comp_op;
   reg [4:0] 			  cust5_op;
   reg [5:0] 			  cust5_limm;
   reg 				  carry;
   reg 				  flag;

    // Outputs

   wire [31:0] keccak_dataout;



    // Instantiate the Unit Under Test (UUT)
or1200_cpu_tmp_head or1200_cpu_tmp_head(
					clk, rst, operand_a,operand_b,mult_mac_result,macrc_op,alu_op,alu_op2,comp_op,cust5_op,cust5_limm,carry,flag,keccak_dataout
					);

    initial begin
        // Initialize Inputs
       clk = 0;
       rst = 0;
       operand_a = 0;
       operand_b = 0;
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
       rst = 1; #(`P); rst = 0;
       #(`P);
       
       //`define OR1200_ALUOP_CUST5	5'b1_0010 // l.cust5
       //`define OR1200_OR32_CUST5             6'b111100


       //template : operand_a = ; cust5_op = ; cust5_limmm = ;#(`P);
       // SHA3-512("The quick brown fox jumps over the lazy dog.")

       
       #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00100; operand_a = "The ";#(`P);//HEAD
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "quic";#(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "k br";#(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "own ";#(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "fox "; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "jump"; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "s ov"; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "er t"; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "he l"; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "azy "; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00010; operand_a = "dog."; #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b00001; operand_a = 0; #(`P);//TAIL


       //store mode
       cust5_limm = 6'b00_1111;//select in512[511:480]
       #(`P);
       alu_op = 5'b1_0010; cust5_op = 5'b01000; #(`P);

    end
   always #(`P/2) clk = ~ clk;



endmodule

`undef P
