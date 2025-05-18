module instructiondecoder(
    input [31:0] instruction,
    output [4:0] rd,
    output [4:0] rs1,
    output [4:0] rs2,
    //output [3:0] ALU,
    //output immediate_select,
    //output mem_write,
    //output [3:0] branch,
    //output unsign,
    //output WE,
    //output ALU_WB,
    //output IDEX_Memread,
    //output jump,

    output reg [10:0] datapath,
    output reg [4:0] ALU_control
);

reg [6:0] opcode;
reg [2:0] func3;
reg [6:0] func7;

assign rd = instruction[11:7];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];

always @(*) begin

    opcode = instruction[6:0];
    func3 = instruction[14:12];
    func7 = instruction[31:25];

    case(opcode)
        `OP_TYPE_R:
            begin
                case(func3)
                    `funct3_add:
                        case(func7)
                            `funct7_add: datapath <= `DP_add;
                            `funct7_sub: datapath <= `DP_sub;
                        endcase
                    `funct3_xor: datapath <= `DP_xor;
                    `funct3_or:  datapath <= `DP_or;
                    `funct3_and: datapath <= `DP_and;
                    `funct3_sll: datapath <= `DP_sll;
                    `funct3_srl:
                        begin
                            case(func7)
                                `funct7_srl: datapath <= `DP_srl;
                                `funct7_sra: datapath <= `DP_sra;
                            endcase
                        end
                    `funct3_sra:  datapath <= `DP_sra;
                    `funct3_slt:  datapath <= `DP_slt;
                    `funct3_sltu: datapath <= `DP_sltu;
                endcase
            end

        `OP_TYPE_I:
            case(func3)
                `funct3_addi:  datapath <= `DP_addi;
                `funct3_xori:  datapath <= `DP_xori;
                `funct3_ori:   datapath <= `DP_ori;
                `funct3_andi:  datapath <= `DP_andi;
                `funct3_slli: datapath <= `DP_slli;
                `funct3_srli: 
                    case(func7)
                        `funct7_srli: datapath <= `DP_srli;
                        `funct7_srai: datapath <= `DP_srai;
                    endcase 
                `funct3_srai:  datapath <= `DP_srai;
                `funct3_slti:  datapath <= `DP_slti;
                `funct3_sltiu: datapath <= `DP_sltiu;
            endcase

        `OP_TYPE_I2:
            case(func3)
                `funct3_lb:  datapath <= `DP_lb;
                `funct3_lh:  datapath <= `DP_lh;
                `funct3_lw:  datapath <= `DP_lw;
                `funct3_lbu: datapath <= `DP_lbu;
                `funct3_lhu: datapath <= `DP_lhu;
            endcase

        `OP_TYPE_I3: datapath <= `DP_jalr;
            
        `OP_TYPE_I4:
            case(func3)
                `funct3_ecall:
                    case(func7)
                        `funct7_ecall: datapath <= `DP_ecall;
                        `funct7_ebreak: datapath <= `DP_ebreak;
                    endcase
            endcase

        `OP_TYPE_S:
            case(func3)
                `funct3_sb: datapath <= `DP_sb;
                `funct3_sh: datapath <= `DP_sh;
                `funct3_sw: datapath <= `DP_sw;
            endcase

        `OP_TYPE_B:
            case(func3)
                `funct3_beq: datapath <= `DP_beq;
                `funct3_bne: datapath <= `DP_bne;
                `funct3_blt: datapath <= `DP_blt;
                `funct3_bge: datapath <= `DP_bge;
                `funct3_bltu: datapath <= `DP_bltu;
                `funct3_bgeu: datapath <= `DP_bgeu;
            endcase

        `OP_TYPE_J:
				datapath <= `DP_jalr;
				

        `OP_TYPE_U: datapath <= `DP_auipc;
            

        `OP_TYPE_U2: datapath <= `DP_auipc;

        default:
            datapath <= 11'b0;
    endcase
end

//ALU control signals
always @(*) begin
    case(opcode)
        `OP_TYPE_R:
            begin
                case(func3)
                    `funct3_add:
                        case(func7)
                            `funct7_add: ALU_control <= `ALU_add;
                            `funct7_sub: ALU_control <= `ALU_sub;
                        endcase
                    `funct3_xor: ALU_control <= `ALU_xor;
                    `funct3_or:  ALU_control <= `ALU_or;
                    `funct3_and: ALU_control <= `ALU_and;
                    `funct3_sll: ALU_control <= `ALU_sll;
                    `funct3_srl:
                        begin
                            case(func7)
                                `funct7_srl: ALU_control <= `ALU_srl;
                                `funct7_sra: ALU_control <= `ALU_sra;
                            endcase
                        end
                    `funct3_slt:  ALU_control <= `ALU_slt;
                    `funct3_sltu: ALU_control <= `ALU_sltu;
                endcase
            end
            default:
                ALU_control <= 5'b0;
    endcase
end

endmodule
    
    
