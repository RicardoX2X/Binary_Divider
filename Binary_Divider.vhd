library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity Binary_Divider is
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
end Binary_Divider;

architecture Behavioral of Binary_Divider is

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
                when "1010" => return "1000000"; -- 0
                when "1011" => return "1111001"; -- 1
                when "1100" => return "0100100"; -- 2
                when "1101" => return "0110000"; -- 3
                when "1110" => return "0011001"; -- 4
                when others => return "0010010"; -- 5
            end case;
        end function;

   function BinTo7SegDec(val: std_logic_vector(3 downto 0)) return std_logic_vector is
        begin
            case val is
                when "0000" => return "1000000"; -- 0
                when "0001" => return "1000000"; -- 1
                when "0010" => return "1000000"; -- 2
                when "0011" => return "1000000"; -- 3
                when "0100" => return "1000000"; -- 4
                when "0101" => return "1000000"; -- 5
                when "0110" => return "1000000"; -- 6
                when "0111" => return "1000000"; -- 7
                when "1000" => return "1000000"; -- 8
                when "1001" => return "1000000"; -- 9
                when "1010" => return "1111001"; -- 0
                when "1011" => return "1111001"; -- 1
                when "1100" => return "1111001"; -- 2
                when "1101" => return "1111001"; -- 3
                when "1110" => return "1111001"; -- 4
                when others => return "1111001"; -- 5
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
   
    if(Erro == '1')
       HEX0 <= "0000001";                -- Dígito das unidades do quociente
       HEX1 <= "1001111"            -- Display apagado (ou pode ser adaptado para outro dígito)

       -- Exibir resto nos displays HEX2 e HEX3
       HEX2 <= "1001111"      -- Dígito das unidades do resto
       HEX3 <= "0110000";
    ELSE
       -- Exibir quociente nos displays HEX0 e HEX1
       HEX0 <= BinTo7Seg(Quociente(3 downto 0));                  -- Dígito das unidades do quociente
       HEX1 <= BinTo7SegDec(Quociente(3 downto 0));             -- Display apagado (ou pode ser adaptado para outro dígito)

       -- Exibir resto nos displays HEX2 e HEX3
       HEX2 <= BinTo7Seg(Resto(3 downto 0));      -- Dígito das unidades do resto
       HEX3 <= BinTo7SegDec(Resto(3 downto 0));                         -- Display apagado (ou pode ser adaptado para outro dígito)
    END IF    
end Behavioral;
