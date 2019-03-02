----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:43 02/28/2019 
-- Design Name: 
-- Module Name:    mux4x1 - arch 
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

entity mux4x1 is
    Port ( x : in  STD_LOGIC_VECTOR (15 downto 0);
           s : in  STD_LOGIC_VECTOR (1 downto 0);
           digito : out  STD_LOGIC_VECTOR (3 downto 0));
end mux4x1;

architecture arch of mux4x1 is

begin
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
end arch;

