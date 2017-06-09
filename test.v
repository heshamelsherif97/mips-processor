module add_32(a, b, result);
  input [31:0] a, b;
  output [31:0] result;

  assign result = a + b;
endmodule

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

module alu_control(func, ALUOP, aluctl);

input [5:0] func;
input [2:0] ALUOP;

output [3:0] aluctl;
reg [3:0] aluctl=0;

    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
   parameter F_sll = 6'd0;
   parameter F_srl = 6'd2;
    parameter F_slt = 6'd42;

    parameter ALU_add = 4'b0010;
    parameter ALU_sub = 4'b0110;
    parameter ALU_and = 4'b0000;
    parameter ALU_or  = 4'b0001;
   parameter ALU_sll = 4'b0100;
   parameter ALU_srl = 4'b0101;
    parameter ALU_slt = 4'b0111;
   parameter ALU_beq = 4'b1000;
   parameter ALU_bne = 4'b1001;

    always @(ALUOP or func)
    begin
        case (ALUOP) 
            3'b000 : aluctl = ALU_add;
            3'b001 : aluctl = ALU_beq;
        3'b111 : aluctl = ALU_bne;
        3'b011 : aluctl = ALU_and;
        3'b100 : aluctl = ALU_or;
            3'b010 : case (func) 
                        F_add : aluctl = ALU_add;
                        F_sub : aluctl = ALU_sub;
                        F_and : aluctl = ALU_and;
                        F_or  : aluctl = ALU_or;
                        F_sll : aluctl = ALU_sll;
                        F_srl : aluctl = ALU_srl;
                        F_slt : aluctl = ALU_slt;
                    endcase
        endcase
    end
   
   

endmodule
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

module DataMemory (clk, address, MemWrite, MemRead, writedata, readdata);

input clk, MemWrite, MemRead;
input [31:0] address, writedata;

output [31:0] readdata;


parameter RAM_SIZE = 256;
reg [31:0] RAMDATA [RAM_SIZE-1:0];

assign readdata=(MemRead && (address < RAM_SIZE))? RAMDATA[address] : 32'b0;

always@(posedge clk) begin
  if(MemWrite && (address < RAM_SIZE)) RAMDATA[address]<=writedata;
end
endmodule
module EX_MEM_reg(clk, branch_address, alu_result_address, write_to_memory, rd, zeroflag, RegWrite, MemToReg, MemRead, MemWrite, Branch, out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);

input clk,  RegWrite, MemToReg, MemRead, MemWrite, Branch;
input [31:0] branch_address, alu_result_address, write_to_memory;
input [4:0] rd;
input  zeroflag;
output [31:0] out1, out2, out3;
reg [31:0] out1, out2, out3=0;
output [4:0] out4;
reg [4:0] out4=0;
output out5, out6, out7,out8, out9, out10;
reg out5, out6, out7,out8, out9, out10=0;



always@(posedge clk)
begin
out1<=branch_address;
out2<=alu_result_address;
out3<=write_to_memory;
out4<=rd;
out5<=zeroflag;
out6<=RegWrite;
out7<=MemToReg;
out8<=MemRead;
out9<=MemWrite;
out10<=Branch;
end
endmodule


module ID_EX_reg(clk, pc_4, reg1, reg2, sign_extend, rt, rd, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest, ALUOp, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14);

input clk, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;
input [31:0] pc_4, reg1, reg2, sign_extend;
input [4:0] rt, rd;
input [2:0] ALUOp;

output [31:0] out1, out2, out3, out4;
reg [31:0] out1, out2, out3, out4=0;
output [4:0] out5, out6;
reg [4:0] out5, out6=0;
output out7, out8, out9, out10, out11, out12, out13;
reg out7, out8, out9, out10, out11, out12, out13=0;
output [2:0] out14;
reg [2:0] out14=0;


always@(posedge clk )
begin
out1<=pc_4;
out2<=reg1;
out3<=reg2;
out4<=sign_extend;
out5<=rt;
out6<=rd;
out7<=RegWrite;
out8<=MemToReg;
out9<=MemRead;
out10<=MemWrite;
out11<=Branch;
out12<=ALUSrc;
out13<=RegDest;
out14<=ALUOp;
end


endmodule





module IF_ID_reg(clk,instruction, pc_4, out1, out2);

input clk;
input [31:0] instruction, pc_4;
output [31:0] out1, out2;
reg [31:0] out1, out2=0;

always@(posedge clk)
begin
out1<=instruction;
out2<=pc_4;
end
endmodule

module MEM_WB_reg(clk, alu_result, memoryread, rd, RegWrite, MemToReg, out1, out2, out3,out4,out5);

input clk, RegWrite, MemToReg;
input [31:0] alu_result, memoryread;
input [4:0] rd;
output [31:0] out1, out2;
reg [31:0] out1, out2=0;
output [4:0] out3;
reg [4:0] out3=0;
output out4, out5;
reg out4, out5=0;




always@(posedge clk)
begin
out1<=alu_result;
out2<=memoryread;
out3<=rd;
out4<=RegWrite;
out5<=MemToReg;
end
endmodule


module mux_2x1_5(i1, i2, select, out);

input [4:0] i1, i2;
input select;
output [4:0] out;
reg [4:0] out=0;

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






module pc_4 (pc, pc_4);

input [31:0] pc;
output [31:0] pc_4;
reg [31:0] pc_4=0;

always@(pc)
begin
pc_4 <= pc + 32'd4;
end

endmodule


module reg32(clk, in, out);

input [31:0] in;
input clk;

output [31:0] out;
reg [31:0] out=0;

always@(posedge clk )

begin
out<=in;

end

endmodule

module register_file(clk, read_reg_1, read_reg_2, write_reg, write_data, regWrite, read_data_1, read_data_2);
input clk;
input [4:0] read_reg_1, read_reg_2, write_reg;
input [31:0] write_data;
input regWrite;
output [31:0] read_data_1, read_data_2;
reg [31:0] read_data_1, read_data_2=0;
reg [31:0] registers[31:0];
integer i;

  initial
  begin 
      for(i = 0; i < 32; i = i+1)
    begin
          registers[i] = 0;
    end
  end
  
always@(posedge clk)
  begin
$display("       $v0,       $v1,       $t0,       $t1,       $t2,       $t3,       $t4,       $t5,       $t6,       $t7");
$monitor("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
          registers[2][31:0], /* $v0 */
          registers[3][31:0], /* $v1 */
          registers[8][31:0], /* $t0 */
          registers[9][31:0], /* $t1 */
          registers[10][31:0],  /* $t2 */
          registers[11][31:0],  /* $t3 */
          registers[12][31:0],  /* $t4 */
          registers[13][31:0],  /* $t5 */
          registers[14][31:0],  /* $t6 */
          registers[15][31:0],  /* $t7 */
        );
end

always @ (read_reg_1 or read_reg_2)
begin
read_data_1 <= (read_reg_1==0)? 32'b0 : registers[read_reg_1];
read_data_2 <= (read_reg_2==0)? 32'b0 : registers[read_reg_2];
end
always @(posedge clk)
begin
if(regWrite)
begin
if(write_reg!=0)
begin
registers[write_reg] <= write_data;
end
end
end
endmodule

module shift_left_2(inData,outData);
  
  input [31:0]inData;
  output [31:0]outData;
  reg [31:0]outData=0;
  
  always@(inData)
    begin
      
      outData=inData<<2;
  
    end
    
endmodule   
module sign_extender_16to32(inputData, outputData);
  
  input[15:0] inputData;
  output[31:0] outputData;
  reg [31:0] outputData=0;
  
  always@(inputData)
    begin
      
      outputData[15:0]  = inputData[15:0];
      outputData[31:16] = {16{inputData[15]}};
      
    end
endmodule
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
    
module StageThree (clk,RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest,ALUOP,pc_4,data1,data2,sign_extend, rt, rd,out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);
input clk;
input RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;
input [2:0] ALUOP;

input [31:0] pc_4,data1,data2,sign_extend;

input [4:0] rt,rd;

wire [31:0] sign_extend_shifted,outpc,alub,aluout;

wire ZeroFlag;

wire [3:0] aluctl;

wire [4:0] muxout;

output [31:0] out1, out2, out3;
output [4:0] out4;
output out5, out6, out7,out8, out9, out10;


shift_left_2 a(sign_extend,sign_extend_shifted);

add_32 b(pc_4,sign_extend_shifted,outpc);

mux_2x1_32 c(data2,sign_extend,ALUSrc, alub);

alu_control d(sign_extend[5:0], ALUOP, aluctl);

ALU e(aluout, ZeroFlag, data1, alub, aluctl,sign_extend[10:6]);

mux_2x1_5 f(rt,rd,RegDest,muxout);

EX_MEM_reg g(clk, outpc, aluout, data2, muxout, ZeroFlag, RegWrite, MemToReg, MemRead, MemWrite, Branch, out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);



endmodule
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


module instruction_memory (address, instruction);

input   [31:0] address;
output [31:0] instruction;
reg [31:0] instruction_memory [16:0];

 initial
 begin
  $readmemh("instructions.txt", instruction_memory);
 end

assign instruction = instruction_memory[address[9:2]];

endmodule





module main;

reg clk=0;

wire pcSrc;

wire [31:0] add_result,instruction,pc,outtostage1,finalmux,outpc,data1,data2,sign_extend;

wire  RegWrite,Regwriteout;
wire MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest;

wire [4:0] writeregister_new,rt,rd;

wire [2:0] ALUOp;


wire [31:0] out1, out2, out3;
wire   [4:0] out4;
wire out5, out6, out7,out8, out9, out10;

wire [31:0] out11, out12;

wire [4:0] out13;

wire out14, out15;

integer i=1;


StageOne a(clk,outtostage1,pcSrc, instruction,pc);

StageTwo b(clk,writeregister_new ,finalmux, Regwriteout,instruction,pc, RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest, ALUOp,outpc,data1,data2,sign_extend,rt,rd);

StageThree c(clk,RegWrite, MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDest,ALUOp,outpc,data1,data2,sign_extend, rt, rd,out1, out2, out3, out4, out5, out6, out7,out8, out9, out10);

StageFour d(clk,pcSrc,out6, out7,out8, out9, out10,out5,out1,out2,out3,out4,outtostage1,out11, out12, out13, out14, out15);

StageFive e(clk, out11, out12, out13, out14, out15,finalmux,Regwriteout,writeregister_new);

initial #420 $finish;
 initial
  begin
   repeat (42)
   #10 clk = ~clk;
  end

always@(clk)
    begin
    $display("-------------------------------------------------");
    $monitor(" Clock Cycle:%d \n Clk:%d \n pcSrc:%d \n IF_ID.instruction:%d \n IF_ID.incrementedPC:%d \n ID_EX.incrementedPC:%d \n ID_EX.readReg1:%d \n ID_EX.readReg2:%d \n ID_EX.signextend:%d \n ID_EX.rt:%d \n ID_EX.rd:%d \n ID_EX.RegWrite:%d \n ID_EX.MemtoReg:%d \n ID_EX.MemRead:%d \n ID_EX.MemWrite:%d \n ID_EX.Branch:%d \n ID_EX.ALUsrc:%d \n ID_EX.RegDest:%d \n ID_EX.ALUOP:%d \n EX_MEM.branchaddress:%d \n EX_MEM.zeroflag:%d \n EX_MEM.aluresult:%d \n EX_MEM.register_value_tomemory:%d \n EX_MEM.rd:%d \n EX_MEM.RegWrite:%d \n EX_MEM.MemtoReg:%d \n EX_MEM.MemRead:%d \n EX_MEM.MemWrite:%d \n EX_MEM.Branch:%d \n MEM_WB.aluresult:%d \n MEM_WB.memory_wordread:%d \n MEM_WB.rd:%d \n MEM_WB.RegWrite:%d \n MEM_WB.MemtoReg:%d \n",
        
        
        i,clk,pcSrc,instruction,pc,outpc,data1,data2,sign_extend,rt,rd,RegWrite,MemToReg,MemRead,MemWrite,Branch,ALUSrc,RegDest,ALUOp,
        out1,out5,out2,out3,out4,out6,out7,out8,out9,out10,
        out11,out12,out13,out14,out15);
        
      

    end  
    
    always@(posedge clk)
    begin
    i=i+1;  
    end
    
  
  

endmodule
