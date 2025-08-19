`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2025 03:49:17
// Design Name: 
// Module Name: tb3
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


module tb3();
reg clk, reset;
reg [1:0] coin;
wire dispense, chg5;
vending_mealy uut (.clk(clk),.reset(reset),.coin(coin),.dispense(dispense),.chg5(chg5));
initial clk = 0;
always #5 clk = ~clk;  
initial begin
reset = 1; coin = 2'b00;
#12 reset = 0;
#10 coin = 2'b01;
#10 coin = 2'b00;
#10 coin = 2'b10;
#10 coin = 2'b00;
#10 coin = 2'b01;
#10 coin = 2'b00;
#10 coin = 2'b10;
#10 coin = 2'b00;
#10 coin = 2'b10;
#10 coin = 2'b00;
#10 coin = 2'b10;
#10 coin = 2'b00;
#10 coin = 2'b10;
#10 coin = 2'b00;
#10 coin = 2'b10;
#10 coin = 2'b01;
#10 coin = 2'b10;
#10 coin = 2'b00;
#50 $finish;
end
initial $monitor("t=%0t | coin=%b | dispense=%b | chg5=%b | state=%0d",$time, coin, dispense, chg5, uut.state);
initial begin
$dumpfile("wave3.vcd");
$dumpvars(1, tb3);
end
endmodule
