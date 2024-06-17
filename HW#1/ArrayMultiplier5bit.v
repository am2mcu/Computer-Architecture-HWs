module FA(sout,cout,a,b,cin);
    output sout,cout;
    input a,b,cin;
    assign sout=(a^b^cin);
    assign cout=((a&b)|(a&cin)|(b&cin));
endmodule

module multiply5bits(product,inp1,inp2);
    output [9:0]product;
    input [4:0]inp1;
    input [4:0]inp2;
    wire x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31;


    assign product[0]=(inp1[0]&inp2[0]);

    FA HA1(product[1],x1,(inp1[1]&inp2[0]),(inp1[0]&inp2[1]),1'b0);
    FA FA1(x2,x3,(inp1[1]&inp2[1]),(inp1[0]&inp2[2]),x1);
    FA FA2(x4,x5,(inp1[1]&inp2[2]),(inp1[0]&inp2[3]),x3);
    FA HA2(x6,x7,(inp1[1]&inp2[3]),(inp1[0]&inp2[4]),x5);

    FA HA3(product[2],x15,x2,(inp1[2]&inp2[0]),1'b0);
    FA FA5(x14,x16,x4,(inp1[2]&inp2[1]),x15);
    FA FA4(x13,x17,x6,(inp1[2]&inp2[2]),x16);
    FA FA3(x9,x8,x7,(inp1[2]&inp2[3]),x17);

    FA HA4(product[3],x12,x14,(inp1[3]&inp2[0]),1'b0);
    FA FA8(x18,x11,x13,(inp1[3]&inp2[1]),x12);
    FA FA7(x19,x10,x9,(inp1[3]&inp2[2]),x11);
    FA FA6(x21,x20,x8,(inp1[3]&inp2[3]),x10);

    FA HA5(product[4],x22,x18,(inp1[4]&inp2[0]),1'b0);
    FA FA11(x24,x23,x19,(inp1[4]&inp2[1]),x22);
    FA FA10(x26,x25,x21,(inp1[4]&inp2[2]),x23);
    FA FA9(x28,x27,x20,(inp1[4]&inp2[3]),x25);

    FA HA6(product[5],x29,x24,(inp1[1]&inp2[4]),1'b0);
    FA FA14(product[6],x30,x26,(inp1[2]&inp2[4]),x29);
    FA FA13(product[7],x31,x28,(inp1[3]&inp2[4]),x30);
    FA FA12(product[8],product[9],x27,(inp1[4]&inp2[4]),x31);

endmodule