----------------------------------------------------------------------------------
-- Company: 		UPIITA-IPN
-- Engineer: 		Victor Manuel Ramirez Anguiano
-- 
-- Create Date:    21:06:56 03/17/2019 
-- Design Name: 	
-- Module Name:    top_module - arq 
-- Project Name: 		
-- Target Devices: 	Nexys2 500k
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
    Port ( clk : in  STD_LOGIC_VECTOR(24 downto 0);
           uni : in  integer range 0 to 9:=0;
           dec : in  integer range 0 to 9:=0;
           display : out  STD_LOGIC_VECTOR (6 downto 0);
           anodo : out  STD_LOGIC_VECTOR (3 downto 0));
			  --x: out STD_LOGIC_VECTOR (7 downto 0));
end contador;

architecture arq of contador is

--Señales Contador
	signal clkDisplay:	STD_LOGIC;
	signal clkSegundo:	STD_LOGIC;
	signal digito: STD_LOGIC_VECTOR(3 downto 0);
	signal num_bin:		STD_LOGIC_VECTOR(8 downto 0);
	signal x:		STD_LOGIC_VECTOR(10 downto 0);
	signal contadorP: integer range 0 to 9:= 0;
	type maquina is (UNIDADES,DECENAS);
	signal EDO_P,EDO_F: maquina:=UNIDADES;
begin
	
	
	------------------------------Contador--------------------------------
	clkDisplay <= clk(18);
	
	process(clkDisplay)
	begin
		if rising_edge(clkDisplay) then
			EDO_P <= EDO_F;
		end if;
	end process;
	
	selector: process(EDO_P)
	begin
		case EDO_P is
			when UNIDADES =>
				EDO_F <= DECENAS;
				anodo <= "1101"; 
			when DECENAS =>
				EDO_F <= UNIDADES;  
				anodo <= "1110";
			when others => NULL;
		end case;
	end process selector;

	contadorp <= uni when EDO_P = UNIDADES else dec;
	
	display <= "0000001" WHEN contadorp = 0 ELSE 
			  "1001111" WHEN contadorp = 1 ELSE 
			  "0010010" WHEN contadorp = 2 ELSE 
			  "0000110" WHEN contadorp = 3 ELSE 
			  "1001100" WHEN contadorp = 4 ELSE 
			  "0100100" WHEN contadorp = 5 ELSE 
			  "1100000" WHEN contadorp = 6 ELSE 
			  "0001111" WHEN contadorp = 7 ELSE 
			  "0000000" WHEN contadorp = 8 ELSE 
			  "0001100"; 
end arq;