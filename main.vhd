
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
    Port (         
            CLK100MHZ, RST : in  STD_LOGIC;
            secs_out, secs_out_T, mins_out, mins_out_T : out STD_LOGIC_VECTOR(6 downto 0)
        );
end main;

architecture Behavioral of main is

	component custom_clk is
    		port ( clk,reset: in std_logic; clock_out: out std_logic);
	end component;
	signal clk1Hz: STD_LOGIC;
    signal secs :  STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal mins :  STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal secsT :  STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal minsT :  STD_LOGIC_VECTOR (3 downto 0) := "0000";
    function BCD_to_7Seg (
        BCD : in STD_LOGIC_VECTOR(3 downto 0))
        return STD_LOGIC_VECTOR is
    begin
        case BCD is
            when "0000" => return "1111110"; ---0
            when "0001" => return "0110000"; ---1
            when "0010" => return "1101101"; ---2
            when "0011" => return "1111001"; ---3
            when "0100" => return "0110011"; ---4
            when "0101" => return "1011011"; ---5
            when "0110" => return "1011111"; ---6
            when "0111" => return "1110000"; ---7
            when "1000" => return "1111111"; ---8
            when "1001" => return "1111011"; ---9
            when others => return "0000000"; ---null
        end case;
    end BCD_to_7Seg;
begin
    clk1: custom_clk PORT MAP (clk => CLK100MHZ, reset => '0', clock_out => clk1Hz);
    process (clk1Hz,RST)
    begin
        if (RST = '1') then
            secs <= "0000";
            mins <= "0000";
            secsT <= "0000";
            minsT <= "0000";
        elsif(rising_edge(clk1Hz)) then
            if secs = "1001" then
                secs <= "0000";
                if secsT = "0101" then
                    secsT <= "0000";
                    if mins = "1001" then
                        mins <= "0000";
                        if minsT = "0101" then
                            minsT <= "0000";
                        else    
                            minsT <= minsT + 1;
                        end if;
                    else
                        mins <= mins + 1;
                    end if;
                else
                    secsT <= secsT + 1;
                end if;
            else
                secs <= secs + 1;
            end if;
        end if;
        secs_out <= BCD_to_7Seg(secs);
        secs_out_T <= BCD_to_7Seg(secsT);
        mins_out <= BCD_to_7Seg(mins);
        mins_out_T <= BCD_to_7Seg(minsT);
    end process;
end Behavioral;