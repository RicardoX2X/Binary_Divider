-- Baseado no código de FPGA Prototyping by VHDL Examples - Pong P. Chu
-- Adaptacao para a placa DE1 da Altera
library ieee;
use ieee.std_logic_1164.all;

entity Binary_Divider is
   port(
      SW: in std_logic_vector(3 downto 0);
      --dp: in std_logic;
      HEX0: out std_logic_vector(6 downto 0)
   );
end Binary_Divider;

architecture arch of Binary_Divider is
begin
   with SW select
      HEX0(6 downto 0) <=
         "1000000" when "0000",
         "1111001" when "0001",
         "0100100" when "0010",
         "0110000" when "0011",
         "0011001" when "0100",
         "0010010" when "0101",
         "0100000" when "0110",
         "0001111" when "0111",
         "0000000" when "1000",
         "0000100" when "1001", --e       -- ERRADO !!! CORRIGIR !!!
         "0111000" when others;
end arch;

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity Divisor4Bits is
    GENERIC(n: INTEGER := 3);
    Port (
        A: in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX2 : out std_logic_vector(6 downto 0);
        HEX3 : out std_logic_vector(6 downto 0);
        Erro : out std_logic
    );
end Divisor4Bits;

architecture Behavioral of Divisor4Bits is

    signal Quociente : std_logic_vector(3 downto 0);
    signal Resto : std_logic_vector(3 downto 0);

    -- Função para converter de binário para a codificação do display de 7 segmentos
    function BinTo7Seg(val: std_logic_vector(3 downto 0)) return std_logic_vector is
        begin
            case val is
                when "0000" => return "1000000"; -- 0
                when "0001" => return "1111001"; -- 1
                when "0010" => return "0100100"; -- 2
                when "0011" => return "0110000"; -- 3
                when "0100" => return "0011001"; -- 4
                when "0101" => return "0010010"; -- 5
                when "0110" => return "0000010"; -- 6
                when "0111" => return "1111000"; -- 7
                when "1000" => return "0000000"; -- 8
                when "1001" => return "0010000"; -- 9
                when others => return "1111111"; -- Error (não deve ocorrer para 4 bits)
            end case;
        end function;

begin
    process(A, B)

    VARIABLE temp1: std_logic_vector(3 downto 0);
    VARIABLE temp2: std_logic_vector(3 downto 0);

    
    begin
        temp1 := a;
        temp2 := b;
        if B = "0000" then
            Quociente <= "0000";
            Resto <= "0000";
            Erro <= '1';  -- Divisão por zero
        else
            IF (unsigned(temp1) >= (unsigned(temp2) sll i)) THEN
               Quociente <= '1';
               temp1 := std_logic_vector(unsigned(temp1) - (unsigned(temp2) sll i));
            ELSE
                Quociente <= '0';
            END IF;
            Resto <= temp1;
            Erro <= '0';  -- Divisão válida
        end if;
    end process;

    -- Exibir quociente nos displays HEX0 e HEX1
    HEX0 <= BinTo7Seg(Quociente(3 downto 0));  -- Dígito das unidades do quociente
    HEX1 <= "1111111";                         -- Display apagado (ou pode ser adaptado para outro dígito)

    -- Exibir resto nos displays HEX2 e HEX3
    HEX2 <= BinTo7Seg(Resto(3 downto 0));      -- Dígito das unidades do resto
    HEX3 <= "1111111";                         -- Display apagado (ou pode ser adaptado para outro dígito)
    
end Behavioral;
