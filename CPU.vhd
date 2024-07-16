-- Importação de bibliotecas necessárias
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Definindo a entidade CPU com seus ports
ENTITY CPU IS
    PORT (
        Clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Enable : IN STD_LOGIC;
        F : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Done : OUT STD_LOGIC;
        R1, R2, R3, A, G  : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END CPU;

ARCHITECTURE Behavioral OF CPU IS
    
	 -- Declaração dos componentes usados na arquitetura
    COMPONENT Registrador
        GENERIC ( N : INTEGER := 4 );
        PORT (
            Data : IN STD_LOGIC_VECTOR (N-1 DOWNTO 0);
            Reset, Clock, Load : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (N-1 DOWNTO 0)
        );
    END COMPONENT;
	 
	 COMPONENT Tri_Stage
			PORT(
				Data_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				Enable : IN STD_LOGIC;
				Data_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
	 END COMPONENT;
	 
	 COMPONENT ULA
			PORT(
			  Clock : IN STD_LOGIC;
			  A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			  C_in : IN STD_LOGIC;
			  G : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			);
	 END COMPONENT;
    
    -- Declaração dos sinais internos
	 TYPE state_type IS (IDLE, LDR1, LDR2, LDR3, SWAP, SWAP2, SWAP3, SWAP4, ADD, SUB, DON);
    SIGNAL R1_in, R2_in, R3_in, A_in, G_in, AddSub : STD_LOGIC;
    SIGNAL R1_out, R2_out, R3_out, G_out, D_out : STD_LOGIC;
    SIGNAL R1_we, R2_we, R3_we, A_we, G_we, B_we : STD_LOGIC_VECTOR(3 DOWNTO 0);
	 SIGNAL Internal_Data, ULA_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL State : state_type;

BEGIN
	 
	 -- Instanciando registradores
	 Reg1 : Registrador PORT MAP (Internal_Data, Reset, Clock, R1_in, R1_we);
	 Reg2 : Registrador PORT MAP (Internal_Data, Reset, Clock, R2_in, R2_we);
	 Reg3 : Registrador PORT MAP (Internal_Data, Reset, Clock, R3_in, R3_we);
	 Reg4 : Registrador PORT MAP (Internal_Data, Reset, Clock, A_in, A_we); 
	 Reg5 : Registrador PORT MAP (ULA_out, Reset, Clock, G_in, G);
	 
	 -- Instanciando tri-stage buffers
	 T1 : Tri_Stage PORT MAP (R1_we, R1_out, Internal_Data);
	 T2 : Tri_Stage PORT MAP (R2_we, R2_out, Internal_Data);
	 T3 : Tri_Stage PORT MAP (R3_we, R3_out, Internal_Data);
	 T4 : Tri_Stage PORT MAP (G_we, G_out, Internal_Data);
	 TD : Tri_Stage PORT MAP (Data, D_out, Internal_Data);
	 
    -- Instanciando ULA
	 ADD_SUB : ULA PORT MAP (Clock, A_we, R2_we, AddSub, ULA_out);
	 
	 -- Processo principal que controla o estado da CPU
	 PROCESS (Clock, Reset, State, F)
    BEGIN
        IF Reset = '0' THEN
            State <= IDLE;
        ELSIF rising_edge(Clock) THEN
                CASE State IS
							-- Estado inicial
							WHEN IDLE =>
									Done <= '0';
									R1_in <= '0';
									R2_in <= '0';
									R3_in <= '0';
									A_in <= '0';
									G_in <= '0';
									R1_out <= '0';
									R2_out <= '0';
									R3_out <= '0';
									AddSub <= 'Z';
									G_out <= '0';
									D_out <= '0';
									ULA_out <= (OTHERS => 'Z');
									
									-- Transição de estado com base no valor de F e Enable
									IF (F = "101") AND (Enable = '1') THEN
										State <= LDR1;
										
									ELSIF (F = "110") AND (Enable = '1') THEN
										State <= LDR2;
										
									ELSIF (F = "111") AND (Enable = '1') THEN
										State <= LDR3;
									
									ELSIF (F = "011") AND (Enable = '1') THEN
										State <= SWAP;
										
									ELSIF (F = "010") AND (Enable = '1') THEN
										State <= ADD;
										
									ELSIF (F = "001") AND (Enable = '1') THEN
										State <= SUB;
										
									ELSE 
										State <= IDLE;
									
									END IF;
							
							-- Carregar dados em R1
							WHEN LDR1 =>
									D_out <= '1';
									R1_in <= '1';
									State <= DON;
							
							-- Carregar dados em R2
							WHEN LDR2 =>
									D_out <= '1';
									R2_in <= '1';
									State <= DON;
							
							-- Carregar dados em R3
							WHEN LDR3 =>
									D_out <= '1';
									R3_in <= '1';
									State <= DON;
							
							-- Troca dos dados de R2 para R3
							WHEN SWAP =>
									R1_out <= '0';
									R1_in <= '0';
									R2_out <= '1';
									R2_in <= '0';
									R3_out <= '0';
									R3_in <= '1';
									Done <= '0';
									State <= SWAP2;
							
							-- Troca dos dados de R1 para R2
							WHEN SWAP2 =>
									R1_out <= '1';
									R1_in <= '0';
									R2_out <= '0';
									R2_in <= '1';
									R3_out <= '0';
									R3_in <= '0';
									Done <= '0';
									State <= SWAP3;
							
							-- Troca de dados de R3 para R1	
							WHEN SWAP3 =>
									R1_out <= '0';
									R1_in <= '1';
									R2_out <= '0';
									R2_in <= '0';
									R3_out <= '1';
									R3_in <= '0';
									Done <= '0';
									State <= DON;
							
							-- Adição		
							WHEN ADD =>
									R1_out <= '1';
									A_in <= '1';
									G_in <= '1';
									AddSub <= '0';
									State <= DON;
							
							-- Subtração
							WHEN SUB =>
									R1_out <= '1';
									A_in <= '1';
									G_in <= '1';
									AddSub <= '1';
									State <= DON;
							
							-- Estado de conclusão		
							WHEN DON =>
									Done <= '1';
									State <= IDLE;
							
							-- Estado padrão
							WHEN OTHERS =>
									State <= IDLE;
					END CASE;
        END IF;
    END PROCESS;

	 -- Mapeamento dos registradores de saída
	 R1 <= R1_we;
	 R2 <= R2_we;
	 R3 <= R3_we;
	 G_we <= G;
	 A <= A_we;

END Behavioral;
