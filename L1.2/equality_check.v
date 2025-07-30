module equality_check (
    input [3:0] A,
    input [3:0] B,
    output o
);

wire c0, c1, c2, c3;

// Using o2 (XNOR output) from the compare module
compare b1 (.A(A[0]), .B(B[0]), .o1(), .o2(c0), .o3()); 
compare b2 (.A(A[1]), .B(B[1]), .o1(), .o2(c1), .o3()); 
compare b3 (.A(A[2]), .B(B[2]), .o1(), .o2(c2), .o3()); 
compare b4 (.A(A[3]), .B(B[3]), .o1(), .o2(c3), .o3()); 

assign o = c0 & c1 & c2 & c3;

endmodule
