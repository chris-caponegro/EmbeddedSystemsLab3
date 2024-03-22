library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div is
    port(
        clk  : in std_logic;        -- 125 Mhz clock
        div : out std_logic);
end clock_div;

architecture behavior of clock_div is

    signal counter : std_logic_vector(26 downto 0) := (others => '0');

begin

    process(clk)
    begin
    
        if rising_edge(clk) then
            
                -- count one full led period (115,200 Hz)
                if (unsigned(counter) < 1084) then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                    div <= '0';
                else
                    counter <= (others => '0');
                    div <= '1';
                end if;
                
        end if;
    
    end process;
    
end behavior;