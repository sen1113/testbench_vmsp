
// PURPOSE:Control input data for keccak module
// TODO:test this module
//

// synopsys translate_off
//`include "timescale.v"
// synopsys translate_on
//`include "or1200_defines.v"

  module keccak_ctrl(in512,hash_num,keccak_en,devide_en,byte_num,in_ready,hash_out32);
   input [511:0] in512;
   input [5:0] 	 hash_num;//from alu (=cust5_limm[5:0])
   input 	 keccak_en;//from alu
   input 	 devide_en;//from keccak(=out_ready)

   output [1:0]  byte_num;//to keccak
   output 	 in_ready;//to keccak
   output [31:0] hash_out32;//to wbmux


   assign byte_num = 2'b00; //Fix byte_num = 0 temporarily,because input is 32bit
   assign in_ready = keccak_en && (!devide_en);

   keccak_devide keccak_devide(
			       .in512(in512),
			       .devided32(hash_out32),
			       .num(hash_num),
			       .en(devide_en)
			       );

endmodule
