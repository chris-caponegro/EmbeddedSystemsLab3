library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_design is
  Port ( signal TXD, clk : in std_logic;
           signal btn : in std_logic_vector(1 downto 0);
           signal CTS, RXD, RTS : out std_logic);
end top_design;

architecture Behavioral of top_design is

component debounce is
port ( clk : in std_logic;
       btn : in std_logic;
       dbnc : out std_logic);
end component;


component clock_div is
port ( clk : in std_logic;
       div : out std_logic);
end component;

component sender is
port( rst, clk, clk_en, btn, ready : in std_logic; 
      send : out STD_LOGIC;
      char_out : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component uart is
port( clk, en, send, rx, rst      : in std_logic;
      charSend                    : in std_logic_vector (7 downto 0);
      ready, tx, newChar          : out std_logic;
      charRec                     : out std_logic_vector (7 downto 0));
 end component;

signal dbnc_out0 : std_logic;
signal dbnc_out1 : std_logic;

signal clk_div : std_logic;
signal char_out : std_logic_vector(7 downto 0);
signal send_out : std_logic;
signal rdy : std_logic;

begin

u1 : debounce port map(
    clk => clk,
    btn => btn(0),
    dbnc => dbnc_out0
    );
 
u2 : debounce port map(
    clk => clk,
    btn => btn(1),
    dbnc => dbnc_out1
    );

u3 : clock_div port map(
    clk => clk,
    div => clk_div
    );
    
u4 : sender port map(
    btn => dbnc_out1,
    clk => clk,
    clk_en => clk_div,
    ready => rdy,
    rst => dbnc_out0,
    
    char_out => char_out,
    send => send_out
    );
    
u5 : uart port map(
    charSend => char_out,
    clk => clk,
    en => clk_div,
    rst => dbnc_out0,
    rx => TXD,
    send => send_out,
    
    ready => rdy,
    tx => RXD
    );

RTS <= '0';
CTS <= '0';
end Behavioral;
