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



entity semaforo is
    Port ( clk : in  STD_LOGIC_VECTOR(24 downto 0);
           rst : in  STD_LOGIC;
           sensor : in  STD_LOGIC;
           semaforoR : out  STD_LOGIC_VECTOR (2 downto 0);
           semaforoC : out  STD_LOGIC_VECTOR (2 downto 0);
           uni : out integer range 0 to 9:=0;
           dec : out integer range 0 to 9:=0);
			  --x: out STD_LOGIC_VECTOR (7 downto 0));
end semaforo;

architecture arq of semaforo is

--Señales Semaforo
	type estados is (A,B,C,D,E);
	signal presente,futuro: estados;
	constant verde: STD_LOGIC_VECTOR(2 downto 0):="001";
	constant rojo: STD_LOGIC_VECTOR(2 downto 0):="100";
	constant ambar: STD_LOGIC_VECTOR(2 downto 0):="010";
	signal clkSemaforo: STD_LOGIC_VECTOR(1 downto 0);
	signal clkEstados:	STD_LOGIC_VECTOR(1 downto 0);
	signal cuenta:	integer; --*
	signal cuenta30,cuenta10,cuenta5,iniciaConteo: boolean;
	signal uni_temp: integer range 0 to 9:=0;
	signal dec_temp: integer range 0 to 9:=0;
begin
	
	----------------------------Semaforo------------------------------
	semaforo:process(clk(1),sensor,presente,cuenta5,cuenta10,cuenta30,rst)
	begin
		if rst = '1' then
			futuro <= A; iniciaConteo <= true;
		elsif rising_edge(clk(1)) then
			case presente is
				when A => semaforoC <= verde; semaforoR <= rojo; iniciaConteo <= true;
							if sensor = '0' then
								futuro <= B; iniciaConteo<= false;
							else
								futuro <= A;
							end if;
				when B => semaforoC <= ambar; semaforoR <= rojo; --iniciaConteo <= false;
							if cuenta5 then 
								futuro <= C; iniciaConteo <= true; 
							else 
								futuro <= B; 
							end if;
				when C => semaforoC <= rojo; semaforoR <= verde; iniciaConteo<=false;
							if cuenta10 then
								futuro <= D; iniciaConteo <= true;
							else
								futuro <= C; 
							end if;
				when D => semaforoC <= rojo; semaforoR <= ambar; iniciaConteo<=false;
							if cuenta5 then
								futuro <= E; iniciaConteo <= true;
							else
								futuro <= D; 
							end if;
				when E => semaforoC <= verde; semaforoR <= rojo; iniciaConteo<=false;
							if cuenta30 then
								futuro <= A; iniciaConteo <= true;
							else 
								futuro <= E;
							end if;
					when others => futuro <= A;
				end case;
			end if;
	end process semaforo;
	

	clkSemaforo <= clk(24 downto 23);
	clkEstados 	<=	clk(5	downto 4);
	
	clockSem: process(clkSemaforo(1),rst)
	begin
		if rising_edge(clkSemaforo(1)) then
			presente <= futuro;
			if iniciaConteo or rst = '1' then
				cuenta <= 0;
				uni_temp <= 0;
				dec_temp <= 0;
			else 
				cuenta <= cuenta + 1;
				uni_temp <= uni_temp + 1;
				if uni_temp = 9 then
					uni_temp <= 0;
					dec_temp <= dec_temp + 1;
					if dec_temp = 9 then
						dec_temp <= 0;
					end if;
				end if;
			end if;
		end if;
	end process clockSem;
	
	uni <= uni_temp;
	dec <= dec_temp;
	cuenta30 <= true when cuenta=29 	else false;
	cuenta10 <= true when cuenta=9	else false;
	cuenta5 	<=	true when cuenta=4	else false;

end arq;