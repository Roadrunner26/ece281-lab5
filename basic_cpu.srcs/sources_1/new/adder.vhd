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
    signal r_add1, r_add2 : signed(8 downto 0);
    signal r_Cin : signed(8 downto 0) := "000000000";
begin
    -- Convert inputs to signed for arithmetic operations
    r_add1 <= resize(signed(i_A), 9);
    r_add2 <= resize(signed(i_B), 9);
    r_Cin(0) <= i_Cin;
            
   sum <= std_logic_vector(r_add1 + r_add2 + r_Cin);
           
          
    -- Output carry
    o_Cout <= sum(8);
    -- Detect overflow
    o_result <= sum(7 downto 0);
    
end architecture Behavioral;
