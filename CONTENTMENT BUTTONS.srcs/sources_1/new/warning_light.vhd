----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2023 19:48:01
-- Design Name: 
-- Module Name: warning_light - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Warning_Light is
    Port (
        clk             : in  std_logic;
        reset           : in  std_logic;
        counter_values  : in  std_logic_vector(15 downto 0);
        warning_light   : out std_logic
    );
end Warning_Light;

architecture Behavioral of Warning_Light is
    signal unhappy_count : std_logic_vector(3 downto 0);
    signal other_counts  : std_logic_vector(3 downto 0);
    signal light_on      : boolean := false;
    signal count         : natural := 0;
begin
    unhappy_count <= counter_values(15 downto 12);
    other_counts  <= counter_values(11 downto 8) + counter_values(7 downto 4) + counter_values(3 downto 0);

    process(clk, reset)
    begin
        if reset = '1' then
            light_on <= false;
            count <= 0;
            warning_light <= '0';
        elsif rising_edge(clk) then
            if unhappy_count > other_counts then
                count <= (count + 1) mod 50000; -- Adjust the range for the desired flashing frequency
                if count = 0 then
                    light_on <= not light_on;
                end if;
            else
                light_on <= false;
            end if;
        end if;
    end process;

    process(light_on)
    begin
        if light_on then
            warning_light <= '1';
        else
            warning_light <= '0';
        end if;
    end process;
end Behavioral;



end Behavioral;
