module IDEX(
    //input jump,
    //input [3:0]branch,
    //input unsign,
    //input mem_read,
    //input ALU_WB,
    //input WE,
    //input mem_write,
    input [4:0]rs1,
    input [4:0]rs2,
    input [31:0]PC_IN,
   // input immediate_select,
    input [31:0]immediate,
    input [4:0]ALU_control,
    input [4:0]rd,
    input [31:0]rs1_val,
    input [31:0]rs2_val,
    input [10:0]datapath,
    input clk,
    input clr,
    input stall,
    //output reg jump_out,
    //output reg [3:0]branch_out,
    //output reg unsign_out,
    //output reg mem_read_out,
    //output reg ALU_WB_out,
    //output reg WE_out,
    //output reg mem_write_out,
    output reg [4:0]rs1_out,
    output reg [4:0]rs2_out,
    output reg [31:0]PC_IN_out,
   // output reg immediate_select_out,
    output reg [31:0]immediate_out,
    output reg [4:0]ALU_out,
    output reg [4:0]rd_out,
    output reg [31:0]rs1_val_out,
    output reg [31:0]rs2_val_out,
    output reg [10:0]datapath_out,
    output reg bubble
);

always@(posedge clk) begin
    if(stall) begin
        rs1_out <= rs1_out;
        rs2_out <= rs2_out;
        PC_IN_out <= PC_IN_out;
        //immediate_select_out <= immediate_select_out;
        immediate_out <= immediate_out;
        ALU_out <= ALU_out;
        rd_out <= rd_out;
        rs1_val_out <= rs1_val_out;
        rs2_val_out <= rs2_val_out;
        datapath_out <= datapath_out;
        bubble <= 1'b1;
    end // do nothing 
    else if(clr) begin 
        /*
        jump_out <= 1'b0;
        branch_out <= 4'b0;
        unsign_out <= 1'b0;
        mem_read_out <= 1'b0;
        ALU_WB_out <= 1'b0;
        WE_out <= 1'b0;
        mem_write_out <= 1'b0;
        */
        rs1_out <= 5'b0;
        rs2_out <= 5'b0;
        PC_IN_out <= 32'b0;
        //immediate_select_out <= 1'b0;
        immediate_out <= 32'b0;
        ALU_out <= 5'b0;
        rd_out <= 5'b0;
        rs1_val_out <= 32'b0;
        rs2_val_out <= 32'b0;
        datapath_out <= 11'b0;
        bubble <= 1'b0;
    end
    else begin 
        /*
        jump_out <= jump;
        branch_out <= branch;
        unsign_out <= unsign;
        mem_read_out <= mem_read;
        ALU_WB_out <= ALU_WB;
        WE_out <= WE;
        mem_write_out <= mem_write;
        */
        rs1_out <= rs1;
        rs2_out <= rs2;
        PC_IN_out <= PC_IN;
        //immediate_select_out <= immediate_select;
        immediate_out <= immediate;
        ALU_out <= ALU_control;
        rd_out <= rd;
        rs1_val_out <= rs1_val;
        rs2_val_out <= rs2_val;
        datapath_out <= datapath;
        bubble <= 1'b0;
    end
end

endmodule

        
