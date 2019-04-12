library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Contador is
	Port(   	clkDisplay: in STD_LOGIC;
				data: in STD_LOGIC_VECTOR(7 downto 0);
				anodo: out STD_LOGIC_VECTOR(3 downto 0);
				display: out STD_LOGIC_VECTOR(6 downto 0));
end Contador;

architecture arch of Contador is
    type maquina is (UNIDADES,DECENAS,CENTENAS);
    signal EDO_P,EDO_F: maquina:=UNIDADES;
    signal contadorp: STD_LOGIC_VECTOR(3 downto 0);
    signal uni: STD_LOGIC_VECTOR(3 downto 0);
    signal dec: STD_LOGIC_VECTOR(3 downto 0);
    signal cen: STD_LOGIC_VECTOR(3 downto 0);
    signal p: STD_LOGIC_VECTOR (11 downto 0);
    
    begin
        bcd1: process(data)
				variable z: STD_LOGIC_VECTOR(19 downto 0);
				begin
					z := (others => '0');
					z(10 downto 3):= data;
					for i in 0 to 4 loop
						--UNIDADES
						if z(11 downto 8) > 4 then
							z(11 downto 8):= z(11 downto 8)+3;
						else 
							z(11 downto 8):= z(11 downto 8);
						end if;
						--DECENAS
						if z(15 downto 12) > 4 then
							z(15 downto 12):=z(15 downto 12)+3;
						else 
							z(15 downto 12):=z(15 downto 12);
						end if;
						--CENTENAS
						if z(19 downto 16) > 4 then
							z(19 downto 16):=z(19 downto 16)+3;
						else 
							z(19 downto 16):=z(19 downto 16);
						end if;
						z(19 downto 1):= z(18 downto 0);
					end loop;
					p <= z(19 downto 8);
					
			end process bcd1;
	
	    cen <= p(11 downto 8);
	    uni <= p(7 downto 4);
        dec <= p(3 downto 0);
	
	    process(clkDisplay,EDO_P)
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
				    anodo <= "1110";
			    when DECENAS =>
				    EDO_F <= CENTENAS;
				    anodo <= "1101";
			    when CENTENAS =>
				    EDO_F <= UNIDADES;
				    anodo <= "1011";
			    when others => NULL;
		    end case;
	    end process selector;

	    contadorp <= uni when EDO_P = UNIDADES else 
					dec when EDO_P = DECENAS	else
					cen;
	
	    display <=  "0000001" WHEN contadorp = "0000" ELSE 
			        "1001111" WHEN contadorp = "0001" ELSE 
			        "0010010" WHEN contadorp = "0010" ELSE 
			        "0000110" WHEN contadorp = "0011" ELSE 
			        "1001100" WHEN contadorp = "0100" ELSE 
			        "0100100" WHEN contadorp = "0101" ELSE 
			        "1100000" WHEN contadorp = "0110" ELSE 
			        "0001111" WHEN contadorp = "0111" ELSE 
			        "0000000" WHEN contadorp = "1000" ELSE 
			        "0001100"; 
    end arch;