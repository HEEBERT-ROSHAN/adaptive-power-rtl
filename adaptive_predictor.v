module adaptive_predictor(
    input clk,
    input rst,
    input [7:0] d,
    output reg [7:0] q,
    output reg clk_en,
    output reg [1:0] counter
);

always @(posedge clk) begin
    if (rst) begin
        q       <= 8'd0;
        clk_en  <= 1'b1;
        counter <= 2'd0;
    end
    else begin

        // Activity detection
        if (d != q) begin
            if (counter < 3)
                counter <= counter + 1;
        end
        else begin
            if (counter > 0)
                counter <= counter - 1;
        end

        // Prediction logic
        if (counter >= 2)
            clk_en <= 1'b1;
        else
            clk_en <= 1'b0;

        // Adaptive register update
        if (clk_en)
            q <= d;

    end
end

endmodule