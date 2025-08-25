module slave_fsm(input  clk,rst,req,input [7:0] data_in,output ack,output reg [7:0] last_byte);
parameter WAIT_REQ = 2'd0,ACK_ASSERT = 2'd1,ACK_HOLD = 2'd2,WAIT_DROP = 2'd3;
reg [1:0] state, next_state;
reg [1:0] hold_cnt;
always @(*) begin
case (state)
WAIT_REQ:next_state = req ? ACK_ASSERT : WAIT_REQ;
ACK_ASSERT:next_state = ACK_HOLD;
ACK_HOLD:next_state = (hold_cnt == 2'd1 ? WAIT_DROP : ACK_HOLD);
WAIT_DROP:next_state = req ? WAIT_DROP : WAIT_REQ;
default:next_state = WAIT_REQ;
endcase
end
always @(posedge clk) begin
if (rst) begin
state     <= WAIT_REQ;
hold_cnt  <= 2'd0;
last_byte <= 8'd0;
end 
else begin
state <= next_state;
if (state == ACK_ASSERT) begin
last_byte <= data_in;  
hold_cnt  <= 2'd0;
end 
else if (state == ACK_HOLD) begin
hold_cnt <= hold_cnt + 2'd1;
end 
else if (state == WAIT_REQ) begin
hold_cnt <= 2'd0;
end
end
end
assign ack = (state == ACK_ASSERT) || (state == ACK_HOLD) || (state == WAIT_DROP);
endmodule
