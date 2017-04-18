module ID_EX_reg(clk, reset, pc_4, reg1, reg2, sign_extend, rt, rd, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest, ALUOp, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14);

input clk, reset, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;
input [31:0] pc_4, reg1, reg2, sign_extend;
input [4:0] rt, rd;
input [2:0] ALUOp;

output [31:0] out1, out2, out3, out4;
reg [31:0] out1, out2, out3, out4;
output [4:0] out5, out6;
reg [4:0] out5, out6;
output out7, out8, out9, out10, out11, out12, out13;
reg out7, out8, out9, out10, out11, out12, out13;
output [2:0] out14;
reg [2:0] out14;


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
out11<=0;
out12<=0;
out13<=0;
out14<=0;
end
else
begin
out1<=pc_4;
out2<=reg1;
out3<=reg2;
out4<=sign_extend;
out5<=rt;
out6<=rd;
out7<=RegWrite;
out8<=MemToReg;
out9<=MemRead;
out10<=MemWrite;
out11<=Branch;
out12<=ALUSrc;
out13<=RegDest;
out14<=ALUOp;
end
end
endmodule


