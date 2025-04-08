module binary_sm (w, clk, reset, z, state);
    input w, clk, reset;
    output reg [2:0] state;
    output reg z;

    initial begin
        state = 0;
        z = 0;
    end

    wire y1, y2, y3;
    wire Y1, Y2, Y3;

    assign Y3 = (w & y3) | (w & y2 & y1);
    assign Y2 = (y1 ^ y2) | (w & ~y3 & ~y2);
    assign Y1 = (~w & ~y1 & ~y2) | (~w & y1 & y2) | (w & ~y3 & ~y2) | (w & y2 & ~y1);

    dff dff1 (
        .Default(1'b0),
        .D(Y1),
        .clk(clk),
        .reset(reset),
        .Q(y1)
    );

    dff dff2 (
        .Default(1'b0),
        .D(Y2),
        .clk(clk),
        .reset(reset),
        .Q(y2)
    );

    dff dff3 (
        .Default(1'b0),
        .D(Y3),
        .clk(clk),
        .reset(reset),
        .Q(y3)
    );

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 0;
        end 

        z <= y3 | (~y1 & y2);
    end

    always @(y1, y2, y3) begin
        state <= {y3, y2, y1};
    end
    
endmodule