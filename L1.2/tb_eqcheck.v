module tb_eqcheck;
    reg [3:0] A, B;
    wire o;

    equality_check uut (.A(A), .B(B), .o(o));

    initial begin
        $dumpfile("equality.vcd");
        $dumpvars(0, tb_eqcheck);

        A = 4'b0000; B = 4'b0000; #10;
        A = 4'b1010; B = 4'b1010; #10;
        A = 4'b1111; B = 4'b1110; #10;
        A = 4'b0011; B = 4'b0011; #10;
        A = 4'b1100; B = 4'b0001; #10;

        $finish;
    end
endmodule
