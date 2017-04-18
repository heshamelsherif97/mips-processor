module alu_control(func, ALUOP, aluctl);

input [5:0] func;
input [2:0] ALUOP;

output [3:0] aluctl;
reg [3:0] aluctl;

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
            3'b000 : aluctl <= ALU_add;
            3'b001 : aluctl <= ALU_beq;
				3'b111 : aluctl <= ALU_bne;
				3'b011 : aluctl <= ALU_and;
				3'b100 : aluctl <= ALU_or;
            3'b010 : case (func) 
                        F_add : aluctl <= ALU_add;
                        F_sub : aluctl <= ALU_sub;
                        F_and : aluctl <= ALU_and;
                        F_or  : aluctl <= ALU_or;
								F_sll : aluctl <= ALU_sll;
								F_srl : aluctl <= ALU_srl;
                        F_slt : aluctl <= ALU_slt;
                    endcase
        endcase
    end
endmodule
