-- Importação de bibliotecas necessárias
LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade do testbench
ENTITY Plaquinha_tb IS
END Plaquinha_tb;

-- Arquitetura do testbench
ARCHITECTURE Behavioral OF Plaquinha_tb IS

    -- Declaração dos sinais usados no testbench
    SIGNAL CLOCK_50 : STD_LOGIC; 
    SIGNAL SW : STD_LOGIC_VECTOR (17 DOWNTO 0); 
    SIGNAL HEX1 : STD_LOGIC_VECTOR (6 DOWNTO 0); 
    SIGNAL HEX2 : STD_LOGIC_VECTOR (6 DOWNTO 0); 
    SIGNAL HEX3 : STD_LOGIC_VECTOR (6 DOWNTO 0); 
    SIGNAL HEX4 : STD_LOGIC_VECTOR (6 DOWNTO 0); 
    SIGNAL HEX5 : STD_LOGIC_VECTOR (6 DOWNTO 0); 
    SIGNAL HEX6 : STD_LOGIC_VECTOR (6 DOWNTO 0); 
    SIGNAL LEDR : STD_LOGIC_VECTOR (1 DOWNTO 0); 
    
BEGIN
    
    -- Instanciação da unidade sob teste (UUT)
    UUT : ENTITY WORK.Plaquinha PORT MAP (
        CLOCK_50, -- Conexão do sinal de clock
        SW, -- Conexão do sinal dos switches
        HEX1, -- Conexão do sinal de saída (R1)
        HEX2, -- Conexão do sinal de saída (R2)
        HEX3, -- Conexão do sinal de saída (R3)
        HEX4, -- Conexão do sinal de saída (A)
        HEX5, -- Conexão do sinal de saída (G)
        HEX6, -- Conexão do sinal de saída (D)
        LEDR -- Conexão do sinal de saída (DONE)
    );

END ARCHITECTURE Behavioral;
