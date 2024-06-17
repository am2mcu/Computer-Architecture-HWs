module Test();
    reg [4:0] inp1, inp2;
    wire [9:0] result;

    multiply5bits mult5 (result, inp1, inp2);

    initial begin
        inp1 = 31;
        inp2 = 31;
        #10
        $display("%d x %d = %d | %b", inp1, inp2, result, result);

        inp1 = 4;
        inp2 = 8;
        #10
        $display("%d x %d = %d | %b", inp1, inp2, result, result);

        inp1 = 10;
        inp2 = 20;
        #10
        $display("%d x %d = %d | %b", inp1, inp2, result, result);

        inp1 = 12;
        inp2 = 13;
        #10
        $display("%d x %d = %d | %b", inp1, inp2, result, result);
    end

endmodule