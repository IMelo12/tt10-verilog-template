//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2025 12:32:47 AM
// Design Name: 
// Module Name: multiRAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiRAM(
    input [31:0] PC_add,
    input [6:0] mem_in,
    input [7:0] data_in,
    input we,
    input clk,
    output reg [31:0] data_out
);


reg[31:0] ram_module[0:31];
integer i;

initial begin
    for(i = 0; i < 32; i = i + 1) 
        ram_module[i] <= 32'b0;
end

always @(posedge clk) begin
    if(we) begin
        ram_module[{25'b0,mem_in}] <= {24'b0,data_in};
    end
    else
        data_out <= ram_module[PC_add];
end


endmodule
