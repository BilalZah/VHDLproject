----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2023 19:49:40
-- Design Name: 
-- Module Name: button_debouncer - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Button_Debouncer is
    Port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        raw_button   : in  std_logic_vector(3 downto 0);
        debounced_button : out std_logic_vector(3 downto 0)
    );
end Button_Debouncer;

architecture Behavioral of Button_Debouncer is
    type state_type is (IDLE, WAIT_LOW, WAIT_HIGH);
    signal state        : state_type;
    signal debounce_count: natural range 0 to 5000 := 0; -- Adjust the range for the desired debounce time
    signal current_button: std_logic_vector(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            debounced_button <= (others => '0');
            state <= IDLE;
            debounce_count <= 0;
             current_button <= (others => '0');
        elsif rising_edge(clk)then
                    case state is
                when IDLE =>
                    if raw_button /= current_button then
                        state <= WAIT_LOW;
                        debounce_count <= 0;
                    end if;
                when WAIT_LOW =>
                    debounce_count <= debounce_count + 1;
                    if debounce_count >= 5000 then
                        state <= WAIT_HIGH;
                        current_button <= raw_button;
                    end if;
                when WAIT_HIGH =>
                    debounce_count <= debounce_count + 1;
                    if debounce_count >= 5000 then
                        state <= IDLE;
                        debounced_button <= current_button;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

