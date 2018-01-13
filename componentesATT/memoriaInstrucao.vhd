library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity memoriaInstrucao is
	port (
			clock   : in  std_logic;
			endereco: in  std_logic_vector(7 downto 0);
			output  : out std_logic_vector(7 downto 0)
			);
end memoriaInstrucao;

architecture behavior of memoriaInstrucao is
	type ROM_TYPE is array (0 to 255) of std_logic_vector(7 downto 0);
	constant memoria : ROM_TYPE := (
	
		0 => "00000000",  -- INICIALIZAR SISTEMA
		
		-- ========== N-ÉSIMO TERMO DE UMA P.A. ============
		 1 => "10010011",  2 => "00010011",  3 => "00010011",  
		 4 => "00010001",  5 => "10010111",  6 => "00010110",  
		 7 => "10011011",  8 => "00000010",  9 => "00110101", 
	   10 => "01110100", 11 => "11010111",
		
		-- ================== FATORIAL =====================
		-- 1 => "10010011",  2 => "00010010",  3 => "10000100",
		-- 4 => "00110101",  5 => "01110000",	 6 => "11101011",
		-- 7 => "01000001",	 8 => "00110101",	 9 => "01110100",
		--10 => "11010110",	11 => "11101100",	12 => "10010001",
		
		-- ================ SOMA FLUTUANTE =================
		--12 => "10010011",	13 => "01010010", 14 => "01010011",
		--15 => "10010110",	16 => "00010111",	17 => "01010110",
		--18 => "01010001",	19 => "10011011",	20 => "00011011",
		--21 => "01011010",	22 => "10000110",	23 => "00000110",
		--24 => "11000001",
		
 OTHERS => "00000000" 
			);
begin
	process(clock, endereco)
	begin
		if( rising_edge(clock) ) then
			output <= memoria(conv_integer(endereco));
		end if;
	end process;
end behavior;
		