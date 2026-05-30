`timescale 1ns / 1ps

module tb_adaptive_predictor;

reg clk;
reg rst;
reg [7:0] d;

wire [7:0] q;
wire clk_en;
wire [1:0] counter;

adaptive_predictor uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q),
    .clk_en(clk_en),
    .counter(counter)
);

// Clock generation
always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    d   = 8'h00;

    #20;
    rst = 0;

    // Active region
    d = 8'h0A; #20;
    d = 8'h14; #20;
    d = 8'h1E; #20;
    d = 8'h28; #80;

    // Idle region
    d = 8'h28; #120;

    // Activity again
    d = 8'h05; #100;

    // Multiple transitions
    d = 8'h08; #20;
    d = 8'h10; #20;
    d = 8'h18; #80;

    $finish;

end

endmodule