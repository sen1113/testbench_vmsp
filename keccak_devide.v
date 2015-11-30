module keccak_devide(clk, reset, in512, out32, num, en);
   input clk, reset;
   input en;
   input [5:0] num;//=cust5_limm
   input [511:0] in512;//from keccak_ctrl
   output [31:0] out32;//to keccak_ctrl

   reg 		 out;


   assign out32 = out;

   always @ (posedge clk and en) begin
      casez(num)
	15'd 0:out <= in512[31:0];
	15'd1:out <= in512[63:32];
	15'd2:out <= in512[95:64];
	15'd3:out <= in512[127:96];
	15'd4:out <= in512[159:128];
	15'd5:out <= in512[191:160];
	15'd6:out <= in512[223:192];
	15'd7:out <= in512[255:224];
	15'd8:out <= in512[287:256];
	15'd9:out <= in512[319:288];
	15'd10:out <= in512[351:320];
	15'd11:out <= in512[383:352];
	15'd12:out <= in512[415:384];
	15'd13:out <= in512[447:416];
	15'd14:out <= in512[479:448];
	15'd15:out <= in512[511:480];
      endcase
   end//always
endmodule
