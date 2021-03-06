module ALU (OUT, ZeroFlag, In1, In2, ALUOP,shift);
input [31:0] In1, In2;
input [3:0] ALUOP;
input [4:0] shift;
output [31:0] OUT ;
reg [31:0] OUT=0;
output ZeroFlag;
reg ZeroFlag=0;
always @ (In1 or In2 or ALUOP)
begin
case (ALUOP)
4'b0010 : OUT = In1 + In2;
4'b0110 : OUT = In1 - In2;
4'b0000 : OUT = In1 & In2;
4'b0001 : OUT = In1 | In2;
4'b0100 : OUT = In2 << shift;
4'b0101 : OUT = In2 >> shift;
4'b0111 : OUT = In1 < In2;
4'b1000 : if(In1==In2) ZeroFlag=1; else ZeroFlag=0;
4'b1001 : if(In1!=In2) ZeroFlag=1; else ZeroFlag=0;
endcase
end

endmodule