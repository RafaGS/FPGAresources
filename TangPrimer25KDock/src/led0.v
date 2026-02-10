// Módulo simple para encender un LED en modo parpadeo
module led_controller_simple(
    input clk,
    output reg led_output
);
    
    reg [31:0] counter;
    
    always @(posedge clk) begin
        counter <= counter + 1;
        
        led_output <= counter[24];
    end
    
endmodule