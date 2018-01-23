library IEEE;
use IEEE.std_logic_1164.ALL;

entity teste is
    Port(
			  clock: in std_logic;
           output1, output2: out std_logic
			);
end teste;

architecture behavior of teste is
begin
	process(clock)
	begin
		if( rising_edge(clock) ) then
			output1 <= clock;
			output2 <= not clock;
		end if;
	end process;	
end behavior;