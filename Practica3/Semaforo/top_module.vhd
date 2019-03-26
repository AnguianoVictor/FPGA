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

entity top_module is
    Port ( mclk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           sensor : in  STD_LOGIC;
           semaforoR : out  STD_LOGIC_VECTOR (2 downto 0);
           semaforoC : out  STD_LOGIC_VECTOR (2 downto 0);
           display : out  STD_LOGIC_VECTOR (6 downto 0);
           anodo : out  STD_LOGIC_VECTOR (3 downto 0));
end top_module;

architecture arq of top_module is
	signal clk: STD_LOGIC_VECTOR(24 downto 0);
	--signal clk: STD_LOGIC_VECTOR(24 downto 0); --*
	signal dec:	integer range 0 to 9:=0;
	signal uni: integer range 0 to 9:=0;


	
	component clock is
		Port ( mclk : in    STD_LOGIC;
            clk : out   STD_LOGIC_VECTOR(24 downto 0));
	end component;
	
	component semaforo is
		Port ( clk : in  STD_LOGIC_VECTOR(24 downto 0);
           rst : in  STD_LOGIC;
           sensor : in  STD_LOGIC;
           semaforoR : out  STD_LOGIC_VECTOR (2 downto 0);
           semaforoC : out  STD_LOGIC_VECTOR (2 downto 0);
           uni : out integer range 0 to 9:=0;
           dec : out integer range 0 to 9:=0);
	end component;
	
	component contador is
		Port ( clk : in  STD_LOGIC_VECTOR(24 downto 0);
           uni : in integer range 0 to 9:=0;
           dec : in integer range 0 to 9:=0;
           display : out  STD_LOGIC_VECTOR (6 downto 0);
           anodo : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	begin
		U1: clock		PORT MAP(mclk,clk);
		U2: semaforo	PORT MAP(clk, rst,sensor,semaforoR,semaforoC,uni,dec);
		U3: contador	PORT MAP(clk,uni,dec,display,anodo);
	
end arq;

