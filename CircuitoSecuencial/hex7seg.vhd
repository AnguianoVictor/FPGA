----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:48 02/14/2019 
-- Design Name: 
-- Module Name:    hex7seg - arch 
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

entity hex7seg is
    Port ( digito : in  STD_LOGIC_VECTOR (3 downto 0);
           a_g : out  STD_LOGIC_VECTOR (6 downto 0));
			  --control: out STD_LOGIC_VECTOR (3 downto 0));
end hex7seg;

architecture arch of hex7seg is

begin
	process(digito)
	begin
		a_g(0) <=	(not(digito(0)) and not(digito(1)) and not(digito(2)) and digito(3)) or (digito(1) and not(digito(3)));
		a_g(1) <=	(not(digito(0)) and digito(1) and (not(digito(2))) and digito(3)) or (not(digito(0)) and digito(1) and digito(2) and(not(digito(3))));
		a_g(2) <=	(not(digito(1)) and digito(2) and not(digito(3)));
		a_g(3) <=	(not(digito(1)) and not(digito(2)) and digito(3)) or (digito(1) and not(digito(2)) and not(digito(3))) or (digito(1) and digito(2) and digito(3));
		a_g(4) <=	(digito(3))or(digito(1) and not(digito(2)));
		a_g(5) <=	(not(digito(1)) and digito(2)) or (digito(2) and digito(3)) or (not(digito(0)) and not(digito(1)) and digito(3));
		a_g(6) <=	(not(digito(0)) and not(digito(1)) and not(digito(2))) or (digito(1) and digito(2) and digito(3));
	end process;


end arch;

