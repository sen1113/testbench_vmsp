/*
This module is testbench for or1200_ctrl.v
 or1200_ctrl.v is modified for keccak.

 */

`timescale 1ns / 1ps
`define P 20



module test_keccak_or1200_ctrl;

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
   wire if_flushpipe;
   wire id_flushpipe;
   wire ex_flushpipe;
   wire wb_flushpipe;
   wire	[31:0]				id_simm;
   wire [31:0] 				ex_simm;
   wire [`OR1200_REGFILE_ADDR_WIDTH-1:0] rf_addrw;//test this signal
   wire [`OR1200_REGFILE_ADDR_WIDTH-1:0] rf_addra;//test this signal
   wire [`OR1200_REGFILE_ADDR_WIDTH-1:0] rf_addrb;//test this signal
   wire 				 rf_rda;
   wire 				 rf_rdb;
   wire [`OR1200_ALUOP_WIDTH-1:0] 	 alu_op;//test this signal
   wire [`OR1200_ALUOP2_WIDTH-1:0] 	 alu_op2;
   wire [`OR1200_MACOP_WIDTH-1:0] 	 mac_op;
   wire [`OR1200_RFWBOP_WIDTH-1:0] 	 rfwb_op;//test this signal
   wire [`OR1200_FPUOP_WIDTH-1:0] 	 fpu_op;
   wire [31:0] 				 wb_insn;//test this signal
   wire [31:2] 				 id_branch_addrtarget;
   wire [31:2] 				 ex_branch_addrtarget;
   wire [`OR1200_SEL_WIDTH-1:0] 	 sel_a;
   wire [`OR1200_SEL_WIDTH-1:0] 	 sel_b;
   wire [`OR1200_LSUOP_WIDTH-1:0] 	 id_lsu_op;
   wire [`OR1200_COMPOP_WIDTH-1:0] 	 comp_op;
   wire [`OR1200_MULTICYCLE_WIDTH-1:0] 	 multicycle;
   wire [`OR1200_WAIT_ON_WIDTH-1:0] 	 wait_on;
   wire [4:0] 				 cust5_op;//test this signal
   wire [5:0] 				 cust5_limm;//test this signal
   wire 				 sig_syscall;
   wire 				 sig_trap;
   wire 				 force_dslot_fetch;
   wire 				 no_more_dslot;
   wire 				 id_void;
   wire 				 ex_void;
   wire 				 ex_spr_read;
   wire 				 ex_spr_write;
   wire [`OR1200_MACOP_WIDTH-1:0] 	 id_mac_op;
   wire 				 id_macrc_op;
   wire 				 ex_macrc_op;
   wire 				 rfe;
   wire 				 except_illegal;
   wire 				 dc_no_writethrough;


   // Instantiate the Unit Under Test (UUT)
  or1200_ctrl(
   // Clock and reset
   clk, rst,
   // Internal i/f
   except_flushpipe, extend_flush, if_flushpipe, id_flushpipe, ex_flushpipe,
   wb_flushpipe,
   id_freeze, ex_freeze, wb_freeze, if_insn, id_insn, ex_insn, abort_mvspr,
   id_branch_op, ex_branch_op, ex_branch_taken, pc_we,
   rf_addra, rf_addrb, rf_rda, rf_rdb, alu_op, alu_op2, mac_op,
   comp_op, rf_addrw, rfwb_op, fpu_op,
   wb_insn, id_simm, ex_simm, id_branch_addrtarget, ex_branch_addrtarget, sel_a,
   sel_b, id_lsu_op,
   cust5_op, cust5_limm, id_pc, ex_pc, du_hwbkpt,
   multicycle, wait_on, wbforw_valid, sig_syscall, sig_trap,
   force_dslot_fetch, no_more_dslot, id_void, ex_void, ex_spr_read,
   ex_spr_write,
   id_mac_op, id_macrc_op, ex_macrc_op, rfe, except_illegal, dc_no_writethrough
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
      wbforw_valid = 0;
      du_hwbkpt = 0;


      // Wait 100 ns for global reset to finish
      #100;

      // Add stimulus here
      @ (negedge clk);

      //test vector
      rst = 1;#(`P);rst = 0;
      //l.cust5 D A B cust5_limm cust5_op(start)
      if_insn = 32'b 111100_00010_00001_00000_000000_00100;
      #100;
      if_insn = 32'b 111100_00010_00001_00000_000000_00010;
      #100;
      if_insn = 32'b 111100_00010_00001_00000_000000_00001;
      #100;
      if_insn = 32'b 111100_00010_00001_00000_000000_01000;

      //l.addi(0x27)
      #100;
      if_insn = 32'b 100111_00010_00001_0000000000000011;
      //l.addc(0x38)
      #100;
      if_insn = 32'b 111000_00010_00001_00001_0_00_0000_0001;
   end


//   initial $monitor($time, " num = %h out32 = %h",num,out32);



//   always #(`P/2) clk = ~ clk;

   task error;
      begin
         $display("E");
         $finish;
      end
   endtask


endmodule

`undef P
