----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2023 19:48:01
-- Design Name: 
-- Module Name: display - Behavioral
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

entity Display is
    Port (
        clk            : in std_logic;
        reset          : in std_logic;
        counter_values : in std_logic_vector(15 downto 0);
        seg            : out std_logic_vector(6 downto 0);
        an             : out std_logic_vector(3 downto 0)
    );
end Display;

architecture Behavioral of Display is
    signal digit_sel    : integer range 0 to 3 := 0;
    signal digit_count  : integer range 0 to 999 := 0;
    signal selected_val : std_logic_vector(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            digit_sel <= 0;
            digit_count <= 0;
        elsif rising_edge(clk) then
            if digit_count = 999 then
                digit_count <= 0;
                digit_sel <= (digit_sel + 1) mod 4;
            else
                digit_count <= digit_count + 1;
            end if;
        end if;
    end process;

    selected_val <= counter_values(digit_sel * 4 + 3 downto digit_sel * 4);

    process(selected_val)
    variable seg_temp : std_logic_vector(6 downto 0);
    begin
        case selected_val is
            when "0000" => seg_temp := "1000000";
            when "0001" => seg_temp := "1111001";
            when "0010" => seg_temp := "0100100";
            when "0011" => seg_temp := "0110000";
            when "0100" => seg_temp := "0011001";
            when "0101" => seg_temp := "0010010";
            when "0110" => seg_temp := "0000010";
            when "0111" => seg_temp := "1111000";
            when "1000" => seg_temp := "0000000";
            when "1001" => seg_temp := "0010000";
            when others => seg_temp := "1111111";
        end case;
        seg <= seg_temp;
    end process;

    process(digit_sel)
    variable an_temp : std_logic_vector(3 downto 0);
    begin
        case digit_sel is
            when 0 => an_temp := "1110";
            when 1 => an_temp := "1101";
            when 2 => an_temp := "1011";
            when 3 => an_temp := "0111";
            when others => an_temp := "1111";
        end case;
        an <= an_temp;
    end process;
end Behavioral;



