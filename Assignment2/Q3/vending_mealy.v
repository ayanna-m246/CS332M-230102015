`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 03:38:10
// Design Name: 
// Module Name: vendig_mealy
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


module vending_mealy (input clk,reset,input [1:0] coin,output reg dispense,chg5);
parameter S0=2'd0,S1= 2'd1,S2=2'd2,S3=2'd3;
reg [1:0] state, next_state;
always @(*) begin
case (state)
S0:next_state = (coin==2'b01)?S1:(coin==2'b10)?S2:S0;
S1:next_state = (coin==2'b01)?S2:(coin==2'b10)?S3:S1;
S2:next_state = (coin==2'b01)?S3:(coin==2'b10)?S0:S2;
S3:next_state = (coin==2'b01)?S0:(coin==2'b10)?S0:S3;
endcase
end
always @(posedge clk) begin
if (reset) begin state <= S0;
dispense<=0;
chg5<=0;
end
else begin  state <= next_state;
dispense <= (state==S3 && coin == 2'b01) || (state==S3 && coin == 2'b10) || (state==S2 && coin == 2'b10); 
chg5 <= (state==S3 && coin==2'b10);
end
end
endmodule
