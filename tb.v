`timescale 1ns/1ns
`define period 78.125

module testbench;
    // input
    reg clk,rst_n,in;
    // output
    wire [18:0]out;

    always #`period clk <= ~clk;

    initial begin
        rst_n <= 1'b0;
        clk <= 1'b0;
        #500;
        rst_n <= 1'b1;
    end

    integer i;
    reg mem[0:3000000];
    
    initial $readmemb("1k1000mv.txt",mem);

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n == 1) begin
            i = 0;
            in <= 0;
        end
        else begin
            in <= mem[i];
            i = i + 1;
        end
    end

    cic_filter cic(
        .clk(clk),
        .rst_n(rst_n),
        .in(in),
        .out(out)
    );

endmodule
