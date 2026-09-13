module decoder_2to4 (
    input [1:0] a,    // 2-bit Input (A1, A0)
    input en,         // Enable signal (Active High)
    output reg [3:0] y // 4-bit Output (Y3, Y2, Y1, Y0)
);

always @(*) begin
    if (en) begin
        case (a)
            2'b00: y = 4'b0001; // Output line 0 is HIGH
            2'b01: y = 4'b0010; // Output line 1 is HIGH
            2'b10: y = 4'b0100; // Output line 2 is HIGH
            2'b11: y = 4'b1000; // Output line 3 is HIGH
            default: y = 4'b0000;
        endcase
    end
    else begin
        y = 4'b0000; // All outputs LOW if disabled
    end
end

endmodule