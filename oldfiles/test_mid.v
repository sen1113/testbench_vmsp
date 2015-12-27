/*
This is testbench for keccak_ctrl.v & keccak.v


 */

`timescale 1ns / 1ps
`define P 20

module test_mid;

    // Inputs
   reg clk;
   reg rst;
   reg [4:0]hash_num;
   reg 	      keccak_en;
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
       rst = 0;
       hash_num = 0;
       keccak_en = 0;
       keccak_data32 = 0;
       is_last = 0;


        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        @ (negedge clk);
      //test vector
        rst = 1; #(`P); rst = 0;
       #(`P);
//       keccak_data32 = 32'h FFFF_0000;
       #(`P);
       keccak_en = 1;



      #(`P);
       is_last = 1;keccak_en = 0;

       #(`P)
       //@ (negedge clk);
        // SHA3-512("The quick brown fox jumps over the lazy dog.")
        rst = 1; #(`P); rst = 0;
        
        keccak_en = 1; is_last = 0;
        keccak_data32 = "The "; #(`P);
        keccak_data32 = "quic"; #(`P);
        keccak_data32 = "k br"; #(`P);
        keccak_data32 = "own "; #(`P);
        keccak_data32 = "fox "; #(`P);
        keccak_data32 = "jump"; #(`P);
        keccak_data32 = "s ov"; #(`P);
        keccak_data32 = "er t"; #(`P);
        keccak_data32 = "he l"; #(`P);
        keccak_data32 = "azy "; #(`P);
        keccak_data32 = "dog."; #(`P);
        keccak_data32 = 0; is_last = 1; #(`P); /* !!! */
        keccak_en = 0; is_last = 0;
     
	end
	always #(`P/2) clk = ~ clk;



endmodule

`undef P
