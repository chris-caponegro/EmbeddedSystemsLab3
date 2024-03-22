

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sender is
  Port ( 
        rst, clk, clk_en, btn, ready : in std_logic; 
        send : out STD_LOGIC;
        char_out : out STD_LOGIC_VECTOR(7 downto 0)

  );
end sender;

architecture fsm of sender is

type str is array (0 to 5) of std_logic_vector(7 downto 0);
signal netID : str := (x"63", x"61", x"63", x"35", x"39", x"35");
                                                     
type state_type is (idle, busyA, busyB, busyC);
signal curr : state_type := idle;
signal i : integer range 0 to 6 := 0; -- Number of characters in the NETID
    
begin

    process(clk)
    begin
      if(rising_edge(clk)) then 
            
            if (clk_en = '1') then
            
            if (rst = '1') then
                char_out <= (others => '0');
                i <= 0;
                send <= '0';
                curr <= idle;
         
            end if;
            
                case curr is
                
                when idle =>
                
                    if (ready = '1' and btn = '1' and i < 6) then
                        send <= '1';
                        char_out <= netID(i);
                        i <= i + 1;
                        curr <= busyA;
                        
                    elsif (ready = '1' and btn = '1' and i = 6) then
                        i <= 0;
                        curr <= idle;
                        
                    
                   end if;
                when busyA =>
                    curr <= busyB;
                    
                when busyB =>
                    send <= '0';
                    curr <= busyC;
                    
                when busyC =>
                    if (ready = '1' and btn = '0') then
                        curr <= idle;
                    end if;
                when others =>
                    curr <= idle;
                end case;             

            end if;
      
  
      
      
      end if;
      
   
             
    end process;



end fsm;
