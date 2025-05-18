module branch (
    input [31:0] A,
    input [31:0] B,
    input Unsigned,
    input [3:0] select,
    output reg branch_out
);



always @(*) begin

    branch_out = 1'b0;

    case(select)
        4'b0001:
            if(A == B) branch_out = 1'b1;
        4'b0010:
            if(A != B) branch_out = 1'b1;
        4'b0100:
            case(Unsigned)
                1'b0:
                    if(($signed(A) == $signed(B)) || ($signed(A) > $signed(B))) branch_out = 1'b1;
                1'b1:
                    if((A == B) || (A > B)) branch_out = 1'b1;
            endcase
        4'b1000:
            case(Unsigned)
                    1'b0:
                        if($signed(A) < $signed(B)) branch_out = 1'b1;
                    1'b1:
                        if(A < B) branch_out = 1'b1;
            endcase
        default: branch_out = 1'b0;
    endcase
end

endmodule
