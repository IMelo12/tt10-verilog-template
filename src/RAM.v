module RAM #(parameter DEPTH=10, parameter WIDTH=8)(
    input clk,
    input write_enable,
    input [WIDTH-1:0] data,
    input [DEPTH-1:0] address,
    output reg [31:0] data_out
);


    reg[31:0] ram_module[0:2**DEPTH - 1];
integer i;

initial begin
    for(i = 0; i < DEPTH; i = i + 1) 
        ram_module[i] <= {32{1'b0}};
end

always @(posedge clk) begin
    if(write_enable) 
        ram_module[address] <= {{(32-WIDTH){1'b0}}, data};
    else 
        data_out <= ram_module[address];
end

endmodule
