module ExecuteStage(
    input ALUSrcE,RegDstE, input [1:0] ForwardAE,ForwardBE, input [3:0] ALUControlE, input [31:0] RD1_E,RD2_E,SignImmE,
    input [4:0] RsE,RtE,RdE, input  [31:0] Wd3E, ALUOutM, ALUOutE, WriteDataE, output [4:0] WriteRegE, output wire Zero, lt, gt
);

    wire [31:0] SrcAE,SrcBE;

    ALU ALUUnit(SrcAE, SrcBE, ALUControlE, ALUOutE, Zero, lt, gt);

    assign WriteRegE = RegDstE ? RdE : RtE;

    assign SrcBE = ALUSrcE ? SignImmE : WriteDataE;

    assign SrcAE = ForwardAE[1] ? (ForwardAE[0] ? 0 : ALUOutM) : (ForwardAE[0] ? Wd3E : RD1_E);

    assign WriteDataE = ForwardBE[1] ? (ForwardBE[0] ? 0 : ALUOutM) : (ForwardBE[0] ? Wd3E : RD2_E);

endmodule