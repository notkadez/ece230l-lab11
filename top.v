module top(
    input sw, // w
    output [9:0] led, // see IO table
    input btnC, // clk
    input btnU // reset
);

    // Hook up binary and one-hot state machines
    binary_sm binary(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[1]),
        .state(led[9:7])
    );
    
    onehot oh(
        .w(sw),
        .clk(btnC),
        .reset(btnU),
        .z(led[0]),
        .state({led[2], led[3], led[4], led[5], led[6]})
    );

endmodule