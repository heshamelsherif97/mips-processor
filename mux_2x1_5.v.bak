module mux_2x1_5(i1, i2, select, out);

input [4:0] i1, i2;
input select;
output [4:0] out;
reg [4:0] out;

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

