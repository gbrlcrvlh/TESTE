library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somaFlutuante is
    port(
			A : in std_logic_vector (7 downto 0); --entrada
			B : in std_logic_vector (7 downto 0); --entrada
			S : out std_logic_vector (7 downto 0) --saida
		 );
end somaFlutuante;

architecture behavior of somaFlutuante is
signal exp1, exp2: std_logic_vector(2 downto 0); --sinais para os expoentes
signal sig1, sig2, sigR,sigAux : std_logic_vector(4 downto 0); --sinais para os significados
signal Cout, Cin: std_logic;
begin

	process (A, B, exp1, exp2, sig1, sig2) -- processo para soma
		variable C: std_logic_vector(5 downto 0);
		variable j : integer;
		variable expR : std_logic_vector (2 downto 0);
		begin
			
			if A (7 downto 5) > B (7 downto 5) then 
				exp1 <= A (7 downto 5);
				expR := B (7 downto 5);
				sig1 <= A (4 downto 0);
				sigAux <= B (4 downto 0);
				sigAux(0) <= sigAux(1);
				sigAux(1) <= sigAux(2);
				sigAux(2) <= sigAux(3);
				sigAux(3) <= sigAux(4);
				sigAux(4) <= '0';
				sig2 <= sigAux + "10000"; -- 1 implicito
			elsif A (7 downto 5) < B (7 downto 5) then
				exp1 <= B (7 downto 5);
				expR := A (7 downto 5);
				sig1 <= B (4 downto 0);
				sigAux <= A (4 downto 0);
				sigAux(0) <= sigAux(1);
				sigAux(1) <= sigAux(2);
				sigAux(2) <= sigAux(3);
				sigAux(3) <= sigAux(4);
				sigAux(4) <= '0';
				sig2 <= sigAux + "10000"; -- 1 implicito
			else 
				exp1 <= A (7 downto 5);
				expR := B (7 downto 5);
				sig1 <= A (4 downto 0);
				sig2 <= B (4 downto 0);
			end if;
			
			j:=0; -- iniciando a variavel j
			
			while j /= 8 loop --desloca o significado
				if exp1 = expR then
					exit;
				end if;
				sig2(0) <= sig2(1);
				sig2(1) <= sig2(2);
				sig2(2) <= sig2(3);
				sig2(3) <= sig2(4);
				sig2(4) <= '0';
				expR := expR+"001"; --incrementa expoente
				j:= j+1;
			end loop;
			
			--soma dos significando
			C(0) := Cin;
			for i in 0 to 4 loop
					sigR(i)<=sig1(i) xor sig2(i) xor C(i);
					C(i+1) := (sig1(i) and sig2(i)) or (sig1(i) and C(i)) or (sig2(i) and C(i));
			end loop;
			
			expR := expR+"001"; -- incrementa expoente devido a parte implicita
			
			Cout <= C(4);
			exp2 <= expR;
			
			j:=0;
			--montagem da saida
			if Cout = '0' then
				S(7 downto 5) <= exp2;
				S(3 downto 0) <= sigR(4 downto 1);
				S(4)<='0';
				
			else -- adiciona o Cout a saida
				S(7 downto 5) <= exp2;
				S(3) <= Cout;
				S(2 downto 0) <= sigR(2 downto 0);
				S(4)<='0';
				
			end if;
	end process;
end behavior;