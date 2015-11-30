
// PURPOSE:Control input data for keccak module
// TODO:test this module
//

// synopsys translate_off
//`include "timescale.v"
// synopsys translate_on
//`include "or1200_defines.v"

module keccak_ctrl(clk,reset,
		   in512,hash_num,keccak_en,devide_en,
		   byte_num,hash_out32,in_ready);
   input clk, reset;
   input [511:0] in512;
   input [4:0] 	 hash_num;//from alu (=cust5_limm[4:0])
   input 	 kecccak_en;//from alu
   input 	 devide_en;//from keccak(=out_ready)

   output 	 byte_num;//to keccak
   output 	 in_ready;//to keccak
   output [31:0] hash_out32;//to wbmux


   assign byte_num = 2'b11; //Fix byte_num = 3 temporarily
   assign in_ready = keccak_en && (!devide_en);

   keccak_devide keccak_devide(
			       .clk(clk),
			       .rst(reset),
			       .in512(in512),
			       .out32(hash_out32),
			       .hash_num(hash_num),
			       .devide_en(devide_en)
			       );

endmodule
