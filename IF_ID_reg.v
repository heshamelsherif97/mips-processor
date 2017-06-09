module IF_ID_reg(clk,instruction, pc_4, out1, out2);

input clk;
input [31:0] instruction, pc_4;
output [31:0] out1, out2;
reg [31:0] out1, out2=0;

always@(posedge clk)
begin
out1<=instruction;
out2<=pc_4;
end
endmodule