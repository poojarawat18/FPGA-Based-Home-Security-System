
// design_home_security.v
module home_security(
    input  wire clk,
    input  wire reset,    // active high reset
    input  wire arm,      // button to arm
    input  wire disarm,   // button to disarm
    input  wire sensor,   // sensor input (1 = trigger)
    output reg  alarm     // alarm output
);

    // States
    parameter DISARMED = 2'b00,
              ARMED    = 2'b01,
              ALARM    = 2'b10;

    reg [1:0] state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= DISARMED;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case(state)
            DISARMED: if (arm) next_state = ARMED;
            ARMED:    if (sensor) next_state = ALARM;
                      else if (disarm) next_state = DISARMED;
            ALARM:    if (disarm) next_state = DISARMED;
            default:  next_state = DISARMED;
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            DISARMED: alarm = 0;
            ARMED:    alarm = 0;
            ALARM:    alarm = 1;
            default:  alarm = 0;
        endcase
    end
