LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY divider_vhd_tst IS
END divider_vhd_tst;

ARCHITECTURE divider_arch OF divider_vhd_tst IS
    -- Sinais de entrada
    SIGNAL SW1 : std_logic_vector(3 downto 0);
    SIGNAL SW2 : std_logic_vector(3 downto 0);
    
    -- Sinais de saída
    SIGNAL H0, H1, H2, H3 : std_logic_vector(6 downto 0);
    SIGNAL ERR : std_logic;
BEGIN
    -- Instancia o módulo Binary_Divider
    uut: entity work.Binary_Divider(Behavioral)
        PORT MAP (
            A => SW1,
            B => SW2,
            HEX0 => H0,
            HEX1 => H1,
            HEX2 => H2,
            HEX3 => H3,
            Erro => ERR
        );

    -- Processo de inicialização e estímulo dos sinais de entrada
    init : PROCESS
    BEGIN
        -- Primeira simulação
        SW1 <= "1011"; -- Dividendo = 11
        SW2 <= "0011"; -- Divisor = 3
        WAIT FOR 200 ns;

        -- Segunda simulação
        SW1 <= "1111"; -- Dividendo = 15
        SW2 <= "0010"; -- Divisor = 2
        WAIT FOR 200 ns;

        -- Terceira simulação
        SW1 <= "1101"; -- Dividendo = 13
        SW2 <= "0101"; -- Divisor = 5
        WAIT FOR 200 ns;

        -- Simulação de divisão por zero
        SW1 <= "1001"; -- Dividendo = 9
        SW2 <= "0000"; -- Divisor = 0
        WAIT FOR 200 ns;

        -- Finaliza a simulação
        WAIT;
    END PROCESS init;
END divider_arch;
