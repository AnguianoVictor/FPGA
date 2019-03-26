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
			  --x: out STD_LOGIC_VECTOR (7 downto 0));
end top_module;

architecture arq of top_module is

--Señales Clock
	signal clk: STD_LOGIC_VECTOR(24 downto 0); --*
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
--Señales Contador
	signal clkDisplay:	STD_LOGIC;
	signal clkSegundo:	STD_LOGIC;
	signal digito: STD_LOGIC_VECTOR(3 downto 0);
	signal num_bin:		STD_LOGIC_VECTOR(8 downto 0);
	signal x:		STD_LOGIC_VECTOR(10 downto 0);
	signal dec:	integer range 0 to 9:=0;
	signal uni: integer range 0 to 9:=0;
	signal contadorP: integer range 0 to 9:= 0;
	type maquina is (UNIDADES,DECENAS);
	signal EDO_P,EDO_F: maquina:=UNIDADES;
begin
	
	clock:process(mclk,rst)
	begin
		if rising_edge(mclk) then
			clk <= clk + 1;
		end if;
	end process clock;
	
	
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
				uni <= 0;
				dec <= 0;
			else 
				cuenta <= cuenta + 1;
				uni <= uni + 1;
				if uni = 9 then
					uni <= 0;
					dec <= dec + 1;
					if dec = 9 then
						dec <= 0;
					end if;
				end if;
			end if;
		end if;
	end process clockSem;
	
	
	cuenta30 <= true when cuenta=29 	else false;
	cuenta10 <= true when cuenta=9	else false;
	cuenta5 	<=	true when cuenta=4	else false;
	
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
