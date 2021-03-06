library IEEE;
use IEEE.std_logic_1164.all;

entity TripleX is
	port(
			clock, reset: in std_logic;
			-- PORTAS PARA DEBUG --
			entrada_PC,
			saida_PC,
			saida_MemInstr,
			saida_BdRA,
			saida_BdRB,
			saida_ExtensorSinal2p8,
			saida_ExtensorSinal4p8,
			saida_RegA,
			saida_RegB,
			saida_MUXfonteA,
			saida_MUXfonteB,
			saida_ULA,
			saida_RegULAout : out std_Logic_vector(7 downto 0);
			habilitaPC,
			zeroULA : out std_logic;
			out_estado: out std_logic_vector(2 downto 0)
		  );
end TripleX;

architecture behavior of TripleX is
component blocoControle is
	port(
			clock,
			reset      : in std_logic;
			opcode     : in std_logic_vector(3 downto 0);
			PCescCond,
			PCesc,
			IouD,
			MemParaReg,
			regEscrita, 
			ULAfonteA,
			MemLeitura,
			MemEscrita : out std_logic;                     -- flags de 1 bit
			ULAfonteB,
			PCfonte    : out std_logic_vector(1 downto 0);  -- flags de 2 bits
			ULAop      : out std_logic_vector(3 downto 0);  -- flags de 4 bits
			out_estado : out std_logic_vector(2 downto 0)
		  );
end component;

component blocoOperativo is
	port(
			clock: in std_logic;
			PCescCond,
			PCesc,
			IouD,
			MemParaReg,
			regEscrita, 
			ULAfonteA,
			MemLeitura,
			MemEscrita : in std_logic;
			ULAfonteB,
			PCfonte    : in std_logic_vector(1 downto 0);
			ULAop      : in std_logic_vector(3 downto 0);
			opcode: out std_logic_vector(3 downto 0);
			-- PORTAS PARA DEBUG --
			out_entrada_PC,
			out_saida_PC,
			out_saida_MemInstr, 
			out_saida_BdRA, 
			out_saida_BdRB, 
			out_saida_ExtensorSinal2p8, 
			out_saida_ExtensorSinal4p8, 
			out_saida_RegA, 
			out_saida_RegB, 
			out_saida_MUXfonteA, 
			out_saida_MUXfonteB, 
			out_saida_ULA, 
			out_saida_RegULAout: out std_logic_vector(7 downto 0);
			out_habilitaPC, 
			out_zeroULA: out std_logic
		  );
end component;

signal PCescCond, PCesc, IouD, MemParaReg, regEscrita, 
			ULAfonteA, MemLeitura, MemEscrita : std_logic;

signal ULAfonteB, PCfonte : std_logic_vector(1 downto 0);
signal ULAop, opcode : std_logic_vector(3 downto 0);
begin
	controle: blocoControle port map(
												clock => clock,
												reset => reset,	
												opcode => opcode,
												PCescCond => PCescCond,
												PCesc => PCesc,
												IouD => IouD,
												MemParaReg => MemParaReg,
												regEscrita => regEscrita,
												ULAfonteA => ULAfonteA,
												MemLeitura => MemLeitura,
												MemEscrita => MemEscrita,
												ULAfonteB => ULAfonteB,
												PCfonte => PCfonte,
												ULAop => ULAop,
												out_estado => out_estado
												);
												
	operavito: blocoOperativo port map(
													clock => clock, 
													opcode => opcode,
													PCescCond => PCescCond,
													PCesc => PCesc,
													IouD => IouD,
													MemParaReg => MemParaReg,
													regEscrita => regEscrita,
													ULAfonteA => ULAfonteA,
													MemLeitura => MemLeitura,
													MemEscrita => MemEscrita,
													ULAfonteB => ULAfonteB,
													PCfonte => PCfonte,
													ULAop => ULAop,
													-- PORTAS PARA DEBUG --
													out_entrada_PC => entrada_PC,
													out_saida_PC => saida_PC,
													out_saida_MemInstr => saida_MemInstr,
													out_saida_BdRA => saida_BdRA,
													out_saida_BdRB => saida_BdRB,
													out_saida_ExtensorSinal2p8 => saida_ExtensorSinal2p8,
													out_saida_ExtensorSinal4p8 => saida_ExtensorSinal4p8,
													out_saida_RegA => saida_RegA,
													out_saida_RegB => saida_RegB,
													out_saida_MUXfonteA => saida_MUXfonteA,
													out_saida_MUXfonteB => saida_MUXfonteB,
													out_saida_ULA => saida_ULA,
													out_saida_RegULAout => saida_RegULAout,
													out_habilitaPC => habilitaPC,
													out_zeroULA => zeroULA
												  );
												  			
end behavior;
		