module program_counter(
	input clk,
	input clr,
	input stall,
	input [31:0] counter_in,
	output reg [31:0] count_out
);

always @(posedge clk) begin
	if(clr) begin
		count_out <= 32'b0;
	end
	else if(stall) begin
		count_out <= count_out;
	end
	else begin
		count_out <= counter_in;
	end
end

endmodule
