
--Company: 
--Engineer: 
--Create Date: 27.03.2023 15:48:01
--Design Name: 
--Module Name: control_unit
-- Project Name: 
--Target Devices: 
--Tool Versions: 
--Description:  
-- Dependencies: 
-- Revision:
--Revision 0.01 - File Created
---Additional Comments:

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control_Unit is
    Port (
        clk             : in  std_logic;
        reset_btn       : in  std_logic;
        pause_btn       : in  std_logic;
        debounced_button: in  std_logic_vector(3 downto 0);
        counter_values  : inout std_logic_vector(15 downto 0);
        warning_light   : out std_logic;
        seg             : out std_logic_vector(6 downto 0);
        an              : out std_logic_vector(3 downto 0)
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
    signal reset, pause : std_logic;
    signal debounced_button_out : std_logic_vector(3 downto 0);

    component Button_Debouncer is
        Port (
            clk          : in  std_logic;
            reset        : in  std_logic;
            raw_button   : in  std_logic_vector(3 downto 0);
            debounced_button : out std_logic_vector(3 downto 0)
        );
    end component;

    component Counter is
        Port (
            clk             : in  std_logic;
            reset           : in  std_logic;
            pause           : in  std_logic;
            debounced_button: in  std_logic_vector(3 downto 0);
            counter_values  : inout std_logic_vector(15 downto 0)
        );
    end component;

    component Display is
        Port (
            clk            : in std_logic;
            reset          : in std_logic;
            counter_values : in std_logic_vector(15 downto 0);
            seg            : out std_logic_vector(6 downto 0);
            an             : out std_logic_vector(3 downto 0)
        );
    end component;

    component WarningLight is
        Port (
            clk             : in  std_logic;
            reset           : in  std_logic;
            counter_values  : in  std_logic_vector(15 downto 0);
            warning_light   : out std_logic
        );
    end component;

begin
    btn_debouncer: Button_Debouncer
        port map (
            clk => clk,
            reset => reset,
            raw_button => debounced_button(3 downto 0),
            debounced_button => debounced_button_out
        );

    ctr: Counter
        port map (
            clk => clk,
            reset => reset,
            pause => pause,
            debounced_button => debounced_button,
            counter_values => counter_values
        );

    disp: Display
        port map (
            clk => clk,
            reset => reset,
            counter_values => counter_values,
            seg => seg,
            an => an
        );

    w_light: WarningLight
        port map (
            clk => clk,
            reset => reset,
            counter_values => counter_values,
            warning_light => warning_light
        );

    process(clk)
    begin
        if rising_edge(clk) then
            reset <= reset_btn;
            pause <= pause_btn;
        end if;
    end process;
end Behavioral;


