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

entity regA is
    port(
        i_clk: in std_logic;
        i_S0: in std_logic_vector(7 downto 0);
        o_S0_next: out std_logic_vector(7 downto 0)
        );
end regA;

architecture Behavioral of regA is

begin
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            o_S0_next <= i_S0;
        end if;
    end process;
    
end Behavioral;
