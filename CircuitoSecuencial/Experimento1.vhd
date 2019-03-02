----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:21:40 03/01/2019 
-- Design Name: 
-- Module Name:    Experimento1 - arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Experimento1 is
	Port( clr: in STD_LOGIC;
			mclk: in STD_LOGIC;
			s: inout STD_LOGIC_VECTOR(1 downto 0);
			digito : inout  STD_LOGIC_VECTOR (3 downto 0);
			anodo : out  STD_LOGIC_VECTOR (3 downto 0);
			a_g : out  STD_LOGIC_VECTOR (6 downto 0);
			x : in  STD_LOGIC_VECTOR (15 downto 0)
	);
end Experimento1;

architecture arch of Experimento1 is
	signal cont: 	STD_LOGIC_VECTOR(19 downto 0);
	signal selec:		STD_LOGIC_VECTOR(1 downto 0);
begin
	process(cont,mclk)
			begin
				if mclk = '1' and mclk'event then
					cont <= cont + 1;
				end if; 
	end process;
	
	selec <= cont(19 downto 18);

	process(selec, clr)
			begin
				if clr = '1' then 
					s <= "11";
				else
				case selec is
					when "00" => s <= "00"; 
					when "01" => s <= "01"; 
					when "10" => s <= "10"; 
					when "11" => s <= "11"; 
					when others => s <= "00";
				end case;
				end if;
	end process;
	
	process(digito)
	begin
		a_g(0) <=(not(digito(0)) and not(digito(1)) and not(digito(2)) and digito(3)) or (digito(1) and not(digito(3)));
		a_g(1) <=(not(digito(0)) and digito(1) and (not(digito(2))) and digito(3)) or (not(digito(0)) and digito(1) and digito(2) and(not(digito(3))));
		a_g(2) <=(not(digito(1)) and digito(2) and not(digito(3)));
		a_g(3) <=(not(digito(1)) and not(digito(2)) and digito(3)) or (digito(1) and not(digito(2)) and not(digito(3))) or (digito(1) and digito(2) and digito(3));
		a_g(4) <=(digito(3))or(digito(1) and not(digito(2)));
		a_g(5) <=(not(digito(1)) and digito(2)) or (digito(2) and digito(3)) or (not(digito(0)) and not(digito(1)) and digito(3));
		a_g(6) <=(not(digito(0)) and not(digito(1)) and not(digito(2))) or (digito(1) and digito(2) and digito(3));
	end process;
	
	process(x,s)
		begin
			case s is
				when "00" => digito <= "1001";
				when "01" => digito <= x(10 downto 8)&'0';
				when "10" => digito <= x(7 downto 4);
				when "11" => digito <= x(3 downto 0);
				when others => digito <= "0000";
			end case;
	end process;
	
	process(s)
		begin
		case s is
			when "00" => anodo <= "1110";
			when "01" => anodo <= "1101";
			when "10" => anodo <= "1011";
			when "11" => anodo <= "0111";
			when others => anodo <= "0000";
		end case;
	end process;
end arch;

