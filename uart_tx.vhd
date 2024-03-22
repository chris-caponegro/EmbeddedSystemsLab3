library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
  Port (
    clk, en, send, rst : in std_logic;
    char : in std_logic_vector(7 downto 0);
    ready, tx : out std_logic
   );
end uart_tx;

architecture fsm of uart_tx is

    type state is (idle, start, data);
    signal curr : state := idle;

    -- shift register to read data in
    signal d : std_logic_vector (7 downto 0) := (others => '0');

    -- counter for data state
    signal count : integer range 0 to 8 := 0;

 

begin
    process(clk)
    begin
    
    if(rising_edge(clk)) then
        if (rst = '1') then
                tx <= '1';
                ready <= '1';
                count <= 0;
                d <= (others => '0');
                curr <= idle;
         
        end if;
        
        if (en = '1') then
           
            case curr is 
            
            when idle =>
                tx <= '1';
                ready <= '1';
                count <= 0;
            
                if (send = '1') then
                    d <= char;
                    curr <= start;
                end if;
            
            when start => 
                tx <= '0';
                ready <= '0';
                curr <= data;
            
            
            when data =>
                if (count > 7) then
                    ready <= '1';
                    count <= 0;
                    tx <= '1';
                    curr <= idle;
                else
                    tx <= d(count);
                    count <= count + 1;
                end if;
            
             
            when others =>
                curr <= idle;
            end case;
        
        end if; -- en = 1
    end if; --rising edge
    end process; 



end fsm;