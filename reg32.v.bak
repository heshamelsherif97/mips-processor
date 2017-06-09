module reg32(clk, reset, in, out);

input [31:0] in;
input clk, reset;

output [31:0] out;
reg [31:0] out;

always@(posedge clk or negedge reset)
begin
if(reset)
begin
out<=0;
end
else
begin
out<=in;
end
end

endmodule