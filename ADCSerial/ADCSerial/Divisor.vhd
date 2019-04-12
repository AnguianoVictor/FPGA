library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Divisor is
    Port(   mclk: in STD_LOGIC;
            clk : out STD_LOGIC;
            cs  : out STD_LOGIC;
            clkDisplay: out STD_LOGIC
    );
end Divisor;

architecture arch of Divisor is
    signal divclk: STD_LOGIC_VECTOR(16 downto 0);
    begin
    process(mclk) 
	 begin
        if rising_edge(mclk) then
            divclk <= divclk + 1;  
        end if;
    end process;

    clk <= divclk(11);
    clkDisplay <= divclk(15);
    cs  <= divclk(16);

end arch;