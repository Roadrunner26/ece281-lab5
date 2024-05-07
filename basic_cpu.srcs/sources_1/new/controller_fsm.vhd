----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 09:36:51 PM
-- Design Name: 
-- Module Name: controller_fsm - Behavioral
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

entity controller_fsm is
    port(
        i_reset : in std_logic;
        i_adv : in std_logic;
        o_cycle : out std_logic_vector(3 downto 0)
    );
end controller_fsm;

architecture Behavioral of controller_fsm is
    signal f_Q, f_Q_next: std_logic_vector(1 downto 0) := "11";
begin
    
    f_Q_next <= "01" when f_Q = "00" else
                    "10" when f_Q = "01" else
                    "11" when f_Q = "10" else
                    "00";
    
    o_cycle <= "1000" when f_Q = "00" else
            "0100" when f_Q = "01" else
            "0010" when f_Q = "10" else
            "0001" when f_Q = "11";
            
    register_proc : process (i_reset, i_adv)
    begin
        if i_reset = '1' then
            f_Q <= "11";
        elsif rising_edge(i_adv) then
            f_Q <= f_Q_next;
        end if;
    end process register_proc;    
    
    
    
    


end Behavioral;
