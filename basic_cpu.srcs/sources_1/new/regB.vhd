----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 09:01:01 PM
-- Design Name: 
-- Module Name: regA - Behavioral
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

entity regB is
    port(
        i_clk: in std_logic;
        i_S1: in std_logic_vector(7 downto 0);
        o_S1_next: out std_logic_vector(7 downto 0)
        );
end regB;

architecture Behavioral of regB is

begin
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            o_S1_next <= i_S1;
        end if;
    end process;
    
end Behavioral;
