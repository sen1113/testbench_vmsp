/*
This is testbench for keccak_ctrl.v & keccak.v


 */

`timescale 1ns / 1ps
`define P 20

module test_total1;

    // Inputs
   reg clk;
   reg reset;
   reg 	      keccak_en;
   reg hash_num;
   reg [31:0]   keccak_data32;
   reg 	      is_last;


    // Outputs

   wire [31:0] keccak_dataout;



    // Instantiate the Unit Under Test (UUT)
or1200_cpu_tmp or1200_cpu_tmp(
		      // Clk & Rst
		      clk, rst,
		      hash_num,keccak_en,keccak_data32,is_last,keccak_dataout
		      );


    initial begin
        // Initialize Inputs
       clk = 0;
       reset = 0;
       hash_num = 0;
       keccak_en = 0;
       keccak_data32 = 0;
       is_last = 0;


        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        @ (negedge clk);
      //test vector
      reset = 1; #(`P); reset = 0;
       #100;
       keccak_data32 = 32'h FFFF_FFFF;
       #10;
       keccak_en = 1;



      #100;
       is_last = 1;

	end
	always #(`P/2) clk = ~ clk;



endmodule

`undef P
