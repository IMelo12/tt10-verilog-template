module registerFile(
input [4:0] select,
input [31:0]data_in,
input write_enable,
input clk,
input [4:0]rs2,
input [4:0]rs1,
output [31:0]rs1_out,
output [31:0]rs2_out
);

reg[31:0] register[31:0];
integer i;

initial begin
	for(i = 0; i<32; i = i + 1)
		register[i] <= 32'b0;
end

always@(posedge clk) begin
	if(write_enable) begin
		register[select] <= data_in;
	end
end

// asynchronus read
assign rs1_out = register[rs1];
assign rs2_out = register[rs2];

endmodule
		
		
		
