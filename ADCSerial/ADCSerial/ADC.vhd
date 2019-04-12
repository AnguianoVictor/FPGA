----------------------------------------------------------------------------------
-- Company: 		UPIITA-IPN
-- Engineer: 		Victor Manuel Ramírez Anguiano
-- 
-- Create Date:    11:50:51 03/28/2019 
-- Design Name: 	Lectura analogica mediante protocolo SPI
-- Module Name:    ADC - arch 
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

entity ADC is
	Port(mclk: in STD_LOGIC;
			rx: in STD_LOGIC;
			data: inout STD_LOGIC_VECTOR(7 downto 0);
			clk: inout STD_LOGIC;
			cs: inout	STD_LOGIC;
			anodo: out STD_LOGIC_VECTOR(3 downto 0);
			display: out STD_LOGIC_VECTOR(6 downto 0));
end ADC;

architecture arch of ADC is

	signal clkDisplay:	STD_LOGIC;

	component Contador is
		Port(   	clkDisplay: in STD_LOGIC;
					data: in STD_LOGIC_VECTOR(7 downto 0);
					anodo: out STD_LOGIC_VECTOR(3 downto 0);
					display: out STD_LOGIC_VECTOR(6 downto 0));
	end component;
	
	component Divisor is
		Port(   	mclk: in STD_LOGIC;
					clk : out STD_LOGIC;
					cs  : out STD_LOGIC;
					clkDisplay: out STD_LOGIC);
	end component;
	
	component Lectura is
		Port(   	clk: in STD_LOGIC;
					cs: in	STD_LOGIC;
					rx: in STD_LOGIC;
					data: out STD_LOGIC_VECTOR(7 downto 0));
	end component;

	begin
	U1: Contador		PORT MAP(clkDisplay,data,anodo,display);
	U2: Divisor			PORT MAP(mclk,clk,cs,clkDisplay);
	U3: Lectura			PORT MAP(clk,cs,rx,data);
end arch;