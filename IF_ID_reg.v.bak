module IF_ID_reg(clk, reset, instruction, pc_4, out1, out2);

input clk, reset;
input [31:0] instruction, pc_4;
output [31:0] out1, out2;
reg [31:0] out1, out2;

always@(posedge clk or negedge reset)
begin
if(reset)
begin
out1<=0;
out2<=0;
end
else
begin
out1<=instruction;
out2<=pc_4;
end
end
endmodule
