library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Lectura is
    Port(   clk: in STD_LOGIC;
            cs: in	STD_LOGIC;
			rx: in STD_LOGIC;
			data: out STD_LOGIC_VECTOR(7 downto 0));
end Lectura;

architecture arch of Lectura is
    signal cont: STD_LOGIC_VECTOR(3 downto 0);
    signal reg:	STD_LOGIC_VECTOR(0 to 10);
    begin
        process(cs,clk,cont)
	begin
		if cs = '0' then
			if clk'event and clk='1' then
				cont <= cont + 1;
				case(cont) is
					when "0000" => reg(0) <= rx;
					when "0001" => reg(1) <= rx;
					when "0010" => reg(2) <= rx;
					when "0011" => reg(3) <= rx;
					when "0100" => reg(4) <= rx;
					when "0101" => reg(5) <= rx;
					when "0110" => reg(6) <= rx;
					when "0111" => reg(7) <= rx;
					when "1000" => reg(8) <= rx;
					when "1001" => reg(9) <= rx;
					when "1010" => data <= reg(2 to 9);
					when others => reg(10) <=  rx;
				end case;
			end if;
		else
			cont <= (others => '0');
			reg <= (others => '0');
		end if;
    end process;
    
    
end arch;