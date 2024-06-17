`timescale 1 ns/100 ps

module multiplyBooth(reset, start, product, multiplier, multiplicand, clk, done);

input clk;
input start;
input reset;
input [7:0] multiplier, multiplicand;
output reg [16:0] product;
output reg  done;

reg [8:0] multiplier_copy;
reg [7:0] multiplicand_copy;
reg [1:0] state;
reg [4:0] counter;


parameter S0=2'b00 , S1=2'b01 , S2=2'b10 , S3=2'b11 ;

always @ (posedge clk, reset)begin

if (reset) begin
 state=S0;
 done = 0;
end
else if (clk) begin
case (state)
  
  S0:begin
  	if (start)
		counter=8;
		state=S1;
		multiplier_copy = {multiplier, 1'b0};
		multiplicand_copy = multiplicand;
		product = {9'd0, multiplier};
		done = 0;
	end

  S1: if (counter != 0) begin
  	if (multiplier_copy[1:0] == 2'b10)
  		product[15:8] = product[15:8] - multiplicand_copy;
    else if (multiplier_copy[1:0] == 2'b01)
  		product[15:8] = product[15:8] + multiplicand_copy;
  	state=S2;
  	end
      else 
      	state=S3;
      
  S2: begin
	product = {product[15], product[15:0]};
    product = product >> 1;
	multiplier_copy = multiplier_copy >> 1;
    counter = counter - 1;
    state=S1;
	end

  S3: begin
  	done = 1; # 16th bit of product should be removed
    end
endcase
end

end
endmodule