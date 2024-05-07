----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 08:40:28 PM
-- Design Name: 
-- Module Name: FOURMUX - Behavioral
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

entity FOURMUX is
    port(
        i_sel4: in std_logic_vector(1 downto 0);
        i_D3: in std_logic_vector(7 downto 0);
        i_D2: in std_logic_vector(7 downto 0);
        i_D1: in std_logic_vector(7 downto 0);
        i_D0: in std_logic_vector(7 downto 0);
        o_result: out std_logic_vector(7 downto 0)
    );
end FOURMUX;

architecture Behavioral of FOURMUX is
    

begin
    
    with i_sel4 select
	o_result <= i_D0 when "00",
                i_D1 when "01",
                i_D2 when "10",
                i_D3 when others;


end Behavioral;
