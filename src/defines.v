
`ifndef DEFINES_HH
`define DEFINES_HH


`define OP_TYPE_R  7'b0110011
`define OP_TYPE_I  7'b0010011
`define OP_TYPE_I2 7'b0000011 //load
`define OP_TYPE_I3 7'b1100111 //jalr
`define OP_TYPE_I4 7'b1110011 //ecall, ebreak
`define OP_TYPE_S  7'b0100011
`define OP_TYPE_B  7'b1100011
`define OP_TYPE_J  7'b1101111
`define OP_TYPE_U  7'b0110111
`define OP_TYPE_U2 7'b0010111


// opcodes
`define OP_add  OP_TYPE_R
`define OP_sub  OP_TYPE_R
`define OP_xor  OP_TYPE_R
`define OP_or   OP_TYPE_R
`define OP_and  OP_TYPE_R
`define OP_sll  OP_TYPE_R
`define OP_srl  OP_TYPE_R
`define OP_sra  OP_TYPE_R
`define OP_slt  OP_TYPE_R
`define OP_sltu OP_TYPE_R

// funct3
`define funct3_add  3'b000
`define funct3_sub  3'b000
`define funct3_xor  3'b100
`define funct3_or   3'b110
`define funct3_and  3'b111
`define funct3_sll  3'b001
`define funct3_srl  3'b101
`define funct3_sra  3'b101
`define funct3_slt  3'b010
`define funct3_sltu 3'b011

`define funct3_addi  3'b000
`define funct3_xori  3'b100
`define funct3_ori   3'b110
`define funct3_andi  3'b111
`define funct3_slli  3'b001
`define funct3_srli  3'b101
`define funct3_srai  3'b101
`define funct3_slti  3'b010
`define funct3_sltiu 3'b011

`define funct3_lb    3'b000
`define funct3_lh    3'b001
`define funct3_lw    3'b010
`define funct3_lbu   3'b100
`define funct3_lhu   3'b101

`define funct3_sb    3'b000
`define funct3_sh    3'b001
`define funct3_sw    3'b010

`define funct3_beq   3'b000
`define funct3_bne   3'b001
`define funct3_blt   3'b100
`define funct3_bge   3'b101
`define funct3_bltu  3'b110
`define funct3_bgeu  3'b111

`define funct3_jalr  3'b000

`define funct3_ecall 3'b000
`define funct3_ebreak 3'b000




// funct7
`define funct7_add  7'b0000000
`define funct7_sub  7'b0010100
`define funct7_xor  7'b0000000
`define funct7_or   7'b0000000
`define funct7_and  7'b0000000
`define funct7_sll  7'b0000000
`define funct7_srl  7'b0000000
`define funct7_sra  7'b0010100
`define funct7_slt  7'b0000000
`define funct7_sltu 7'b0000000

`define funct7_slli 7'b0000000
`define funct7_srli 7'b0000000
`define funct7_srai 7'b0010100

`define funct7_ecall 7'b0000000
`define funct7_ebreak 7'b000001

// datapath

/*--------------------------------------------------
 datapath signals are 11 bits wide
 0: immediate select
 1: mem_write - store
 2 - 5: branch
 6: unsign - sltu, sltui, lbu, lhu, bltu, bgeu
 7: write_enable - first 24 and 33-36
 8: alu_wb - first 19
 9: IDEX_memread - I_type
 10: jump

*/

`define DP_add   11'b00110000000
`define DP_sub   11'b00110000000
`define DP_xor   11'b00110000000
`define DP_or    11'b00110000000
`define DP_and   11'b00110000000
`define DP_sll   11'b00110000000
`define DP_srl   11'b00110000000
`define DP_sra   11'b00110000000
`define DP_slt   11'b00110000000
`define DP_sltu  11'b00110000000

`define DP_addi  11'b00110000001
`define DP_xori  11'b00110000001
`define DP_ori   11'b00110000001
`define DP_andi  11'b00110000001
`define DP_slli  11'b00110000001
`define DP_srli  11'b00110000001
`define DP_srai  11'b00110000001
`define DP_slti  11'b00110000001
`define DP_sltiu 11'b00111000001

`define DP_lb    11'b01010000000
`define DP_lh    11'b01010000000
`define DP_lw    11'b01010000000
`define DP_lbu   11'b01010000000
`define DP_lhu   11'b01010000000

`define DP_sb    11'b00000000010
`define DP_sh    11'b00000000010
`define DP_sw    11'b00000000010

`define DP_beq   11'b00000000100
`define DP_bne   11'b00000001000
`define DP_blt   11'b00000001100
`define DP_bge   11'b00000010000
`define DP_bltu  11'b00000010100
`define DP_bgeu  11'b00000011000

`define DP_jal    11'b10000000000
`define DP_jalr   11'b10000000000
`define DP_lui    11'b0
`define DP_auipc  11'b0
`define DP_ecall  11'b0
`define DP_ebreak 11'b0


// ALU op-codes
`define ALU_add   5'b00000
`define ALU_sub   5'b00001 
`define ALU_xor   5'b00010 
`define ALU_or    5'b00011
`define ALU_and   5'b00100 
`define ALU_sll   5'b00101 
`define ALU_srl   5'b00110 
`define ALU_sra   5'b00111 
`define ALU_slt   5'b01000 
`define ALU_sltu  5'b01001 
`define ALU_addi  5'b01010 
`define ALU_xori  5'b01011 
`define ALU_ori   5'b01100 
`define ALU_andi  5'b01101 
`define ALU_slli  5'b01110 
`define ALU_srli  5'b01111 
`define ALU_srai  5'b10000
`define ALU_slti  5'b10001 
`define ALU_sltiu 5'b10010

`endif
