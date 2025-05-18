module immediateGenerator(
    input [31:0] inst,
    output reg [31:0]immediate
);

wire [31:0] I_type = { {20{inst[31]}}, inst[31:20] };
wire [31:0] S_type = { {20{inst[31]}}, inst[31:25], inst[11:7] };
wire [31:0] B_type = { {20{inst[31]}}, inst[7], inst[30:25], inst[11:8],1'b0};
wire [31:0] U_type = { {12{inst[31]}}, inst[31:12]};
wire [31:0] J_type = { {12{inst[31]}}, inst[31], inst[19:12],inst[20],inst[30:21]};

always @(*) begin
        case (inst[6:0])
            7'b0010011, 
            7'b0000011, 
            7'b1100111, 
            7'b1110011: immediate = I_type; // I-type
            7'b0110111, 
            7'b0010111: immediate = U_type; // U-type
            7'b1101111: immediate = J_type; // J-type
            7'b0100011: immediate = S_type; // S-type
            7'b1100011: immediate = B_type; // B-type
            default: immediate = 32'b0; // Default case
        endcase
    end

endmodule
