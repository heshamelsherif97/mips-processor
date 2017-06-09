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