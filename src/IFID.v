module IFID(
	input [31:0]instruction_in, 
	input [31:0]PC_in,
	input clk,
	input clr,
	input stall,
	output reg [31:0]instruction_out,
	output reg [31:0]PC_out
);


always@(posedge clk) begin
	if(clr) begin
		instruction_out <= 32'b0;
		PC_out <= 32'b0;
	end
	else if(!stall)begin
		instruction_out <= instruction_out;
		PC_out <= PC_out;
	end
	else begin
		instruction_out <= instruction_in;
		PC_out <= PC_in;
	end
end

endmodule
