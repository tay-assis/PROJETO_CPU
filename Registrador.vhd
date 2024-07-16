-- Importação de bibliotecas necessárias
LIBRARY ieee ;
USE ieee.std_logic_1164.all;

-- Definindo a entidade Registrador e seus ports
ENTITY Registrador IS
    GENERIC (N : INTEGER := 4); 
    PORT (
        Data : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0); 
        Reset, Clock, Load : IN STD_LOGIC; 
        Q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) 
    );
END Registrador;

-- Arquitetura Behavioral do registrador
ARCHITECTURE Behavioral OF Registrador IS
BEGIN
    -- Processo que descreve o comportamento do registrador
    PROCESS (Reset, Clock)
    BEGIN
        IF Reset = '0' THEN
            Q <= (OTHERS => '0'); 
        
		  ELSIF Clock'EVENT AND Clock = '0' THEN
            IF Load = '1' THEN
                Q <= Data;
					 
            END IF;
        END IF;
    END PROCESS;
END Behavioral;
