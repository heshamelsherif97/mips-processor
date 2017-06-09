module StageTwo(clk,WriteReg,WriteData,Writebit,instruction,pc, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest, ALUOp,outpc,data1,data2,signExt,inst15,inst20);
input [31:0] instruction,pc;
input clk;
output RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;
output [2:0] ALUOp;
output [31:0] outpc,data1,data2,signExt;
output [4:0] inst15;
output [4:0] inst20;
wire out1,out2,out3,out4,out5,out6,out7;
wire [2:0] out8;
input [4:0] WriteReg;
input [31:0] WriteData;
input Writebit;
wire [31:0] read_data_1;
wire [31:0] read_data_2;
wire [31:0] signext;

Control e(instruction[31:26], out1, out2, out3, out4, out5, out6, out7, out8);

register_file a(clk, instruction[25:21], instruction[20:16], WriteReg, WriteData, Writebit, read_data_1, read_data_2);
sign_extender_16to32 b(instruction[15:0], signext);
ID_EX_reg c(clk, pc, read_data_1, read_data_2, signext, instruction[20:16], instruction[15:11], out1, out2, out3, out4, out5, out6, out7, out8, outpc, data1, data2, signExt, inst15, inst20, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest, ALUOp );

endmodule