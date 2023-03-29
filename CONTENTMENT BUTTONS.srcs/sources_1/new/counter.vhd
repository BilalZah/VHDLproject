----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2023 19:48:01
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity Counter is
    Port (
        clk             : in  std_logic;
        reset           : in  std_logic;
        pause           : in  std_logic;
        debounced_button: in  std_logic_vector(3 downto 0);
        counter_values  : inout std_logic_vector(15 downto 0)
    );
end Counter;

architecture Behavioral of Counter is
    signal counters: std_logic_vector(15 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counters <= (others => '0');
        elsif rising_edge(clk) and pause /= '1' then
            for i in 0 to 3 loop
                if debounced_button(i) = '1' then
                    counters(i*4+3 downto i*4) <= counters(i*4+3 downto i*4) + 1;
                end if;
            end loop;
        end if;
    end process;

    counter_values <= counters;
end Behavioral;






