module tb1;
    reg A, B;
    wire o1, o2, o3;

    compare uut (.A(A), .B(B), .o1(o1), .o2(o2), .o3(o3));

    initial begin
        $dumpfile("compare.vcd");
        $dumpvars(0, tb1);

        A = 0; B = 0; #10;
        A = 0; B = 1; #10;
        A = 1; B = 0; #10;
        A = 1; B = 1; #10;

        $finish;
    end
endmodule
