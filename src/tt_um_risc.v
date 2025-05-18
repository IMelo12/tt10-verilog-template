

module tt_um_risc(
    input  wire [7:0] ui_in,     // Dedicated inputs
    output wire [7:0] uo_out,    // Dedicated outputs (wire)
    input  wire [7:0] uio_in,    // IOs: Input path
    output wire [7:0] uio_out,   // IOs: Output path
    output wire [7:0] uio_oe,    // IOs: Enable path (1=output)
    input  wire       ena,       // Enable signal
    input  wire       clk,       // Clock
    input  wire       rst_n      // Active-low reset
);

assign uio_oe = 8'h00;            // Set uio as inputs (OE = 0)
assign uio_out = 0;

wire [7:0] risc_output;
wire       input_we = ui_in[0];
wire [6:0] input_address = ui_in[7:1];
wire [7:0] input_data = uio_in;
wire [7:0] debug_wire;

(* dont_touch = "true" *) risc cpu (
    .clk(clk),
    .rst_n(rst_n),
    .inst_address(input_address),
    .inst_data(input_data),
    .inst_we(input_we),
    .memory_out(risc_output),
    .debug(debug_wire)
);

// Masked output: conditionally override risc_output if ena & ui_in match


// Output logic ensuring risc_output is always referenced
assign uo_out = (debug_wire ^ risc_output) ? risc_output:debug_wire;

// (Optional) If you want to drive uio_out too, do something like this:
// assign uio_out = risc_output;  // only if uio_oe = 0xFF




endmodule
