module EX_MEM_reg(clk, branch_address, alu_result_address, write_to_memory, rd, zeroflag, RegWrite, MemToReg, MemRead, MemWrite, Branch, out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);

input clk,  RegWrite, MemToReg, MemRead, MemWrite, Branch;
input [31:0] branch_address, alu_result_address, write_to_memory;
input [4:0] rd;
input  zeroflag;
output [31:0] out1, out2, out3;
reg [31:0] out1, out2, out3=0;
output [4:0] out4;
reg [4:0] out4=0;
output out5, out6, out7,out8, out9, out10;
reg out5, out6, out7,out8, out9, out10=0;



always@(posedge clk)
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
endmodule