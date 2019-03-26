----------------------------------------------------------------------------------
-- Company: 		UPIITA-IPN
-- Engineer: 		Victor Manuel Ramirez Anguiano
-- 
-- Create Date:    21:06:56 03/17/2019 
-- Design Name:    
-- Module Name:    Clock
-- Project Name: 	Control Semaforo
-- Target Devices: 	Nexys2 500k

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity clock is
    Port ( mclk : in   STD_LOGIC;
            clk : out  STD_LOGIC_VECTOR(24 downto 0));
end clock;

architecture arq of clock is
signal clk_temp: STD_LOGIC_VECTOR(24 downto 0);
begin
	clock:process(mclk)
	begin
		if rising_edge(mclk) then
			clk_temp <= clk_temp + 1;
		end if;
	end process clock;
	
	clk <= clk_temp;
end arq;