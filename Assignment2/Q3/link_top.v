`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 04:46:25
// Design Name: 
// Module Name: link_top
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
module link_top(input clk,rst,output done);
wire req, ack;
wire [7:0] data,last_byte;
master_fsm mas(.clk(clk),.rst(rst),.ack(ack),.req(req),.data(data),.done(done));
slave_fsm sla(.clk(clk),.rst(rst),.req(req), .data_in(data),.ack(ack),.last_byte(last_byte));
endmodule


