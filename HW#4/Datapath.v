module DataPath(input wire clock, reset, Jump, PCSrc, StallF, StallD, FlushE, ForwardAD, ForwardBD, ForwardAE, ForwardBE,
    RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, output wire [5:0] Opcode, Funct,
    output wire EqualD, output wire [4:0] RsE, RtE, RsD, RtD, WriteRegE, WriteRegM, WriteRegW,
    output wire RegWriteE, MemtoRegE, RegWriteM, MemtoRegM, RegWriteW, Zero, lt, gt);

    wire [31:0] PCPlus4F, PCBranchD, PCJumpD, PCin;
    wire [31:0] InstrF;
    wire [1:0] PCSrcD;
    wire CLRF;    
    wire [31:0] PCPlus4D;    
    wire [31:0] InstrD, ResultW;
    wire [31:0] RD1_D, RD2_D, SignImmD;  
    wire [4:0] RdD;

    wire MemWriteE;
    wire [3:0] ALUControlE;
    wire ALUSrcE, RegDstE;
    wire [31:0]  RD1_E, RD2_E, SignImmE;
    wire [4:0] RdE;
    wire [31:0] ALUOutE, WriteDataE;

    wire MemWriteM;
    wire [31:0] ALUOutM, WriteDataM, ReadDataM;

    wire [31:0] ReadDataW;
    wire MemtoRegW;     
    wire [31:0] ALUOutW;

    assign PCSrcD = {Jump,PCSrc}; // PC input Mux
    assign ClearF = |(PCSrcD); // if PCSrcD = 2'b10 | 2'b01 (jump | branch) then clear = 1
    assign Opcode = InstrD[31:26]; // Decoded instruction Opcode
    assign Funct = InstrD[5:0]; // Decoded instruction Function

    assign PCin = Jump ? (PCSrc ? 0 : PCJumpD) : (PCSrc ? PCBranchD : PCPlus4F); // PC input Mux

    FetchStage Fetch(clock, reset, StallF, PCin, PCPlus4F, InstrF); // fetch stage

    FetchToDecode FDReg(clock, reset, PCPlus4F, InstrF, StallD, ClearF, PCPlus4D, InstrD); // if not stall save PC & Instr in IF/ID Reg

    DecodeStage Decode(InstrD, PCPlus4D, ALUOutM, WriteRegW, RegWriteW, ResultW, reset, clock, ForwardAD, ForwardBD, RD1_D, RD2_D, SignImmD, PCBranchD, ShifterOut_26, RsD, RtD, RdD, EqualD);

    DecodeToExecute DXReg(RegWriteD, MemtoRegD, MemWriteD, ALUControlD, ALUSrcD, RegDstD, RD1_D, RD2_D, RsD, RtD, RdD, ClearF, clock, reset,
    SignImmD,RegWriteE, MemtoRegE, MemWriteE, ALUControlE, ALUSrcE, RegDstE, RD1_E, RD2_E, RsE, RtE, RdE, SignImmE);

    ExecuteStage Execute(ALUSrcE,RegDstE, ForwardAE, ForwardBE, ALUControlE, RD1_E, RD2_E, SignImmE, RsE, RtE, RdE, Wd3E, ALUOutM, ALUOutE, WriteDataE, WriteRegE, Zero, lt, gt);

    ExecuteToMemory EMReg(clock, reset, RegWriteE, MemtoRegE, MemWriteE, ALUOutE, WriteDataE, WriteRegE, RegWriteM, MemtoRegM, MemWriteM, ALUOutM, WriteDataM, WriteRegM);

    DMemBank DataMemory(1'b1, MemWriteM, ALUOutM, WriteDataM, ReadDataM);

    MemoryToWriteBack MWReg(clock, reset, RegWriteM, MemtoRegM, ALUOutM, WriteRegM, RD, RegWriteW, MemtoRegW,  ALUOutW, WriteRegW, ReadDataW);

    assign ResultW = MemtoRegW ? ReadDataW : ALUOutW;

endmodule