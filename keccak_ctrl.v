// PURPOSE:Control input data for keccak module
// TODO:test this module
//

// synopsys translate_off
//`include "timescale.v"
// synopsys translate_on
//`include "or1200_defines.v"

  module keccak_ctrl(in512,hash_num,keccak_en,store_en,out_ready,in_ready,hash_out32,on_cust5);
   input [511:0] in512;
   input [5:0] 	 hash_num;//from alu (=cust5_limm[5:0])
   input 	 keccak_en;//from alu
   input 	 out_ready;//from keccak(=out_ready)
   input 	 store_en;//from alu
   input 	 on_cust5;//from alu

   output 	 in_ready;//to keccak
   output [31:0] hash_out32;//to wbmux

   assign in_ready = keccak_en && (!out_ready) && on_cust5;
   assign devide_en = out_ready && store_en;

   keccak_devide keccak_devide(
			       .in512(in512),
			       .devided32(hash_out32),
			       .num(hash_num),
			       .en(devide_en)
			       );


endmodule
