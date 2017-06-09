module pc_4 (pc, pc_4);

input [31:0] pc;
output [31:0] pc_4;
reg [31:0] pc_4=0;

always@(pc)
begin
pc_4 <= pc + 32'd4;
end

endmodule