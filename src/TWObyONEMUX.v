module TWObyONEMUX #(parameter WIDTH=32)
(
    input [WIDTH - 1:0]  a,
    input [WIDTH - 1:0]  b,
    input                select,
    output [WIDTH - 1:0] c
);

assign c = select? b : a;

endmodule
