module DecodeStage(
    input wire [31:0] InstrD, PCPlus4D, ALUOutM, input wire [4:0] WriteRegW, input wire RegWriteW, input wire [31:0] ResultW,
    input  wire reset, clock, ForwardAD, ForwardBD,
    output wire [31:0] RD1_D, RD2_D, SignImmD, PCBranchD, ShifterOut_26, output wire [4:0] RsD, RtD, RdD, output wire EqualD
);

    wire [31:0]   MUX_RD1_out1;
    wire [31:0]   MUX_RD2_out2;
    wire [31:0]   ShifterOut_32;
    wire [27:0]   ShifterOut_28;

    assign ShifterOut_26 = {InstrD[31:28],ShifterOut_28};
    assign RsD = InstrD[25:21];
    assign RtD = InstrD[20:16];
    assign RdD = InstrD[15:11];

    RegFile RegisterFile(clock, InstrD[25:21], InstrD[20:16], WriteRegW, ResultW, RegWriteW, RD1_D, RD2_D);

    assign MUX_RD1_out1 = ForwardAD ? ALUOutM : RD1_D;

    assign MUX_RD2_out2 = ForwardBD ? ALUOutM : RD2_D;

    assign EqualD = (MUX_RD1_out1 == MUX_RD2_out2) ? 1'b1 : 1'b0; // comparator

    assign SignImmD = {{16{InstrD[15]}}, InstrD[15:0]};

    assign ShifterOut_32 = SignImmD << 2;

    assign ShifterOut_28 = InstrD[25:0] << 2;

    assign PCBranchD = ShifterOut_32 + PCPlus4D;

endmodule