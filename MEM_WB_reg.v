module MEM_WB_reg(clk, alu_result, memoryread, rd, RegWrite, MemToReg, out1, out2, out3,out4,out5);

input clk, RegWrite, MemToReg;
input [31:0] alu_result, memoryread;
input [4:0] rd;
output [31:0] out1, out2;
reg [31:0] out1, out2=0;
output [4:0] out3;
reg [4:0] out3=0;
output out4, out5;
reg out4, out5=0;




always@(posedge clk)
begin
out1<=alu_result;
out2<=memoryread;
out3<=rd;
out4<=RegWrite;
out5<=MemToReg;
end
endmodule