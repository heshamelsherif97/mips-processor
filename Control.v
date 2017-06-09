module Control(opcode, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest, ALUOp);

input [5:0] opcode;
output RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;
output [2:0] ALUOp;
reg RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest=0;
reg [2:0] ALUOp=0;

   parameter R = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ  = 6'd4;
   parameter BNE  = 6'd5;
   parameter ORI  = 6'hD;
   parameter ANDI = 6'hC;
   parameter ADDI = 6'h8;


always@(opcode)
begin
case(opcode)

R:
begin 
RegDest=1'b1;
ALUSrc=1'b0;
MemToReg=1'b0;
RegWrite=1'b1;
MemRead=1'b0;
MemWrite=1'b0;
Branch=1'b0;
ALUOp = 3'b010; 
end

LW:
begin 
RegDest=1'b0;
ALUSrc=1'b1;
MemToReg=1'b1;
RegWrite=1'b1;
MemRead=1'b1;
MemWrite=1'b0;
Branch=1'b0;
ALUOp = 3'b000; 
end

SW:
begin 
RegDest=1'bx;
ALUSrc=1'b1;
MemToReg=1'bx;
RegWrite=1'b0;
MemRead=1'b0;
MemWrite=1'b1;
Branch=1'b0;
ALUOp = 3'b000; 
end

BEQ:
begin 
RegDest=1'bx;
ALUSrc=1'b0;
MemToReg=1'bx;
RegWrite=1'b0;
MemRead=1'b0;
MemWrite=1'b0;
Branch=1'b1;
ALUOp = 3'b001; 
end

BNE:
begin 
RegDest=1'bx;
ALUSrc=1'b0;
MemToReg=1'bx;
RegWrite=1'b0;
MemRead=1'b0;
MemWrite=1'b0;
Branch=1'b1;
ALUOp = 3'b111; 
end

ADDI:
begin 
RegDest=1'b0;
ALUSrc=1'b1;
MemToReg=1'b0;
RegWrite=1'b1;
MemRead=1'b0;
MemWrite=1'b0;
Branch=1'b0;
ALUOp = 3'b000; 
end

ORI:
begin 
RegDest=1'b0;
ALUSrc=1'b1;
MemToReg=1'b0;
RegWrite=1'b1;
MemRead=1'b0;
MemWrite=1'b0;
Branch=1'b0;
ALUOp = 3'b100; 
end

ANDI:
begin 
RegDest=1'b0;
ALUSrc=1'b1;
MemToReg=1'b0;
RegWrite=1'b1;
MemRead=1'b0;
MemWrite=1'b0;
Branch=1'b0;
ALUOp = 3'b011; 
end

endcase
end

endmodule