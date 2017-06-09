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