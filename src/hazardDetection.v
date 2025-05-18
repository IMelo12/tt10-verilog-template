module hazardDetection(
    input [31:0] instrcution,
    input [4:0] rd,
    input memread,
    output reg stall
);

initial begin
    stall = 1'b0;
end

always @(*) begin
    if(memread == 1'b1 && (rd == instrcution[19:15]) || (rd == instrcution[24:20]))
        stall = 1'b1;
    else
        stall = 1'b0;
end

endmodule
