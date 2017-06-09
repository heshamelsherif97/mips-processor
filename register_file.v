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