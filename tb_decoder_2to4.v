module tb_decoder_2to4;
    // 1. Inputs defined as reg (registers) to drive values
    reg [1:0] a;
    reg en;

    // 2. Outputs defined as wire to observe values
    wire [3:0] y;

    // 3. Instantiate the Unit Under Test (UUT)
    decoder_2to4 uut (
        .a(a), 
        .en(en), 
        .y(y)
    );

    // 4. Stimulus block with Dump commands
    initial begin
        // --- GTKWave Setup Commands ---
        $dumpfile("decoder_results.vcd"); // This creates the file for GTKWave
        $dumpvars(0, tb_decoder_2to4);    // This records all signals in this module

        // --- Test Cases ---
        
        // Monitor will print the results to your terminal
        $monitor("Time=%0t | Enable=%b | Input=%b | Output=%b", $time, en, a, y);

        // Case 1: Decoder is Disabled (en=0)
        en = 0; a = 2'b00; #10;
        en = 0; a = 2'b11; #10;
        
        // Case 2: Decoder is Enabled (en=1) - Testing all 4 combinations
        en = 1;
        a = 2'b00; #10; // Expected Output: 0001 (Y0 is active)
        a = 2'b01; #10; // Expected Output: 0010 (Y1 is active)
        a = 2'b10; #10; // Expected Output: 0100 (Y2 is active)
        a = 2'b11; #10; // Expected Output: 1000 (Y3 is active)

        // Case 3: Disable again to check transitions
        en = 0; #10;

        $display("Simulation Finished");
        $finish; // Stops the simulation
    end
endmodule