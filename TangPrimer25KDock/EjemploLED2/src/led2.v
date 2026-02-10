module led_controller_simple(
    input clk,               // Reloj principal (50 MHz)
    output reg [7:0] led_output  // Salida a los 8 LEDs del PMOD0
);

    reg [31:0] counter;
    reg dir;
    parameter CLK_DIV = 25_000_000; // 50 MHz / 2 = 1 Hz (aproximado)

    // Inicialización del patrón de LEDs
    initial begin
        led_output = 8'b1111_1110;  // Solo el primer LED encendido
        dir = 0;
    end

    // Lógica para generar un desplazamiento cada ~1 segundo
    always @(posedge clk) begin
        if (counter == CLK_DIV - 1) begin
            counter <= 0;  // Reiniciar el contador
            if (dir == 0) begin
                led_output <= {led_output[6:0], led_output[7]};
            end else begin
                led_output <= {led_output[0], led_output[7:1]};
            end
        end else begin
            counter <= counter + 1;
        end
        if (led_output[0] == 0) begin
            dir = 0;
        end
        if (led_output[7] == 0) begin
            dir = 1;
        end
    end

endmodule