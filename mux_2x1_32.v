module mux_2x1_32(i1, i2, select, out);

input [31:0] i1, i2;
input select;
output [31:0] out;
reg [31:0] out=0;

always@(i1 or i2 or select)
begin
if(select== 0)
begin
out <= i1;
end
else
begin
out <= i2;
end
end

endmodule