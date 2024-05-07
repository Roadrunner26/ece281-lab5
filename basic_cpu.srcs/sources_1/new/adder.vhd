----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 09:35:49 PM
-- Design Name: 
-- Module Name: adder - Behavioral
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
use IEEE.numeric_std.ALL;

entity adder is
    port(
        i_Cin   : in  std_logic;
        i_A     : in  std_logic_vector(7 downto 0); -- Adjusted to 9 bits
        i_B     : in  std_logic_vector(7 downto 0); -- Adjusted to 9 bits
        o_Cout  : out std_logic;
        o_result: out std_logic_vector(7 downto 0) -- Adjusted to 8 bits
    );
end entity adder;

architecture Behavioral of adder is
    signal sum   : std_logic_vector(8 downto 0);
    signal carry : std_logic;
begin
    -- Convert inputs to signed for arithmetic operations
    sum <= std_logic_vector(signed('0' & i_A) + 
           signed('0' & i_B) + 
           signed(i_Cin & '0' & std_logic_vector(to_unsigned(0,7))));

    -- Output carry
    o_Cout <= sum(8);
    -- Detect overflow
    o_result <= sum(7 downto 0);
    
end architecture Behavioral;
