module VGA_Top(
    input  logic CLK100MHZ, BTNC,
    output logic VGA_HS, VGA_VS, 
    output logic [3:0] VGA_R, VGA_G, VGA_B );
    
    logic clk25MHz, displayOn;
    logic [10:0] xPixel, yPixel;
    
    clkDiv C1(.clk(CLK100MHZ), .clr(BTNC), .clk25MHz(clk25MHz));
    
    VGA640x480 V1(.clk(clk25MHz), .clr(BTNC),       // Input
                  .hSync(VGA_HS), .vSync(VGA_VS),   // Output
                  .xPixel(xPixel), .yPixel(yPixel), // Output 
                  .displayOn(displayOn));           // Output
                  
    assign VGA_R = (displayOn) ? 4'b1111 : 4'b0000;
    assign VGA_G = 4'b0; 
    assign VGA_B = 4'b0;                
endmodule

// 时钟分频程序: 用计数器实现
module clkDiv(
    input  logic clk,
    input  logic clr,
    output logic clk25MHz );
    
    logic [1:0] q;  //reg
    // 2-bit counter
    always @(posedge clk, posedge clr)
        if(clr==1) q <= 0;
        else       q <= q + 1;

    assign clk25MHz = q[1]; // 100/4=25MHz
endmodule
