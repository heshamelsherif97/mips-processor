module StageOne(clk,add_result,pcSrc, out1,out2);
wire [31:0] address;
output [31:0] out1, out2;
input pcSrc, clk;

input [31:0] add_result;

wire [31:0] pc_out,instruction,pc_4;
wire [31:0] pc_init;

reg32 b(clk,pc_init,pc_out);

mux_2x1_32 a(pc_4,add_result,pcSrc,pc_init);

pc_4 c(pc_out,pc_4);

instruction_memory d(pc_out,instruction);

IF_ID_reg e(clk,instruction,pc_4,out1,out2);


endmodule