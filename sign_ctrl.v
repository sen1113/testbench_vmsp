module sign_ctrl(clk,sign_en,sign_reset);
   input clk;
   input sign_en;
   output sign_reset;
   reg 	  flag;
reg reset;

   assign sign_reset = reset;

always@(posedge sign_en)begin
  flag <= 1;
end

   always@(clk)begin
	   if(sign_en == 1 && flag == 1)begin
	     reset <= 0;
	     flag <= 0;
	     end
	   else if(flag == 0)
	     reset <= 1;
   end
endmodule
