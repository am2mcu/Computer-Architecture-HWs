module Test();
    reg[7:0] A, B;
    reg cin;
    wire[7:0] S;
    wire cout;

    CarrySelect8bit test(A, B, cin, cout, S);

    initial begin
        A = 8'b0010;
        B = 8'b0011;
        cin = 1'b1;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);
        
        A = 8'b0010;
        B = 8'b0011;
        cin = 1'b0;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);

        A = 8'b1010;
        B = 8'b0100;
        cin = 1'b1;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);

        A = 8'b1010;
        B = 8'b0100;
        cin = 1'b0;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);

        A = 8'b01111111;
        B = 8'b00001010;
        cin = 1'b0;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);

        A = 8'b01111111;
        B = 8'b10000000;
        cin = 1'b0;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);

        A = 8'b01111111;
        B = 8'b10000000;
        cin = 1'b1;
        #10
        $display("%d + %d + %d = %d | %b | C = %b", A, B, cin, S, S, cout);
    end
endmodule