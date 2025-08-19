`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2025 14:18:56
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(input clk,rst,tick,output ns_g, ns_y, ns_r, ew_g, ew_y, ew_r);
parameter NS_G=2'd0, NS_Y=2'd1, EW_G=2'd2, EW_Y=2'd3;
reg [1:0] state,next_state;
reg [2:0] tick_counter;
always@(*) begin
case(state)
NS_G: next_state = NS_Y;
NS_Y: next_state = EW_G;
EW_G: next_state = EW_Y;
EW_Y: next_state = NS_G;
endcase
end
always @(posedge clk) begin
if (rst) begin
state <= NS_G;
tick_counter <= 0;
end 
else if (tick) begin  
if ((state == NS_G  && tick_counter == 3'd4) || (state == NS_Y && tick_counter == 3'd1) ||(state == EW_G  && tick_counter == 3'd4) ||(state == EW_Y && tick_counter == 3'd1))
begin
state <= next_state;
tick_counter <= 0;
end else begin
tick_counter <= tick_counter + 1;
end
end
end
assign ns_g = state == NS_G;
assign ns_y = state == NS_Y;
assign ns_r = state == EW_G;
assign ew_g = state == EW_G;
assign ew_y = state == EW_Y;
assign ew_r = state == NS_G;
endmodule
