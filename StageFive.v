module StageFive (clk, alu_result, memout, writeregister, RegWrite, MemToReg,muxout,Regwriteout,writeregister_new);

input clk, RegWrite, MemToReg;
input [31:0] alu_result, memout;
input [4:0] writeregister;

output [31:0] muxout;

output Regwriteout;

output [4:0] writeregister_new;

mux_2x1_32 a(alu_result,memout,MemToReg,muxout);

assign Regwriteout = RegWrite;

assign writeregister_new=writeregister;


endmodule