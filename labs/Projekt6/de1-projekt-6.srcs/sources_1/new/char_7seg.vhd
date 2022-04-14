----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2022 01:43:18 PM
-- Design Name: 
-- Module Name: char_7seg - Behavioral
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

entity char_7seg is
    Port ( char_i : in STD_LOGIC_VECTOR (5-1 downto 0);
           seg_o : out STD_LOGIC_VECTOR (7-1 downto 0));
end char_7seg;

architecture Behavioral of char_7seg is

begin 
    char_7seg : process(char_i)
    begin
        case char_i is
            when "00000" =>
                seg_o <= "0000001"; -- 0,O
            when "00001" =>
                seg_o <= "1001111"; -- 1,I             
            when "00010" =>
                seg_o <= "0010010"; -- 2,Z
            when "00011" =>
                seg_o <= "0000110"; -- 3
            when "00100" =>
                seg_o <= "1001100"; -- 4
            when "00101" =>
                seg_o <= "0100100"; -- 5,S
            when "00110" =>
                seg_o <= "0100000"; -- 6
            when "00111" =>
                seg_o <= "0001111"; -- 7,T
            when "01000" =>
                seg_o <= "0000000"; -- 8
            when "01001" =>
                seg_o <= "0000100"; -- 9
            when "01010" =>
                seg_o <= "0001000"; -- A
            when "01011" =>
                seg_o <= "1100000"; -- b
            when "01100" =>
                seg_o <= "0110001"; -- C
            when "01101" =>
                seg_o <= "1000010"; -- d
            when "01110" =>
                seg_o <= "0110000"; -- E
            when "01111" =>
                seg_o <= "0111000"; -- F
            when "10000" =>
                seg_o <= "0100001"; -- G
            when "10001" =>
                seg_o <= "1001000"; -- H            
            when "10010" =>
                seg_o <= "1000011"; -- J               
            when "10011" =>
                seg_o <= "1010000"; -- k 
            when "10100" =>
                seg_o <= "1110001"; -- L 
            when "10101" =>
                seg_o <= "0001001"; -- M
            when "10110" =>
                seg_o <= "1101010"; -- n  
            when "10111" =>
                seg_o <= "0011000"; -- P 
            when "11000" =>
                seg_o <= "0001100"; -- q 
            when "11001" =>
                seg_o <= "1111010"; -- r 
            when "11010" =>
                seg_o <= "1100011"; -- U 
            when "11011" =>
                seg_o <= "1000001"; -- V 
            when "11100" =>
                seg_o <= "1000000"; -- W 
            when "11101" =>
                seg_o <= "1001001"; -- X  
            when "11110" =>
                seg_o <= "1000100"; -- Y 
            when others => --"11111" =>
                seg_o <= "1111111"; -- ''
                                           
        end case;
        end process char_7seg;

end Behavioral;

