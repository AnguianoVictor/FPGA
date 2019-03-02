----------------------------------------------------------------------------------
-- Company: 		UPIITA-IPN
-- Engineer: 		Victor Manuel Ramirez Anguiano
-- 
-- Create Date:    12:26:35 02/28/2019 
-- Design Name: 	Contador de 0 a 9999 mediante control de 4 bits para cada digito
-- Module Name:   Modulo padre
-- Project Name: 
-- Target Devices: Nexys 2 DIGILENT
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

entity modulo_top is
    Port ( x : in  STD_LOGIC_VECTOR (15 downto 0);
           clr : in  STD_LOGIC;
           mclk : in  STD_LOGIC;
           a_g : out  STD_LOGIC_VECTOR (6 downto 0);
			  anodo : out  STD_LOGIC_VECTOR (3 downto 0));
end modulo_top;

architecture arch of modulo_top is
	signal digito: STD_LOGIC_VECTOR(3 downto 0);
	--signal x:		STD_LOGIC_VECTOR(15 downto 0);
	signal s:		STD_LOGIC_VECTOR(1 downto 0);
	
	component contador is
		Port ( 	clr : in  STD_LOGIC;
					mclk : in  STD_LOGIC;
					s : out  STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	component hex7seg is
		Port ( digito : in  STD_LOGIC_VECTOR (3 downto 0);
           a_g : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	component mux4x1 is
		Port ( x : in  STD_LOGIC_VECTOR (15 downto 0);
           s : in  STD_LOGIC_VECTOR (1 downto 0);
           digito : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component selector_an is
    Port ( s : in  STD_LOGIC_VECTOR (1 downto 0);
           anodo : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	
begin
	
	U1: contador 		PORT MAP(clr,mclk,s);
	U2: hex7seg	 		PORT MAP(digito,a_g);
	U3: mux4x1	 		PORT MAP(x,s,digito);
	U4: selector_an	PORT MAP(s,anodo);

end arch;

