module MEM_WB_reg(clk, reset, alu_result, memoryread, rd, RegWrite, MemToReg, out1, out2, out2, out3, out4, out5);

input clk, reset, RegWrite, MemToReg;
input [31:0] alu_result, memoryread;
input [4:0] rd;
output [31:0] out1, out2;
reg [31:0] out1, out2;
output [4:0] out3;
reg [4:0] out3;
output out4, out5;
reg out4, out5;




always@(posedge clk or negedge reset)
begin
if(reset)
begin
out1<=0;
out2<=0;
out3<=0;
out4<=0;
out4<=0;
end
else
begin
out1<=alu_result;
out2<=memoryread;
out3<=rd;
out4<=RegWrite;
out5<=MemToReg;
end
end
endmodule


