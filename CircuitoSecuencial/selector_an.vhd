----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:49 02/28/2019 
-- Design Name: 
-- Module Name:    selector_an - arch 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity selector_an is
    Port ( s : in  STD_LOGIC_VECTOR (1 downto 0);
           anodo : out  STD_LOGIC_VECTOR (3 downto 0));
end selector_an;

architecture arch of selector_an is

begin
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

