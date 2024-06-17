module FetchToDecode(input wire clock, reset, input wire [31:0] PCPlus4F, InstrF, input wire StallD, clear,
    output reg [31:0] PCPlus4D, InstrD);

    always @(posedge clock or negedge reset) 
    begin
        if(!reset)
            begin
                PCPlus4D <= 0;
                InstrD   <= 0;
            end
        else if (clear && !StallD)
            begin
                PCPlus4D <= 0;
                InstrD   <= 0;
            end
        else  if (!StallD)
            begin
                PCPlus4D <= PCPlus4F;
                InstrD   <= InstrF;
            end    
    end

endmodule