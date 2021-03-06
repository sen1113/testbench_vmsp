/*
This is testbench for keccak_ctrl.v

 */

`timescale 1ns / 1ps
`define P 20

module test_keccak_ctrl;

    // Inputs
   reg clk;
   reg reset;
   reg [511:0] in512;
   reg [4:0]   hash_num;
   reg 	      keccak_en;
   reg 	      devide_en;

    // Outputs
   wire       byte_num;
   wire       in_ready;
   wire [31:0] hash_out32;


    // Var
    integer i;

    // Instantiate the Unit Under Test (UUT)
    keccak_ctrl keccak_ctrl(
        .clk(clk),
        .reset(reset),
        .in512(in512),
        .hash_num(hash_num),
        .keccak_en(keccak_en),
        .devide_en(devide_en),
        .byte_num(byte_num),
      	.hash_out32(hash_out32),
	.in_ready(in_ready)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
        in512 = 0;
        hash_num = 0;
        keccak_en = 0;
        devide_en = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add stimulus here
        @ (negedge clk);
      //test vector
      reset = 1; #(`P); reset = 0;
       in512 = 512'h 0000_1111_2222_3333_4444_5555_6666_7777_8888_9999_AAAA_BBBB_CCCC_DDDD_EEEE_FFFF_0000_1111_2222_3333_4444_5555_6666_7777_8888_9999_AAAA_BBBB_CCCC_DDDD_EEEE_FFFF;

      #100;
      keccak_en = 1;
      devide_en = 1;
      hash_num = 0;

	end
	initial $monitor ($time, "keccak_en = %h, devide_en = %h, hash_num = %h, hash_out32 = %h",keccak_en,devide_en,hash_num,hash_out32);
	always #(`P/2) clk = ~ clk;



endmodule

`undef P
