module Hazard(
    input wire RegWriteM, RegWriteW, MemtoRegE, BranchD, RegWriteE, MemtoRegM, JumpD,
    input wire [4:0] RsE, RtE, RsD, RtD, WriteRegM, WriteRegW, WriteRegE,
    output reg [1:0] ForwardAE, ForwardBE,
    output wire ForwardAD, ForwardBD,
    output wire FlushE, StallD, StallF
);

    wire lwstall, branchstall;

    always @(*) 
    begin
        if ((RsE != 5'b0) && (RsE == WriteRegM) && RegWriteM) 
        begin
            ForwardAE = 2'b10;
        end
        else if ((RsE != 5'b0) && (RsE == WriteRegW) && RegWriteW)
        begin 
            ForwardAE = 2'b01;
        end
        else
        begin 
            ForwardAE = 2'b00;
        end
    end

    always @(*) 
    begin
        if ((RtE != 5'b0) && (RtE == WriteRegM) && RegWriteM) 
        begin
            ForwardBE = 2'b10;
        end
        else if ((RtE != 5'b0) && (RtE == WriteRegW) && RegWriteW) 
        begin
            ForwardBE = 2'b01;
        end
        else 
        begin
            ForwardBE = 2'b00;
        end
    end

    assign lwstall = ((RsD == RtE) || (RtD == RtE)) && MemtoRegE;
    assign branchstall = (BranchD && RegWriteE && ((WriteRegE == RsD) || (WriteRegE == RtD))) || (BranchD && MemtoRegM && ((WriteRegM == RsD) || (WriteRegM == RtD)));

    assign ForwardAD = (RsD != 5'b0) && (RsD == WriteRegM) && RegWriteM;
    assign ForwardBD = (RtD != 5'b0) && (RtD == WriteRegM) && RegWriteM;

    assign StallF = lwstall || branchstall;
    assign StallD = lwstall || branchstall;
    assign FlushE = lwstall || branchstall || JumpD;

endmodule