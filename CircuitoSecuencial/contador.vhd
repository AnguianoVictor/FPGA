----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:50:05 02/28/2019 
-- Design Name: 
-- Module Name:    contador - arch 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
    Port ( clr : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (1 downto 0));
end contador;

architecture arch of contador is
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
end arch;

