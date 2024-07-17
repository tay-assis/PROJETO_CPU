-- Importação de bibliotecas necessárias
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

-- Definindo a entidade Tri_Stage
ENTITY Tri_Stage IS
    PORT(
        Data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Enable : IN STD_LOGIC; 
        Data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) 
    );
END Tri_Stage;

-- Arquitetura comportamental do buffer
ARCHITECTURE Behavior_Buffer OF Tri_Stage IS 
BEGIN
    Data_out <= Data_in WHEN Enable = '1' ELSE (OTHERS => 'Z');
END Behavior_Buffer;
