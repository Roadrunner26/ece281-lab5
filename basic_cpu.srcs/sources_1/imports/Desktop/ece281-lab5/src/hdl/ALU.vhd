--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
--|
--| ALU OPCODES:
--|
--|     ADD     000
--|
--|
--|
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity ALU is
    port(
        i_A : in std_logic_vector(7 downto 0);
        i_B : in std_logic_vector(7 downto 0);
        i_op : in std_logic_vector(2 downto 0);
        o_flags : out std_logic_vector(2 downto 0);
        o_result : out std_logic_vector(7 downto 0)         
    );
end ALU;

architecture behavioral of ALU is 
    
    signal w_zero, w_neg, w_carry, w_Cout: std_logic;
    signal w_math_result, w_and, w_or, w_subtract, w_math, w_result, w_shift: std_logic_vector(7 downto 0);
    signal w_flags: std_logic_vector(2 downto 0);
    signal w_ismath: std_logic_vector(1 downto 0);
  
	-- declare components and signals
    component shifter is
        port(
            i_A: in std_logic_vector(7 downto 0);
            i_B: in std_logic_vector(2 downto 0);
            i_LorR: in std_logic;
            o_result: out std_logic_vector(7 downto 0)
        );
    end component shifter;
    
    component FOURMUX is
        port(
            i_sel4: in std_logic_vector(1 downto 0);
            i_D3: in std_logic_vector(7 downto 0);
            i_D2: in std_logic_vector(7 downto 0);
            i_D1: in std_logic_vector(7 downto 0);
            i_D0: in std_logic_vector(7 downto 0);
            o_result: out std_logic_vector(7 downto 0)
        );
    end component FOURMUX;
    
    component TWOMUX is
        port(
            i_sel2: in std_logic;
            i_D1: in std_logic_vector(7 downto 0);
            i_D0: in std_logic_vector(7 downto 0);
            o_result: out std_logic_vector(7 downto 0)
        );
    end component TWOMUX;
    
    component adder is
        port(
            i_Cin: in std_logic;
            i_A: in std_logic_vector(7 downto 0);
            i_B: in std_logic_vector(7 downto 0);
            o_Cout: out std_logic;
            o_result: out std_logic_vector(7 downto 0)
        );
    end component adder;
    
    
    

	

  
begin
	-- PORT MAPS ----------------------------------------
	
    FOURMUX_inst: FOURMUX
    port map(
        i_sel4(1) => i_op(1),
        i_sel4(0) => i_op(0),
        i_D0 => w_and,
        i_D1 => w_or,
        i_D2 => w_shift,
        i_D3 => w_math_result,
        o_result => w_result
    );
    shifter_inst: shifter
    port map(
        i_A => i_A,
        i_B => i_B(2 downto 0),
        i_LorR => i_op(2),
        o_result => w_shift
    );
    TWOMUX_inst: TWOMUX
    port map(
        i_sel2 => i_op(2),
        i_D1 => i_B,
        i_D0 => w_subtract,
        o_result => w_math
    );
    adder_inst: adder
    port map(
        i_Cin => i_op(2),
        i_A => i_A,
        i_B => w_math,
        o_Cout => w_Cout,
        o_result => w_math_result
    );
    
    w_carry <= (i_A(7) xor w_result(7)) or (i_B(7) xor w_result(7));
    w_flags(0) <= w_carry;
    w_flags(1) <= w_zero;
    w_flags(2) <= w_neg;
    
    o_flags <= w_flags;
    o_result <= w_result;
    w_zero <= (not w_result(6)) and (not w_result(5)) and (not w_result(4)) and
              (not w_result(3)) and (not w_result(2)) and (not w_result(1)) and 
              (not w_result(0));
    w_neg <= w_result(7);
    w_subtract <= not i_B;
    w_and <= i_A and i_B;
    w_or <= i_A or i_B;
    
    
    
        
    
        
    
   
	

	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	
	
end behavioral;
