`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2025 11:07:31
// Design Name: 
// Module Name: seq_detect_mealy
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seq_detect_mealy(input clk,din,reset,output y);
parameter A=2'd0,B=2'd1,C=2'd2,D=2'd3;
reg [1:0] state,next_state;
always@(*) begin
case(state)
A:next_state = din?B:A;
B:next_state = din?C:A;
C:next_state = din?C:D;
D:next_state = din?B:A;
endcase
end
always@(posedge clk) begin
if(reset) state<=A;
else state<=next_state;
end
assign y = (state==D)&din;
endmodule
