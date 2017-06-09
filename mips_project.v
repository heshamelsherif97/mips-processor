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