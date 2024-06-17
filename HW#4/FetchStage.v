module FetchStage(input wire clock, reset, StallF, input wire [31:0] PCin, 
    output wire [31:0] PCPlus4F, InstrF);

    wire [31:0] PCout;

    always @(posedge clock, negedge reset) 
    begin
        if (!reset)
        begin
            PCout <= 0;
        end
        else if (!StallF)
        begin
            PCout <= PCin; // set value in PC after every clock
        end
    end

    IMemBank InstructionMemory(1, PCout, InstrF); // fetch instruction

    assign PCPlus4F = PCout + 32'd4; // PC + 4

endmodule