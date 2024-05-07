----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 09:22:04 PM
-- Design Name: 
-- Module Name: shifter - Behavioral
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

entity shifter is
port(
    i_A: in std_logic_vector(7 downto 0);
    i_B: in std_logic_vector(7 downto 0);
    i_LorR: in std_logic;
    o_result: out std_logic_vector(7 downto 0)
);
end shifter;

architecture Behavioral of shifter is
begin
    process(i_A, i_B, i_LorR)
    begin
        if i_LorR = '1' then -- Left shift
            o_result <= i_A(6 downto 0) & '0';
        else -- Right shift
            o_result <= '0' & i_A(7 downto 1);
        end if;
    end process;
end architecture Behavioral;
