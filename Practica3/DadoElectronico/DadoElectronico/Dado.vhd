----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:23:25 03/21/2019 
-- Design Name: 
-- Module Name:    Dado - arq 
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

entity Dado is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           btn : in  STD_LOGIC;
           display : out  STD_LOGIC_VECTOR (6 downto 0);
			  control: out		STD_LOGIC_VECTOR(3 downto 0);
			  par: in	STD_LOGIC);
end Dado;

architecture arq of Dado is
	type estados is (E1,E2,E3,E4,E5,E6,E7,E8,E9);
	signal presente, futuro: estados;
	signal d: integer range 0 to 6:=0;
begin

-------------------- ASIGNACION DE ESTADOS----------------------------------
	process (clk,rst,btn) begin
		if rst = '1' then
			presente <= E1;
		elsif clk='1' and clk'event and btn = '1' then
			presente <= futuro;
		end if;
	end process;

---------------------
	process(presente,par) begin
			case presente is
					when E1 => d <= 1 ; futuro <= E2;
					when E2 => d <= 1 ; futuro <= E3;
					when E3 => d <= 2 ; futuro <= E4;
					when E4 => d <= 3 ; futuro <= E5;
					when E5 => d <= 3 ; futuro <= E6;
					when E6 => d <= 4 ; futuro <= E7;
					when E7 => d <= 5 ; futuro <= E8;
					when E8 => d <= 5 ; futuro <= E9;
					when E9 => d <= 6 ; futuro <= E1;
					when others => d <= 0;
			end case;
	end process;

	control <= "1110";
	display <= "0000001" WHEN d = 0 ELSE 
			  "1001111" WHEN d = 1 ELSE 
			  "0010010" WHEN d = 2 ELSE 
			  "0000110" WHEN d = 3 ELSE 
			  "1001100" WHEN d = 4 ELSE 
			  "0100100" WHEN d = 5 ELSE 
			  "1100000"; 
end arq;

