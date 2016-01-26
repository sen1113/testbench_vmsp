module sign_ctrl(clk,rst,sign_en,sign_reset);
   input clk,rst;
   input sign_en;
   output sign_reset;
   reg [1:0] stage;
   reg 	     reset;

   assign sign_reset = reset;

   always@(posedge clk or posedge rst)begin
      if(rst)begin
	 stage <= 2'b00;
	 reset <= 1;
      end else begin
         if(sign_en)begin
	    casex(stage)
	      2'b00:begin
	         stage <= 2'b01;
	         reset <= 0;
	      end
	      2'b01:begin
	         stage <= 2'b10;
	         reset <= 1;
	      end
	      default:reset <= 1;
	    endcase // casex (stage)
         end // if (sign_en && clk)
      end
   end
endmodule
