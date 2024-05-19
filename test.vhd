
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test is
    
end test;

architecture Behavioral of test is

    component main is
        Port ( 
                CLK100MHZ, RST : in  STD_LOGIC;
                secs_out, secs_out_T, mins_out, mins_out_T : out STD_LOGIC_VECTOR(6 downto 0)
            );
    end component;
        signal clk_sim : STD_LOGIC := '0';
        signal secs_sim : STD_LOGIC_VECTOR (6 downto 0) := "1111110";
        signal mins_sim: STD_LOGIC_VECTOR (6 downto 0) := "1111110";
        signal secsT_sim : STD_LOGIC_VECTOR (6 downto 0) := "1111110";
        signal minsT_sim: STD_LOGIC_VECTOR (6 downto 0) := "1111110";
begin
    clock: main PORT MAP (
        CLK100MHZ => clk_sim, 
        RST => '0', 
        mins_out => mins_sim, 
        secs_out => secs_sim,
        mins_out_T => minsT_sim, 
        secs_out_T => secsT_sim
        );
    process
    begin
        loop
            clk_sim <= '1';
            wait for 10ps;
            clk_sim <= '0';
            wait for 10ps;
        end loop;
    end process;
end Behavioral;
