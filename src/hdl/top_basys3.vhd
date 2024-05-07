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
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;


entity top_basys3 is
    port(
    clk : in std_logic;
    btnU: in std_logic;
    btnC : in std_logic;
    sw : in std_logic_vector(7 downto 0);
    led : out std_logic_vector(15 downto 0);
    an : out std_logic_vector(3 downto 0);
    seg : out std_logic_vector(6 downto 0)
    );
end top_basys3;

architecture top_basys3_arch of top_basys3 is 
  
	-- declare components and signals
	signal w_clk_TDM, w_sign: std_logic;
	signal w_regA, w_regB, w_result, w_sel: std_logic_vector(7 downto 0);
	signal w_clk, w_hund, w_tens, w_ones, w_data: std_logic_vector(3 downto 0);
	
	component sevenSegDecoder is
        port(
            i_D : in std_logic_vector(3 downto 0);
            o_S : out std_logic_vector(6 downto 0)
        );
    end component sevenSegDecoder;
    
    component clock_divider is
        generic ( constant k_DIV : natural := 2);
        port(
            i_clk : in std_logic;
            i_reset: in std_logic;
            o_clk : out std_logic
            );
    end component clock_divider;
    
    component TDM4 is
        generic ( constant k_WIDTH : natural  := 4); -- bits in input and output
        Port ( i_clk        : in  STD_LOGIC;
               i_reset        : in  STD_LOGIC; -- synchronous
               i_D3         : in  STD_LOGIC;
               i_D2         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               i_D1         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               i_D0         : in  STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               o_data        : out STD_LOGIC_VECTOR (k_WIDTH - 1 downto 0);
               o_sel        : out STD_LOGIC_VECTOR (3 downto 0)    -- selected data line (one-cold)
        );
    end component TDM4;
    
    component controller_fsm is
        port(
            i_reset : in std_logic;
            i_adv : in std_logic;
            o_cycle : out std_logic_vector(3 downto 0)
        );
    end component controller_fsm;
    
    component ALU is
        port(
            i_A : in std_logic_vector(7 downto 0);
            i_B : in std_logic_vector(7 downto 0);
            i_op : in std_logic_vector(2 downto 0);
            o_flags : out std_logic_vector(2 downto 0);
            o_result : out std_logic_vector(7 downto 0)         
        );
    end component ALU;
    
    component regA is
        port(
            i_clk : in std_logic;
            i_S0 : in std_logic_vector(7 downto 0);
            o_S0_next : out std_logic_vector(7 downto 0)
        );
    end component regA;
    
    component regB is
        port(
            i_clk : in std_logic;
            i_S1 : in std_logic_vector(7 downto 0);
            o_S1_next : out std_logic_vector(7 downto 0)
        );
    end component regB;
    
    component twoscomp_decimal is
        port(
            i_binary: in std_logic_vector(7 downto 0);
            o_negative: out std_logic;
            o_hundreds: out std_logic_vector(3 downto 0);
            o_tens: out std_logic_vector(3 downto 0);
            o_ones: out std_logic_vector(3 downto 0)
        );
    end component twoscomp_decimal;
    
    component MUX is
        port(
            i_D0 : in std_logic_vector(7 downto 0);
            i_D1 : in std_logic_vector(7 downto 0);
            i_D2 : in std_logic_vector(7 downto 0);
            i_D3 : in std_logic_vector(7 downto 0);
            i_sel: in std_logic_vector(3 downto 0);
            o_result : out std_logic_vector(7 downto 0)
            
        );
    end component MUX;
    
  
begin

    clock_divider_inst: clock_divider
    generic map( k_DIV => 2500)
    port map(
        i_clk => clk,
        i_reset => btnU,
        o_clk => w_clk_TDM
    );
    
	-- PORT MAPS ----------------------------------------
	sevenSegDecoder_inst: sevenSegDecoder
    port map(
        i_D => w_data,
        o_S => seg
    );
    TDM4_inst: TDM4
    port map(
        i_clk => w_clk_TDM,
        i_reset => btnU,
        i_D3 => w_sign,
        i_D2 => w_hund,
        i_D1 => w_tens,
        i_D0 => w_ones,
        o_data => w_data,
        o_sel => an
    );
    ALU_inst: ALU
    port map(
        i_op => sw(2 downto 0),
        i_A => w_regA,
        i_B => w_regB,
        o_flags => led(15 downto 13),
        o_result => w_result
    );
    regA_inst: regA
    port map(
        i_S0 => sw(7 downto 0),
        i_clk => w_clk(3),
        o_s0_next => w_regA
    );
    regB_inst: regB
    port map(
        i_S1 => sw(7 downto 0),
        i_clk => w_clk(2),
        o_s1_next => w_regB
    );
    controller_fsm_inst: controller_fsm
    port map(
        i_reset => btnU,
        i_adv => btnC,
        o_cycle => w_clk
    );
    MUX_inst: MUX
    port map(
        i_D0 => w_regA,
        i_D1 => w_regB,
        i_D2 => w_result,
        i_D3 => "11111111",
        i_sel => w_clk,
        o_result => w_sel
    );
    twoscomp_decimal_inst: twoscomp_decimal
    port map(
        i_binary => w_sel,
        o_negative => w_sign,
        o_hundreds => w_hund,
        o_tens => w_tens,
        o_ones => w_ones
    );
    
    
    
	-- CONCURRENT STATEMENTS ----------------------------
	led(3 downto 0) <= w_clk;
	led(12 downto 4) <= "000000000";
	
	
end top_basys3_arch;
