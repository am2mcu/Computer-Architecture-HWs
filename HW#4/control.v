module Control (
    input [5:0] Opcode, func, input Zero, lt, gt,
    output reg RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite,
    output reg [3:0] AlUOp
    );


    // pc = zero & 

    always @(Opcode)
    begin
        case (Opcode)
            6'b000000:
                begin
                    // R-Type
                    RegDst = 1'b1;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b1;

                    case (func)
                        6'b100000:
                            // add
                            AlUOp = 4'b0000;

                        6'b100010:
                            // sub
                            AlUOp = 4'b0001;

                        6'b100101:
                            // or
                            AlUOp = 4'b0011;

                        6'b100100:
                            // and
                            AlUOp = 4'b0010;

                        6'b101010:
                            // slt
                            AlUOp = 4'b0101;

                    endcase
                end
            
            // J-Type
            6'b000010:
                begin
                    // j
                    RegDst = 1'bx;
                    Jump = 1'b1;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'bx;
                    AlUOp = 4'bxxxx;
                    MemWrite = 1'b0;
                    ALUSrc = 1'bx;
                    RegWrite = 1'b0;
                end

            // I-Type
            6'b101011:
                begin
                    // sw
                    RegDst = 1'bx;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'bx;
                    AlUOp = 4'b0000;
                    MemWrite = 1'b1;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b0;
                end

            6'b100011:
                begin
                    // lw
                    RegDst = 1'b0;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b1;
                    MemToReg = 1'b1;
                    AlUOp = 4'b0000;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                end

            6'b001000:
                begin
                    // addi
                    RegDst = 1'b0;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    AlUOp = 4'b0000;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                end
            
            6'b001010:
                begin
                    // slti
                    RegDst = 1'b0;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    AlUOp = 4'b0101;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                end
            
            6'b001100:
                begin
                    // andi
                    RegDst = 1'b0;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    AlUOp = 4'b0010;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                end
            
            6'b001101:
                begin
                    // ori
                    RegDst = 1'b0;
                    Jump = 1'b0;
                    Branch = 1'b0;
                    MemRead = 1'b0;
                    MemToReg = 1'b0;
                    AlUOp = 4'b0011;
                    MemWrite = 1'b0;
                    ALUSrc = 1'b1;
                    RegWrite = 1'b1;
                end

            6'b000100:
                begin
                    // beq
                    RegDst = 1'bx;
                    Jump = 1'b0;
                    Branch = 1'b1;
                    MemRead = 1'b0;
                    MemToReg = 1'bx;
                    AlUOp = 4'b0001; // SUB -> zero
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b0;
                end
            
            6'b000101:
                begin
                    // bne
                    RegDst = 1'bx;
                    Jump = 1'b0;
                    Branch = 1'b1;
                    MemRead = 1'b0;
                    MemToReg = 1'bx;
                    AlUOp = 4'b0001; // SUB -> zero
                    MemWrite = 1'b0;
                    ALUSrc = 1'b0;
                    RegWrite = 1'b0;
                end
                
        endcase
    end

endmodule