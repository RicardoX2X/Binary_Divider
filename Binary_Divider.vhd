library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Binary_Divider is
    GENERIC(n: INTEGER := 3);
    Port (
        SW: in std_logic_vector(9 downto 0);
        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX2 : out std_logic_vector(6 downto 0);
        HEX3 : out std_logic_vector(6 downto 0);
		  HEX4 : out std_logic_vector(6 downto 0);
		  HEX5 : out std_logic_vector(6 downto 0);
		  KEY: in std_logic_vector(1 downto 0);
        Erro : BUFFER std_logic
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
    process(SW, KEY)

    VARIABLE temp1: std_logic_vector(7 downto 0);
    VARIABLE temp2: std_logic_vector(7 downto 0);
	 VARIABLE state: std_logic;

    
    begin
	 
	     IF KEY(1) = '0' THEN
		  state := '1';
		  END IF;
		  
		  IF KEY(0) = '0' THEN
		  state := '0';
		  END IF;
		  
		  temp1 := "0000" & SW(9 DOWNTO 6);
		  temp2 := "0000" & SW(3 DOWNTO 0);
		  IF state = '1' THEN
			HEX0 <= BinTo7Seg(temp2(3 downto 0));                  -- Dígito das unidades do quociente
			HEX1 <= BinTo7SegDec(temp2(3 downto 0));
			HEX2 <= "1111111";  -- Display apagado (ou pode ser adaptado para outro dígito)
			HEX3 <= "1111111";
			-- Exibir resto nos displays HEX2 e HEX3
			HEX4 <= BinTo7Seg(temp1(3 downto 0));      -- Dígito das unidades do resto
			HEX5 <= BinTo7SegDec(temp1(3 downto 0)); 
		  
		  ELSE
			  if temp2 = "00000000" then
					Quociente <= "0000";
					Resto <= "0000";
					Erro <= '1';  -- Divisão por zero
			  else
					FOR i IN N downto 0 LOOP
						 IF (unsigned(temp1) >= (unsigned(temp2) sll i)) THEN
							 Quociente(i) <= '1';
							 temp1 := std_logic_vector(unsigned(temp1) - (unsigned(temp2) sll i));
						 ELSE
							  Quociente(i) <= '0';
						 END IF;
					END LOOP;
					Resto <= temp1(3 downto 0);
					Erro <= '0';  -- Divisão válida
			  end if;
			  IF Erro = '1' THEN
				HEX0 <= "1000000";                -- Dígito das unidades do quociente
				HEX1 <= "0101111";            -- Display apagado (ou pode ser adaptado para outro dígito)

				-- Exibir resto nos displays HEX2 e HEX3
				HEX2 <= "0101111";      -- Dígito das unidades do resto
				HEX3 <= "0000110";
				HEX4 <= "1111111";
				HEX5 <= "1111111";
			  ELSE
				-- Exibir quociente nos displays HEX0 e HEX1
				HEX0 <= BinTo7Seg(Resto);                  -- Dígito das unidades do quociente
				HEX1 <= BinTo7SegDec(Resto);
				HEX2 <= "0101111";  -- Display apagado (ou pode ser adaptado para outro dígito)
				HEX3 <= "1111111";
				-- Exibir resto nos displays HEX2 e HEX3
				HEX4 <= BinTo7Seg(Quociente);      -- Dígito das unidades do resto
				HEX5 <= BinTo7SegDec(Quociente);                         -- Display apagado (ou pode ser adaptado para outro dígito)
			  END IF;   
			END IF;
    end process;
end Behavioral;
