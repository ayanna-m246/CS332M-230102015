module compare (
    input A,B,
    output o1,o2,o3
);
    assign o1 = A & ~B;               
    assign o2 = (A & B) | (~A & ~B);  
    assign o3 = B & ~A;              
endmodule
