module FOURbyTWOMUX #(parameter WIDTH=8)
(
    input [WIDTH - 1:0] a,
    input [WIDTH - 1:0] b,
    input [WIDTH - 1:0] c,
    input [WIDTH - 1:0] d,
    input [1:0]         select,

    output reg [WIDTH - 1:0] e
);

always @(*)
begin
    case(select)
    2'b00: e = a;
    2'b01: e = b;
    2'b10: e = c;
    2'b11: e = d;
    default: e = {WIDTH{1'b0}};
    endcase
end

endmodule
