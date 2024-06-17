module ExecuteToMemory(
    input clock, reset, RegWriteE, MemtoRegE, MemWriteE, input [31:0] ALUOutE, WriteDataE, input [4:0] WriteRegE,
    output reg RegWriteM, MemtoRegM, MemWriteM, output reg [31:0] ALUOutM, WriteDataM, output reg [4:0] WriteRegM
);

    always @(posedge clock or negedge reset)
    begin
        if(~reset)
        begin
        RegWriteM <=0;
        MemtoRegM <=0;
        MemWriteM <=0;
        ALUOutM   <=0;
        WriteDataM<=0;
        WriteRegM <=0;
        end
        else
        begin
        RegWriteM <=RegWriteE;
        MemtoRegM <=MemtoRegE;
        MemWriteM <=MemWriteE;
        ALUOutM   <=ALUOutE;
        WriteDataM<=WriteDataE;
        WriteRegM <=WriteRegE;
        end                                  
    end

endmodule