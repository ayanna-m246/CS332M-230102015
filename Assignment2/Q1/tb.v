`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.08.2025 11:40:16
// Design Name: 
// Module Name: tb
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


module tb();
    reg clk, din, reset;
    wire y;
    seq_detect_mealy uut (.clk(clk),.din(din),.reset(reset),.y(y));
    always #5 clk = ~clk;
    integer i;
    initial begin
  $dumpfile("wave1.vcd");   // file to dump signals
  $dumpvars(1, tb);  // dump all signals in tb
end

    initial begin

        clk = 0; din = 0; reset = 1;
        #20 reset = 0; 
        $display("\n Stream 1:1101");
        for (i=0; i<4; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 1;
                2: din = 0;
                3: din = 1;
            endcase
            @(posedge clk);
            $display("Cycle %0d: din=%b, state=%d, y=%b", i, din, uut.state, y);
        end
        $display("\n Stream 2: Overlap 1101101");
        for (i=0; i<7; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 1;
                2: din = 0;
                3: din = 1;
                4: din = 1;
                5: din = 0;
                6: din = 1;
            endcase
            @(posedge clk);
            $display("Cycle %0d: din=%b, state=%d, y=%b", i, din, uut.state, y);
        end
        $display("\n Stream 3:1011011011001101");
        for (i=0; i<16; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 0;
                2: din = 1;
                3: din = 1;
                4: din = 0;
                5: din = 1;
                6: din = 1;
                7: din = 0;
                8: din = 1;
                9: din = 1;
                10: din = 0;
                11: din = 0;
                12: din = 1;
                13: din = 1;
                14: din = 0;
                15: din = 1;
            endcase
            @(posedge clk);
            $display("Cycle %0d: din=%b, state=%d, y=%b", i, din, uut.state, y);
        end
        $display("\n Stream 4:111101101");
        for (i=0; i<9; i=i+1) begin
            case (i)
                0: din = 1;
                1: din = 1;
                2: din = 1;
                3: din = 1;
                4: din = 0;
                5: din = 1;
                6: din = 1;
                7: din = 0;
                8: din = 1;
            endcase
            @(posedge clk);
            $display("Cycle %0d: din=%b, state=%d, y=%b", i, din, uut.state, y);
        end
        $stop;
    end

endmodule
