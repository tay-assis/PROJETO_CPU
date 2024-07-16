-- Importação de bibliotecas necessárias
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

-- Definição da entidade Plaquinha
ENTITY Plaquinha IS
    PORT (
        CLOCK_50 : IN STD_LOGIC; 
        SW : IN STD_LOGIC_VECTOR (17 DOWNTO 0); 
        HEX1 : OUT STD_LOGIC_VECTOR (0 TO 6); 
        HEX2 : OUT STD_LOGIC_VECTOR (0 TO 6); 
        HEX3 : OUT STD_LOGIC_VECTOR (0 TO 6); 
        HEX4 : OUT STD_LOGIC_VECTOR (0 TO 6); 
        HEX5 : OUT STD_LOGIC_VECTOR (0 TO 6); 
        HEX6 : OUT STD_LOGIC_VECTOR (0 TO 6); 
        LEDR : OUT STD_LOGIC_VECTOR (1 DOWNTO 0) 
    );
END Plaquinha;

-- Arquitetura comportamental da entidade Plaquinha
ARCHITECTURE Behavioral OF Plaquinha IS
	-- Definição do componente CPU
	COMPONENT CPU
	PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Enable : IN STD_LOGIC;
        F : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Done : OUT STD_LOGIC;
        R1, R2, R3, A, G  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
	END COMPONENT;
	
	-- Sinais internos para os registros e LED de DONE
	SIGNAL R1, R2, R3, A, G : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL LED : STD_LOGIC;
	
BEGIN
	-- Instancia a CPU e mapeia as portas
	PROCESSADOR : CPU PORT MAP (
        CLOCK_50,          -- Sinal de clock
        SW(3),             -- Sinal de reset
        SW(4),             -- Sinal de enable
        SW(8 DOWNTO 6),    -- Função de controle
        SW(17 DOWNTO 14),  -- Dados de entrada
        LED,               -- Sinal de done
        R1, R2, R3, A, G   -- Registros de saída
    );
	
	-- Mapear o sinal de conclusão (Done) LED para os LEDs
	LEDR(1) <= LED;
	LEDR(0) <= LED;
	
	-- Decodificação dos valores de R1 para o display de 7 segmentos HEX1
	WITH R1 SELECT
	HEX1 <=  "0000001" WHEN "0000",
				"1001111" WHEN "0001",
			   "0010010" WHEN "0010",
			   "0000110" WHEN "0011",
			   "1001100" WHEN "0100",
			   "0100100" WHEN "0101",
			   "0100000" WHEN "0110",
			   "0001111" WHEN "0111",
			   "0000000" WHEN "1000",
			   "0000100" WHEN "1001",
			   "0001000" WHEN "1010",
			   "1100000" WHEN "1011",
			   "0110001" WHEN "1100",
			   "1000010" WHEN "1101",
			   "0110000" WHEN "1110",
			   "0111000" WHEN "1111",
			   "1111111" WHEN OTHERS;
	
	-- Decodificação dos valores de R2 para o display de 7 segmentos HEX2
	WITH R2 SELECT
	HEX2 <=  "0000001" WHEN "0000",
				"1001111" WHEN "0001",
			   "0010010" WHEN "0010",
			   "0000110" WHEN "0011",
			   "1001100" WHEN "0100",
			   "0100100" WHEN "0101",
			   "0100000" WHEN "0110",
			   "0001111" WHEN "0111",
			   "0000000" WHEN "1000",
			   "0000100" WHEN "1001",
			   "0001000" WHEN "1010",
			   "1100000" WHEN "1011",
			   "0110001" WHEN "1100",
			   "1000010" WHEN "1101",
			   "0110000" WHEN "1110",
			   "0111000" WHEN "1111",
			   "1111111" WHEN OTHERS;
				
	-- Decodificação dos valores de R3 para o display de 7 segmentos HEX3
	WITH R3 SELECT
	HEX3 <=  "0000001" WHEN "0000",
				"1001111" WHEN "0001",
			   "0010010" WHEN "0010",
			   "0000110" WHEN "0011",
			   "1001100" WHEN "0100",
			   "0100100" WHEN "0101",
			   "0100000" WHEN "0110",
			   "0001111" WHEN "0111",
			   "0000000" WHEN "1000",
			   "0000100" WHEN "1001",
			   "0001000" WHEN "1010",
			   "1100000" WHEN "1011",
			   "0110001" WHEN "1100",
			   "1000010" WHEN "1101",
			   "0110000" WHEN "1110",
			   "0111000" WHEN "1111",
			   "1111111" WHEN OTHERS;
				
	-- Decodificação dos valores de A para o display de 7 segmentos HEX4
	WITH A SELECT
	HEX4 <=  "0000001" WHEN "0000",
				"1001111" WHEN "0001",
			   "0010010" WHEN "0010",
			   "0000110" WHEN "0011",
			   "1001100" WHEN "0100",
			   "0100100" WHEN "0101",
			   "0100000" WHEN "0110",
			   "0001111" WHEN "0111",
			   "0000000" WHEN "1000",
			   "0000100" WHEN "1001",
			   "0001000" WHEN "1010",
			   "1100000" WHEN "1011",
			   "0110001" WHEN "1100",
			   "1000010" WHEN "1101",
			   "0110000" WHEN "1110",
			   "0111000" WHEN "1111",
			   "1111111" WHEN OTHERS;
	
	-- Decodificação dos valores de G para o display de 7 segmentos HEX5
	WITH G SELECT
	HEX5 <=  "0000001" WHEN "0000",
				"1001111" WHEN "0001",
			   "0010010" WHEN "0010",
			   "0000110" WHEN "0011",
			   "1001100" WHEN "0100",
			   "0100100" WHEN "0101",
			   "0100000" WHEN "0110",
			   "0001111" WHEN "0111",
			   "0000000" WHEN "1000",
			   "0000100" WHEN "1001",
			   "0001000" WHEN "1010",
			   "1100000" WHEN "1011",
			   "0110001" WHEN "1100",
			   "1000010" WHEN "1101",
			   "0110000" WHEN "1110",
			   "0111000" WHEN "1111",
			   "1111111" WHEN OTHERS;
	
	-- Decodificação dos valores dos dados de entrada para o display de 7 segmentos HEX6
	WITH SW (17 DOWNTO 14) SELECT
	HEX6 <=  "0000001" WHEN "0000",
				"1001111" WHEN "0001",
			   "0010010" WHEN "0010",
			   "0000110" WHEN "0011",
			   "1001100" WHEN "0100",
			   "0100100" WHEN "0101",
			   "0100000" WHEN "0110",
			   "0001111" WHEN "0111",
			   "0000000" WHEN "1000",
			   "0000100" WHEN "1001",
			   "0001000" WHEN "1010",
			   "1100000" WHEN "1011",
			   "0110001" WHEN "1100",
			   "1000010" WHEN "1101",
			   "0110000" WHEN "1110",
			   "0111000" WHEN "1111",
			   "1111111" WHEN OTHERS;
				
END ARCHITECTURE Behavioral;
	