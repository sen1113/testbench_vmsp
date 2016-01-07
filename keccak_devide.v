module keccak_devide(in512, devided32, num, en);
   input en;
   input [5:0] num;//=cust5_limm
   input [511:0] in512;//from keccak_ctrl
   output [31:0] devided32;//to keccak_ctrl

   reg[31:0] 		 out;

   always @ (num or in512) begin
      if(en)begin
	 casez(num[3:0])
  	   4'b0000:out <= in512[31:0];
	   4'b0001:out <= in512[63:32];
	   4'b0010:out <= in512[95:64];
	   4'b0011:out <= in512[127:96];
	   4'b0100:out <= in512[159:128];
	   4'b0101:out <= in512[191:160];
	   4'b0110:out <= in512[223:192];
	   4'b0111:out <= in512[255:224];
	   4'b1000:out <= in512[287:256];
	   4'b1001:out <= in512[319:288];
	   4'b1010:out <= in512[351:320];
	   4'b1011:out <= in512[383:352];
	   4'b1100:out <= in512[415:384];
	   4'b1101:out <= in512[447:416];
	   4'b1110:out <= in512[479:448];
	   4'b1111:out <= in512[511:480];
	 endcase
      end//if
   end//always

   assign devided32 = out;

endmodule
