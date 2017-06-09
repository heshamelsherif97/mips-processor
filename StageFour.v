module StageFour (clk,pcSrc,RegWrite, MemToReg, MemRead, MemWrite, Branch,ZeroFlag,outpc,alu_result,data2,mux_out,outtostage1,out1, out2, out3,out4,out5);
input  RegWrite, MemToReg, MemRead, MemWrite, Branch,ZeroFlag,clk;

input [31:0] outpc,alu_result,data2;

input [4:0] mux_out;

output pcSrc;

output [31:0] outtostage1;

output [31:0] out1, out2;

output [4:0] out3;

output out4, out5;

wire [31:0] memout ;

assign outtostage1=outpc;

and (pcSrc,Branch,ZeroFlag);


DataMemory a(clk, alu_result, MemWrite, MemRead, data2, memout);

MEM_WB_reg b(clk, alu_result, memout, mux_out, RegWrite, MemToReg, out1, out2, out3, out4, out5);



endmodule