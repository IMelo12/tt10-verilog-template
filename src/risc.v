module risc(
    input clk,
    input rst_n,
    input [6:0] inst_address,
    input [7:0] inst_data,
    input inst_we,
    output [7:0] memory_out,
    output [7:0] debug
);

//debug 
wire [7:0] debug_bus;
assign debug = debug_bus;

// IF STAGE
wire [31:0] PC_out;
wire [31:0] PCADD_out;
wire [31:0] PCMuxOut;
wire [31:0] inst_memory_IF;

// ID STAGE
wire HZD_stall;
wire [31:0] PC_ID;
wire [31:0] instruction_ID;
wire [4:0] rd_ID;
wire [4:0] rs1_ID;
wire [4:0] rs2_ID;
wire [10:0] datapath_ID;
wire [4:0] ALU_ID;
wire [31:0] imm_ID;

wire [31:0] rs1_val_ID;
wire [31:0] rs2_val_ID;

// EX STAGE
wire [31:0] PC_EX;
wire [4:0] rd_EX;
wire [4:0] rs1_EX;
wire [4:0] rs2_EX;
wire [31:0] immediate_EX;
wire [31:0] rs1_val_EX;
wire [31:0] rs2_val_EX;
wire bubble_EX;

wire [10:0] datapath_EX;
wire [31:0] mux1_out;
wire [31:0] mux3_out;
wire [31:0] adder1_out;
wire [1:0] MUX_SEL_A;
wire [1:0] MUX_SEL_B;

wire [31:0] ALU_INA;
wire [31:0] ALU_INB;
wire [31:0] ALU_OUT_EX;
wire [4:0] ALU_control_EX;

wire branch_unit_out_EX;

// MEM STAGE
wire [31:0] PC_MEM;
wire MEM_branch;
wire MEM_jump;
wire ALU_WB_MEM;
wire memWrite_MEM;
wire bubble_MEM;
//wire [31:0] ALU_MEM;
wire [31:0] write_data_MEM;
wire PC_muxSel = MEM_branch | MEM_jump;
wire [31:0] ALU_VAL_MEM;
wire [4:0] rd_MEM;
wire write_enable_MEM;
wire [31:0] memory_MEM;
// WB STAGE
wire [31:0] ALU_FORWARD_WB;
wire [31:0] ALU_DATA_WB;
wire [4:0] rd_WB;
wire ALU_WB;
wire write_enable_WB;
wire [31:0] data_out_WB;


(* dont_touch = "true" *) adder PC_add(
    .a(PC_out),
    .b(32'b01),
    .y(PCADD_out)
);

(* dont_touch = "true" *) TWObyONEMUX #(.WIDTH(32)) PCMux(
    .a(PCADD_out),
    .b(PC_MEM),
    .select(PC_muxSel),
    .c(PCMuxOut)
);

(* dont_touch = "true" *) program_counter PC(
    .clk(clk),
    .clr(rst_n),
    .stall(HZD_stall),
    .counter_in(PCMuxOut),
    .count_out(PC_out)
);

(* dont_touch = "true" *) multiRAM progRAM(
    .clk(clk),
    .we(inst_we),
    .PC_add(PC_out),
    .mem_in(inst_address),
    .data_in(inst_data),
    .data_out(inst_memory_IF)
);
//assign INSTRUCTION_MEM_IN = PC_out;

(* dont_touch = "true" *) IFID IFID_reg(
    .instruction_in(inst_memory_IF), //need ROM 
    .PC_in(PC_out),
    .clk(clk),
    .clr(rst_n),
    .stall(HZD_stall),
    .instruction_out(instruction_ID),
    .PC_out(PC_ID)
);

(* dont_touch = "true" *) instructiondecoder Decoder(
    .instruction(instruction_ID),
    .rd(rd_ID),
    .rs1(rs1_ID),
    .rs2(rs2_ID),
    .datapath(datapath_ID),
    .ALU_control(ALU_ID)
);

(* dont_touch = "true" *)immediateGenerator immgen(
    .inst(instruction_ID),
    .immediate(imm_ID)
);

(* dont_touch = "true" *) registerFile REGFILE(
    .select(rd_WB),
    .data_in(ALU_FORWARD_WB),
    .write_enable(write_enable_WB),
    .clk(clk),
    .rs2(rs2_ID),
    .rs1(rs1_ID),
    .rs1_out(rs1_val_ID),
    .rs2_out(rs2_val_ID)
);

(* dont_touch = "true" *) hazardDetection HZD(
    .instrcution(instruction_ID),
    .rd(rd_EX),
    .memread(datapath_EX[9]),
    .stall(HZD_stall)
);

(* dont_touch = "true" *) IDEX IDEX_reg(
    .rs1(rs1_ID),
    .rs2(rs2_ID),
    .PC_IN(PC_ID),
    .immediate(imm_ID),
    .ALU_control(ALU_ID),
    .rd(rd_ID),
    .rs1_val(rs1_val_ID),
    .rs2_val(rs2_val_ID),
    .datapath(datapath_ID),
    .clk(clk),
    .clr(rst_n),
    .stall(HZD_stall),
    .rs1_out(rs1_EX),
    .rs2_out(rs2_EX),
    .PC_IN_out(PC_EX),
    .ALU_out(ALU_control_EX),
    .rd_out(rd_EX),
    .immediate_out(immediate_EX),
    .rs1_val_out(rs1_val_EX),
    .rs2_val_out(rs2_val_EX),
    .datapath_out(datapath_EX),
    .bubble(bubble_EX)
);

// PC FORWARD 
(* dont_touch = "true" *)TWObyONEMUX #(.WIDTH(32)) MUX1(
    .a(PC_EX),
    .b(rs1_val_EX),
    .select(datapath_EX[10]),
    .c(mux1_out)
);

(* dont_touch = "true" *) adder #(.WIDTH(32)) adder1(
    .a(mux1_out),
    .b(PC_EX),
    .y(adder1_out)
);

(* dont_touch = "true" *) branch branch_unit(
    .A(ALU_INA),
    .B(rs2_val_EX),
    .Unsigned(datapath_EX[6]),
    .select(datapath_EX[5:2]),
    .branch_out(branch_unit_out_EX)
);

// ALU AND FORWARDING

(* dont_touch = "true" *) forwardingUnit forward(
    .rs1(rs1_EX),
    .rs2(rs2_EX),
    .rdmem(rd_MEM),
    .rdwb(rd_WB),
    .regWrite_Wb(write_enable_WB),
    .regWrite_Mem(write_enable_MEM),
    .A(MUX_SEL_A),
    .B(MUX_SEL_B)
);

(* dont_touch = "true" *) FOURbyTWOMUX #(.WIDTH(32))MUX2(
    .a(rs1_val_EX),
    .b(ALU_FORWARD_WB),
    .c(ALU_VAL_MEM),
    .d(32'b0),
    .select(MUX_SEL_A),
    .e(ALU_INA)
);

(* dont_touch = "true" *) FOURbyTWOMUX #(.WIDTH(32)) MUX3(
    .a(rs2_val_EX),
    .b(ALU_FORWARD_WB),
    .c(ALU_VAL_MEM),
    .d(32'b0),
    .select(MUX_SEL_B),
    .e(mux3_out)
);

(* dont_touch = "true" *) TWObyONEMUX #(.WIDTH(32)) MUX4(
    .a(mux3_out),
    .b(immediate_EX),
    .select(datapath_EX[0]),
    .c(ALU_INB)
);

(* dont_touch = "true" *) ALU ALU_EX(
    .a(ALU_INA),
    .b(ALU_INB),
    .select(ALU_control_EX),
    .result(ALU_OUT_EX)
);

(* dont_touch = "true" *) EXMEM EXMEM_REG(
    .branch(branch_unit_out_EX),
    .ALU_WB(datapath_EX[8]),
    .mem_write(datapath_EX[1]),
    .write_enable(datapath_EX[7]),
    .jump(datapath_EX[10]),
    .bubble(bubble_EX),
    .program_counter(adder1_out),
    .ALU(ALU_OUT_EX),
    .write_data(mux3_out),
    .rd(rd_EX),
    .branch_out(MEM_branch),
    .ALU_WB_out(ALU_WB_MEM),
    .mem_write_out(memWrite_MEM),
    .write_enable_out(write_enable_MEM),
    .jump_out(MEM_jump),
    .bubble_out(bubble_MEM),
    .program_counter_out(PC_MEM),
    .ALU_out(ALU_VAL_MEM),
    .write_data_out(write_data_MEM),
    .rd_out(rd_MEM),
    .clk(clk),
    .clr(rst_n)
);


// MEM STAGE


(* dont_touch = "true" *) RAM #(.DEPTH(32), .WIDTH(32)) mainMEM(
    .clk(clk),
    .write_enable(memWrite_MEM),
    .data(write_data_MEM),
    .address(ALU_VAL_MEM),
    .data_out(memory_MEM)
);

assign memory_out = memory_MEM[7:0];


(* dont_touch = "true" *) MEMWB memwbreg(
    .ALU_WB(ALU_WB_MEM),
    .write_enable(write_enable_MEM),
    .data(memory_MEM),
    .ALU(ALU_VAL_MEM),
    .rd(rd_MEM),
    .clk(clk),
    .clr(rst_n),
    .ALU_WB_out(ALU_WB),
    .write_enable_out(write_enable_WB),
    .data_out(data_out_WB),
    .ALU_out(ALU_DATA_WB),
    .rd_out(rd_WB)
);

(* dont_touch = "true" *) TWObyONEMUX #(.WIDTH(32)) WBMUX(
    .a(data_out_WB),
    .b(ALU_DATA_WB),
    .select(ALU_WB),
    .c(ALU_FORWARD_WB)
);

assign debug_bus = PCADD_out ^ PCMuxOut ^ PC_out ^ inst_memory_IF 
    ^ PC_ID ^ ALU_ID ^ imm_ID ^ rs2_val_ID ^ HZD_stall ^ bubble_EX 
    ^ mux1_out ^ adder1_out ^ branch_unit_out_EX ^ MUX_SEL_B ^ ALU_INA
    ^ mux3_out ^ ALU_INB ^ ALU_OUT_EX ^ rd_MEM ^ memory_MEM ^ rd_WB ^ ALU_FORWARD_WB;
    

endmodule
