
module ALU(
    input [31:0] a,
    input [31:0] b,
    input [4:0]  select,

    output reg [31:0] result
);

`include "defines.v"

always @(*) begin
    case(select)
        `ALU_add: result <= a + b;
        `ALU_sub: result <= a - b;
        `ALU_xor: result <= a ^ b;
        `ALU_or:  result <= a | b;
        `ALU_and: result <= a & b;
        `ALU_sll: result <= a << b;
        `ALU_srl: result <= a >> b;
        `ALU_sra: result <= a >>> b;
        `ALU_slt: result <= ($signed(a) < $signed(b))? 32'b1 : 32'b0;
        `ALU_sltu: result <= (a < b)? 32'b1 : 32'b0;
        `ALU_addi: result <= a + b;
        `ALU_ori: result <= a | b;
        `ALU_andi: result <= a & b;
        `ALU_slli: result <= a << b;
        `ALU_srli: result <= a >> b;
        `ALU_srai: result <= a >>> b;
        `ALU_slti: result <= (a < b)? 32'b1 : 32'b0;
        `ALU_sltiu: result <= (a < b)? 32'b1 : 32'b0;
    endcase
end

endmodule
