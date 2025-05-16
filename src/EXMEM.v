
module EXMEM(
    input branch,
    input ALU_WB,
    input mem_write,
    input write_enable,
    input jump,
    input bubble,
    input [31:0] program_counter,
    input [31:0] ALU,
    input [31:0] write_data,
    input [4:0] rd,

    output reg branch_out,
    output reg ALU_WB_out,
    output reg mem_write_out,
    output reg write_enable_out,
    output reg jump_out,
    output reg bubble_out,
    output reg [31:0] program_counter_out,
    output reg [31:0] ALU_out,
    output reg [31:0] write_data_out,
    output reg [4:0] rd_out,

    input clk,
    input clr
);

always @(posedge clk) begin
    if(clr) 
    begin
        branch_out <= 1'b0;
        ALU_WB_out <= 1'b0;
        mem_write_out <= 1'b0;
        write_enable_out <= 1'b0;
        jump_out <= 1'b0;
        bubble_out <= 1'b0;
        program_counter_out <= 32'b0;
        ALU_out <= 32'b0;
        write_data_out <= 32'b0;
        rd_out <= 5'b0;
    end

    else 
    begin
        branch_out <= branch;
        ALU_WB_out <= ALU_WB;
        mem_write_out <= mem_write;
        write_enable_out <= write_enable;
        jump_out <= jump;
        bubble_out <= bubble;
        program_counter_out <= program_counter;
        ALU_out <= ALU;
        write_data_out <= write_data_out;
        rd_out <= rd;
    end
        
end

endmodule
