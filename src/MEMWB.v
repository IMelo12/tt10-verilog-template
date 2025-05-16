module MEMWB(
    input ALU_WB,
    input write_enable,
    input [31:0] data,
    input [31:0] ALU,
    input [4:0] rd,

    input clk,
    input clr,

    output reg ALU_WB_out,
    output reg write_enable_out,
    output reg [31:0] data_out,
    output reg [31:0] ALU_out,
    output reg [4:0] rd_out
);

always @(posedge clk) begin
    if(clr) 
    begin
        ALU_WB_out <= 1'b0;
        write_enable_out <= 1'b0;
        data_out <= 32'b0;
        ALU_out <= 32'b0;
        rd_out <= 5'b0;
    end

    else 
    begin
        ALU_WB_out <= ALU_WB;
        write_enable_out <= write_enable;
        data_out <= data;
        ALU_out <= ALU;
        rd_out <= rd;
    end

end
endmodule
