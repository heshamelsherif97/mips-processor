module StageThree (clk,RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest,ALUOP,pc_4,data1,data2,sign_extend, rt, rd,out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);
input clk;
input RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;
input [2:0] ALUOP;

input [31:0] pc_4,data1,data2,sign_extend;

input [4:0] rt,rd;

wire [31:0] sign_extend_shifted,outpc,alub,aluout;

wire ZeroFlag;

wire [3:0] aluctl;

wire [4:0] muxout;

output [31:0] out1, out2, out3;
output [4:0] out4;
output out5, out6, out7,out8, out9, out10;


shift_left_2 a(sign_extend,sign_extend_shifted);

add_32 b(pc_4,sign_extend_shifted,outpc);

mux_2x1_32 c(data2,sign_extend,ALUSrc, alub);

alu_control d(sign_extend[5:0], ALUOP, aluctl);

ALU e(aluout, ZeroFlag, data1, alub, aluctl,sign_extend[10:6]);

mux_2x1_5 f(rt,rd,RegDest,muxout);

EX_MEM_reg g(clk, outpc, aluout, data2, muxout, ZeroFlag, RegWrite, MemToReg, MemRead, MemWrite, Branch, out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);



endmodule