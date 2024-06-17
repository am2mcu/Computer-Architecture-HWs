module DecodeToExecute(
    input wire RegWriteD, MemtoRegD, MemWriteD, input wire [3:0] ALUControlD, input wire ALUSrcD, RegDstD, 
    input wire [31:0] RD1_D, RD2_D,
    input wire  [4:0]  RsD, RtD, RdD,
    input wire clear, clock, reset,
    input wire [31:0] SignImmD,
    output reg RegWriteE, MemtoRegE, MemWriteE,        
    output reg [3:0]  ALUControlE,
    output reg ALUSrcE, RegDstE,
    output reg [31:0] RD1_E, RD2_E,
    output reg [4:0]  RsE, RtE, RdE,
    output reg [31:0] SignImmE
);

    always @(posedge clock or negedge reset)
    begin
    if(~reset)
    begin
        RegWriteE<=1'b0;
        MemtoRegE<=1'b0;
        MemWriteE<=1'b0;
        ALUControlE<=3'b0;
        ALUSrcE<=1'b0;
        RegDstE<=1'b0;
        RD1_E<=32'b0;
        RD2_E<=32'b0;
        RsE<=5'b0;
        RtE<=5'b0;
        RdE<=5'b0;
        SignImmE<=32'b0;
    end

    else if(clear)
        begin
        RegWriteE<=1'b0;
        MemtoRegE<=1'b0;
        MemWriteE<=1'b0;
        ALUControlE<=3'b0;
        ALUSrcE<=1'b0;
        RegDstE<=1'b0;
        RD1_E<=32'b0;
        RD2_E<=32'b0;
        RsE<=5'b0;
        RtE<=5'b0;
        RdE<=5'b0;
        SignImmE<=32'b0;
        end
    else
        begin
        RegWriteE<=RegWriteD;
        MemtoRegE<=MemtoRegD;
        MemWriteE<=MemWriteD;
        ALUControlE<=ALUControlD;
        ALUSrcE<=ALUSrcD;
        RegDstE<=RegDstD;
        RD1_E<=RD1_D;
        RD2_E<=RD2_D;
        RsE<=RsD;
        RtE<=RtD;
        RdE<=RdD;
        SignImmE<=SignImmD;
        end
    end

endmodule