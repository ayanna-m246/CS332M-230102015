`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 05:11:06
// Design Name: 
// Module Name: tb4
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
module tb4();
reg clk, rst;
wire done;
link_top uut(.clk(clk), .rst(rst), .done(done));
initial clk = 0;
always #5 clk = ~clk; 
initial begin
rst = 1;
#12 rst = 0;
end
initial begin
$dumpfile("wave4.vcd");
$dumpvars(1,tb4);
$monitor("T=%0t | req=%b ack=%b data=%h last_byte=%h done=%b",$time,uut.mas.req,uut.sla.ack,uut.mas.data,uut.sla.last_byte,done);
#1000 $finish;
end
endmodule

