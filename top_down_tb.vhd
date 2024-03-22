library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_design_tb is
end top_design_tb;

architecture tb of top_design_tb is

component top_design is 
port( TXD,clk : in std_logic;
      btn : in std_logic_vector(1 downto 0);
      RXD : out std_logic;
      CTS,RTS : out std_logic
      );
end component;
      
signal clk : std_logic := '0';
signal btn : std_logic_vector(1 downto 0) := (others => '0');
signal RXD : std_logic;
signal TXD : std_logic;

begin

dut : top_design port map(
clk => clk,
TXD => TXD,
btn => btn,
RXD => RXD); 

-- clock process @125 MHz
process begin
clk <= '0';
wait for 4 ns;
clk <= '1';
wait for 4 ns;
end process ;

process begin
btn(1) <= '1';
wait for 50 ms;
btn(1) <= '0';
wait for 50 ms;

end process;



end tb;
