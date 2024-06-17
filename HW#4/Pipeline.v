module Pipeline(input clock, reset);

    wire RegWriteD, MemToRegD, MemWriteD, MemReadD, ALUSrcD, RegDstD, Jump, BranchD;
    wire [3:0] AlUOpD;

    wire [5:0] Opcode, Funct;
    wire [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW;
    wire RegWriteE, MemtoRegE, RegWriteM, MemtoRegM, RegWriteW;
    wire Zero, lt, gt;

    wire PcSrc, StallF, StallD, FlushE, ForwardAD, ForwardBD, EqualD;
    wire [1:0] ForwardAE, ForwardBE;

    DataPath PipelineDataPath(
        clock, reset, Jump, PCSrc, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE,
        RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, Opcode, Funct,
        EqualD, RsE, RtE, RsD, RtD, WriteRegE, WriteRegM, WriteRegW, RegWriteE, MemtoRegE, RegWriteM, MemtoRegM, RegWriteW
    );

    Control ControlUnit(
        Opcode, func, Zero, lt, gt, RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, AlUOp
    );

    Hazard HazardUnit(
        RegWriteM, RegWriteW, MemtoRegE, BranchD, RegWriteE, MemtoRegM, JumpD, RsE, RtE, RsD, RtD,
        WriteRegM, WriteRegW, WriteRegE, ForwardAE, ForwardBE, ForwardAD, ForwardBD, FlushE, StallD, StallF
    );

endmodule