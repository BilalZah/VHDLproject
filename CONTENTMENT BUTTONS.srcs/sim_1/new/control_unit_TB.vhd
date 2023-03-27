----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2023 21:45:58
-- Design Name: 
-- Module Name: control_unit_TB - Behavioral
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

entity Control_Unit_tb is
end Control_Unit_tb;

architecture sim of Control_Unit_tb is
    signal clk, reset_btn, pause_btn : std_logic := '0';
    signal debounced_button          : std_logic_vector(3 downto 0) := (others => '0');
    signal counter_values            : std_logic_vector(15 downto 0);
    signal warning_light             : std_logic;
    signal seg                       : std_logic_vector(6 downto 0);
    signal an                        : std_logic_vector(3 downto 0);

    component Control_Unit is
        Port (
            clk             : in  std_logic;
            reset_btn       : in  std_logic;
            pause_btn       : in  std_logic;
            debounced_button: in  std_logic_vector(3 downto 0);
            counter_values  : out std_logic_vector(15 downto 0);
            warning_light   : out std_logic;
            seg             : out std_logic_vector(6 downto 0);
            an              : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    uut: Control_Unit
        port map (
            clk => clk,
            reset_btn => reset_btn,
            pause_btn => pause_btn,
            debounced_button => debounced_button,
            counter_values => counter_values,
            warning_light => warning_light,
            seg => seg,
            an => an
        );

    clk_gen: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    stim_proc: process
    begin
        -- Test case 1: Reset the system
        reset_btn <= '1';
        wait for 20 ns;
        reset_btn <= '0';

        -- Test case 2: Increment the 'pleased' count
        debounced_button <= "0100";
        wait for 20 ns;
        debounced_button <= (others => '0');
        wait for 20 ns;

        -- Test case 3: Increment the 'unhappy' count
        debounced_button <= "1000";
        wait for 20 ns;
        debounced_button <= (others => '0');
        wait for 20 ns;

        -- Test case 4: Pause the system
        pause_btn <= '1';
        wait for 20 ns;
        pause_btn <= '0';

        -- Test case 5: Increment the 'neutral' count while paused (should not increment)
        debounced_button <= "0010";
        wait for 20 ns;
        debounced_button <= (others => '0');
        wait for 20 ns;

        -- Test case 6: Unpause the system
        pause_btn <= '0';
        wait for 20 ns;
            -- Test case 7: Increment the 'neutral' count after unpausing (should increment)
    debounced_button <= "0010";
    wait for 20 ns;
    debounced_button <= (others => '0');
    wait for 20 ns;

    -- Test case 8: Increment the 'delighted' count
    debounced_button <= "0001";
    wait for 20 ns;
    debounced_button <= (others => '0');
    wait for 20 ns;

    -- Test case 9: Observe the warning light status when 'unhappy' count is greater than the sum of other counts
    debounced_button <= "1000";
    wait for 20 ns;
    debounced_button <= (others => '0');
    wait for 20 ns;

    wait;
end process;


