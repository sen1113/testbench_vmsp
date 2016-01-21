module sign_ctrl(clk,sign_en,sign_reset);
   input clk;
   input sign_en;
   output sign_reset;
   reg 	  flag;

   assign sign_reset = nrst;

   always(clk)begin
      if(sign_en == 1 && sign_reset == 0)
	flag <= 0;
      else
	flag  <= 1;
   end
endmodule
