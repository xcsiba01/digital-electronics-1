------------------------------------------------------------
--
-- Traffic light controller using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- This code is inspired by:
-- [1] LBEbooks, Lesson 92 - Example 62: Traffic Light Controller
--     https://www.youtube.com/watch?v=6_Rotnw1hFM
-- [2] David Williams, Implementing a Finite State Machine in VHDL
--     https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
-- [3] VHDLwhiz, One-process vs two-process vs three-process state machine
--     https://vhdlwhiz.com/n-process-state-machine/
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------
entity states is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        dp_i    : in  std_logic_vector(7 downto 0);
        dp_o    : out std_logic;
        seg_o   : out std_logic_vector(6 downto 0);
        dig_o   : out std_logic_vector(7 downto 0)
        -- Traffic lights (RGB LEDs) for two directions
        
    );
end entity states;

------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------
architecture Behavioral of states is

    -- Define the states
    type t_state is (state1,
                     state2,
                     state3,
                     state4,
                     state5,
                     state6,
                     state7,
                     state8);
    -- Define the signal that uses different states
    signal s_state : t_state;

    -- Internal clock enable
    signal s_en : std_logic;

    -- Local delay counter
    signal s_cnt : unsigned(4 downto 0);
    signal s_data0 : std_logic_vector (4 downto 0);
    signal s_data1 : std_logic_vector (4 downto 0);
    signal s_data2 : std_logic_vector (4 downto 0);
    signal s_data3 : std_logic_vector (4 downto 0);
    signal s_data4 : std_logic_vector (4 downto 0);
    signal s_data5 : std_logic_vector (4 downto 0);
    signal s_data6 : std_logic_vector (4 downto 0);
    signal s_data7 : std_logic_vector (4 downto 0);

    -- Specific values for local counter
    constant c_DELAY_1SEC : unsigned(4 downto 0) := b"0_0100";
    constant c_ZERO       : unsigned(4 downto 0) := b"0_0000";

    -- Output values
    

begin

    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 250 ms (4 Hz). Remember that 
    -- the frequency of the clock signal is 100 MHz.
    
    -- USE THIS PART FOR FASTER/SHORTER SIMULATION
    -- s_en <= '1';
    -- USE THE FOLLOWING PART FOR THE IMPLEMENTATION
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 25000000 -- 250 ms / (1/100 MHz) = 25000000
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );
        
    driver : entity work.driver_7seg_8digits
        port map(
            clk   => clk,
            reset => reset,
            data0_i     => s_data0,
            data1_i     => s_data1,
            data2_i     => s_data2,
            data3_i     => s_data3,
            data4_i     => s_data4,
            data5_i     => s_data5,
            data6_i     => s_data6,
            data7_i     => s_data7,
            seg_o       => seg_o,
            dp_i => dp_i,
            dp_o => dp_o,
            dig_o => dig_o
        );

    --------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and 
    -- clock_enable entirely controls the s_state signal by 
    -- CASE statement.
    --------------------------------------------------------
    p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then   -- Synchronous reset
                s_state <= state1;   -- Set initial state
                s_cnt   <= c_ZERO;  -- Clear delay counter

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
                    when state1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state2;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;

                    when state2 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state3;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when state3 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state4;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;

                    when state4 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state5;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;
                               
                    when state5 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state6;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when state6 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state7;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;  
                        
                   when state7 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state8;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;

                   when state8 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= state1;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;                                         

                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made.
                    when others =>
                        s_state <= state1;
                        s_cnt   <= c_ZERO;
                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_traffic_fsm;

    --------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state
    -- changes and sets the output signals accordingly.
    -- This is an example of a Moore state machine and
    -- therefore the output is set based on the active state.
    --------------------------------------------------------
    p_output_fsm : process(s_state)
    begin
        case s_state is
            when state1 =>                
                s_data7 <= "00111"; --7
                s_data6 <= "00101"; --S
                s_data5 <= "01110"; --E
                s_data4 <= "10000"; --G
                s_data3 <= "10101"; --M
                s_data2 <= "01110"; --E
                s_data1 <= "10110"; --N
                s_data0 <= "00111"; --T
            
            when state2 =>
                -- WRITE OTHER STATES HERE
                s_data7 <= "00111"; --T
                s_data6 <= "00111"; --7
                s_data5 <= "00101"; --S
                s_data4 <= "01110"; --E
                s_data3 <= "10000"; --G
                s_data2 <= "10101"; --M
                s_data1 <= "01110"; --E
                s_data0 <= "10110"; --N  
            when state3 =>
                s_data7 <= "10110"; --N
                s_data6 <= "00111"; --T
                s_data5 <= "00111"; --7
                s_data4 <= "00101"; --S
                s_data3 <= "01110"; --E
                s_data2 <= "10000"; --G
                s_data1 <= "10101"; --M
                s_data0 <= "01110"; --E  
            when state4 =>
                s_data7 <= "01110"; --E
                s_data6 <= "10110"; --N
                s_data5 <= "00111"; --T
                s_data4 <= "00111"; --7
                s_data3 <= "00101"; --S
                s_data2 <= "01110"; --E
                s_data1 <= "10000"; --G
                s_data0 <= "10101"; --M  
            when state5 =>
                s_data7 <= "10101"; --M
                s_data6 <= "01110"; --E
                s_data5 <= "10110"; --N
                s_data4 <= "00111"; --T
                s_data3 <= "00111"; --7
                s_data2 <= "00101"; --S
                s_data1 <= "01110"; --E
                s_data0 <= "10000"; --G   
            when state6 =>
                s_data7 <= "10000"; --G
                s_data6 <= "10101"; --M
                s_data5 <= "01110"; --E
                s_data4 <= "10110"; --N
                s_data3 <= "00111"; --T
                s_data2 <= "00111"; --7
                s_data1 <= "00101"; --S
                s_data0 <= "01110"; --E
            when state7 =>
                s_data7 <= "01110"; --E
                s_data6 <= "10000"; --G
                s_data5 <= "10101"; --M
                s_data4 <= "01110"; --E
                s_data3 <= "10110"; --N
                s_data2 <= "00111"; --T
                s_data1 <= "00111"; --7
                s_data0 <= "00101"; --S  
            when state8 =>
                s_data7 <= "00101"; --S
                s_data6 <= "01110"; --E
                s_data5 <= "10000"; --G
                s_data4 <= "10101"; --M
                s_data3 <= "01110"; --E
                s_data2 <= "10110"; --N
                s_data1 <= "00111"; --T
                s_data0 <= "00111"; --7   
            when others =>
                s_data7 <= "00111"; --7
                s_data6 <= "00101"; --S
                s_data5 <= "01110"; --E
                s_data4 <= "10000"; --G
                s_data3 <= "10101"; --M
                s_data2 <= "01110"; --E
                s_data1 <= "10110"; --N
                s_data0 <= "00111"; --T
        end case;
    end process p_output_fsm;

end architecture Behavioral;