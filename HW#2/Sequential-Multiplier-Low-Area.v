`timescale 1 ns/100 ps

module multiplyLowArea(reset, start, product, multiplier, multiplicand, clk, done);

input clk;
input start;
input reset;
input [7:0] multiplier, multiplicand;
output reg [16:0] product;
output reg  done;

reg [7:0] multiplier_copy;
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
		multiplier_copy = multiplier;
		multiplicand_copy = multiplicand;
		product = 0;
		done = 0;
	end

  S1: if (counter != 0) begin
  	if (multiplier_copy[0]==1)
  		product[15:8] = product[15:8] + multiplicand_copy;
  	state=S2;
  	end
      else 
      	state=S3;
      
  S2: begin
    product = product >> 1;
	multiplier_copy = multiplier_copy >> 1;
    counter = counter - 1;
    state=S1;
	end

  S3: begin
  	done = 1;
    end
endcase
end

end
endmodule