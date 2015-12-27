/*
This is testbench for or1200_ctrl.v to or1200_wbmux.v


 */

`timescale 1ns / 1ps
`define P 20

`define width 32
`define OR1200_ALUOP_WIDTH   5
`define OR1200_ALUOP2_WIDTH  4
`define OR1200_COMPOP_WIDTH   4
`define OR1200_RFWBOP_WIDTH   4
module test_ctrl-wbmux;

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

   // Outputs

   wire [31:0] 			  ex_pc;
   wire [31:0] 			  rf_dataw;
   //wire [] wb_forw;
   //wire [] wbforw_valid;


    // Instantiate the Unit Under Test (UUT)
or1200_cpu_tmp_total or1200_cpu_tmp_total(
					  clk, rst, operand_a,operand_b,mult_mac_result,macrc_op,alu_op,alu_op2,comp_op,cust5_op,cust5_limm,carry,flag,rfwb_op,ex_pc,rf_dataw,wb_freeze
					  );

   initial begin
      // Initialize Inputs
      clk = 0;
      rst = 0;
      id_freeze = 0;
      ex_freeze = 0/* verilator public */;
      wb_freeze = 0/* verilator public */;
      extend_flush;
      except_flushpipe = 0;
      abort_mvspr = 0;
      if_insn = 0;
      ex_branch_taken = 0;
      pc_we = 0;
      id_pc = 0;
      ex_pc = 0;
      wbforw_valid = 0;
      du_hwbkpt = 0;

      //serve as or1200_ctrl
      rfwb_op = 0;
      wb_freeze = 0;


      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      @ (negedge clk);
      //test vector
      rst = 1; #(`P); rst = 0;
      #(`P);

      //`define OR1200_ALUOP_CUST5	5'b1_0010 // l.cust5
      //`define OR1200_OR32_CUST5             6'b111100


      //template : if_insn = 32'b 111100_00001_00002_00003_0000000_00100;
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

      cust5_limm = 6'b00_1110;//select in512[479:447]
      #(`P);
      alu_op = 5'b1_0010; cust5_op = 5'b01000; #(`P);
   end
   always #(`P/2) clk = ~ clk;



endmodule

`undef P
