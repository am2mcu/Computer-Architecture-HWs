module CarrySelect8bit(A, B, cin, cout, S);
    input[7:0] A, B;
    input cin;
    output[7:0] S;
    output cout;
    wire cs;
    wire co1, co2;
    wire[3:0] S1, S2;

    adder4 adder1(A[3:0], B[3:0], cin, cs, S[3:0]);
    adder4 adder2(A[7:4], B[7:4], 1'b0, co1, S1);
    adder4 adder3(A[7:4], B[7:4], 1'b1, co2, S2);

    assign S[7:4] = cs ? S2 : S1;
    assign cout = cs ? co2 : co1;

endmodule