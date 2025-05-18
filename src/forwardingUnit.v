module forwardingUnit(
    input [4:0] rs1,
    input [4:0] rdmem,
    input [4:0] rdwb,
    input [4:0] rs2,
    input regWrite_Wb,
    input regWrite_Mem,
    output reg [1:0] A,
    output reg [1:0] B
);

always @(*) begin
    if ((rdmem == rs1) & (regWrite_Mem != 0 & rdmem !=0))
          begin
          	A = 2'b10;
          end
      	else
          begin 
            if ((rdwb == rs1) & (regWrite_Wb != 0 & rdwb != 0) & ~((rdmem == rs1) &(regWrite_Mem != 0 & rdmem !=0)  )  )
              begin
                A = 2'b01;
              end
            else
              begin
                A = 2'b00;
              end
          end
      
        if ( (rdmem == rs2) & (regWrite_Mem != 0 & rdmem !=0) )
          begin
            B = 2'b10;
          end
        else
          begin
            if ( (rdwb == rs2) & (regWrite_Wb != 0 & rdwb != 0) &  ~((regWrite_Mem != 0 & rdmem !=0 ) & (rdmem == rs2) ) )
              begin
                B = 2'b01;
              end
            else
              begin
                B = 2'b00;
              end
          end
end

endmodule
    
