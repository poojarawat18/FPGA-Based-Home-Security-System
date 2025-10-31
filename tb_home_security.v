
// tb_home_security.v
`timescale 1ns/1ps
module tb_home_security;
    reg clk = 0, reset = 0;
    reg arm = 0, disarm = 0, sensor = 0;
    wire alarm;

    // DUT
    home_security dut(clk, reset, arm, disarm, sensor, alarm);

    // Clock: 10ns period = 100MHz
    always #5 clk = ~clk;

    initial begin
        $dumpfile("home_security.vcd");
        $dumpvars(0, tb_home_security);

        // Reset
        reset = 1; #20; reset = 0;

        // Arm system
        #20 arm = 1; #10 arm = 0;

        // Trigger sensor
        #50 sensor = 1; #10 sensor = 0;

        // Wait
        #50;

        // Disarm system
        #20 disarm = 1; #10 disarm = 0;

        #50 $finish;
