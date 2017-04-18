module EX_MEM_reg(clk, reset, branch_address, alu_result_address, write_to_memory, rd, zeroflag, RegWrite, MemToReg, MemRead, MemWrite, Branch, out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);

input clk, reset, RegWrite, MemToReg, MemRead, MemWrite, Branch;
input [31:0] branch_address, alu_result_address, write_to_memory;
input [4:0] rd;
input  zeroflag;
output [31:0] out1, out2, out3;
reg [31:0] out1, out2, out3;
output [4:0] out4;
reg [4:0] out4;
output out5, out6, out7,out8, out9, out10;
reg out5, out6, out7,out8, out9, out10;



always@(posedge clk or negedge reset)
begin
if(reset)
begin
out1<=0;
out2<=0;
out3<=0;
out4<=0;
out5<=0;
out6<=0;
out7<=0;
out8<=0;
out9<=0;
out10<=0;
end
else
begin
out1<=branch_address;
out2<=alu_result_address;
out3<=write_to_memory;
out4<=rd;
out5<=zeroflag;
out6<=RegWrite;
out7<=MemToReg;
out8<=MemRead;
out9<=MemWrite;
out10<=Branch;
end
end
endmodule


