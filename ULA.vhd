-- Importação de bibliotecas necessárias
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

-- Definindo a entidade ULA
ENTITY ULA IS
    PORT(
        Clock : IN STD_LOGIC;
        A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        C_in : IN STD_LOGIC;
        G : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ULA;

-- Arquitetura comportamental da ULA
ARCHITECTURE Behavioral OF ULA IS
	 -- Sinais internos para operação	
    SIGNAL Invert_B, C, S : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

    -- Inversão de B com base em C_in
    Invert_B(0) <= B(0) XOR C_in;
    Invert_B(1) <= B(1) XOR C_in;
    Invert_B(2) <= B(2) XOR C_in;
    Invert_B(3) <= B(3) XOR C_in;

    -- Soma com carry
    S(0) <= A(0) XOR Invert_B(0) XOR C_in;
    C(0) <= (A(0) AND Invert_B(0)) OR (C_in AND A(0)) OR (C_in AND Invert_B(0));

    S(1) <= A(1) XOR Invert_B(1) XOR C(0);
    C(1) <= (A(1) AND Invert_B(1)) OR (C(0) AND A(1)) OR (C(0) AND Invert_B(1));

    S(2) <= A(2) XOR Invert_B(2) XOR C(1);
    C(2) <= (A(2) AND Invert_B(2)) OR (C(1) AND A(2)) OR (C(1) AND Invert_B(2));

    S(3) <= A(3) XOR Invert_B(3) XOR C(2);
    C(3) <= (A(3) AND Invert_B(3)) OR (C(2) AND A(3)) OR (C(2) AND Invert_B(3));

    -- Processo para atualizar G na subida do clock
    PROCESS (Clock)
    BEGIN
        IF rising_edge(Clock) THEN
            IF (C_in = '1' OR C_in = '0') THEN
					G <= S;
				ELSE 
					G <= (OTHERS => 'Z');
				END IF;
        END IF;
    END PROCESS;

END Behavioral;
