module FUM_MIPS(input clock);

    reg [31:0] PC;
    wire [31:0] next_PC;
    wire [31:0] PC_4;
    assign PC_4 = PC + 32'd4;

    always @(posedge clock) begin

        PC <= next_PC;

    end
    
    wire [31:0] instruction;
    IMemBank IM(
        1'b1, PC[7:0], instruction
        );
    // IM expects 8 bits as address

    wire RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;
    wire [3:0] AlUOp;
    Control control_unit(
        instruction[31:26], instruction[5:0], RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, AlUOp
        );

    wire [31:0] read_data1, read_data2, write_data;
    wire [4:0] write_register_MUX;
    assign write_register_MUX = RegDst ? instruction[15:11] : instruction[20:16];
    RegFile RF(
        clock, instruction[25:21], instruction[20:16], write_register_MUX, write_data, RegWrite, read_data1, read_data2
        );
    
    wire [31:0] sign_extend;
    assign sign_extend = {{16{instruction[15]}}, instruction[15:0]};
    wire [31:0] ALU_MUX;
    assign ALU_MUX = ALUSrc ? sign_extend : read_data2;
    wire [31:0] ALU_result;
    wire Zero, lt, gt;
    ALU main_ALU(
        read_data1, ALU_MUX, AlUOp, ALU_result, Zero, lt, gt
        );
    
    wire [31:0] read_data_Memory;
    DMemBank MEM(
        MemRead, MemWrite, ALU_result[6:0], read_data2, read_data_Memory
        );
    // MEM expects 7 bits as address
    assign write_data = MemToReg ? read_data_Memory : ALU_result;

    wire [31:0] jump_target;
    assign jump_target = {PC_4[31:28], instruction[25:0], 2'b00};

    wire [31:0] branch_target;
    assign branch_target_MUX = (Branch & Zero) ? PC_4 + {sign_extend, 2'b00} : PC_4;

    assign next_PC = Jump ? jump_target : branch_target_MUX;

endmodule