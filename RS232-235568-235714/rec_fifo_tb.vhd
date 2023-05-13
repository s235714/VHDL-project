LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY rec_fifo_tb IS
END rec_fifo_tb;
 
ARCHITECTURE behavior OF rec_fifo_tb IS 
 
   -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rec_fifo
    PORT(
         DI : IN  std_logic;
         Zegar : IN  std_logic;
         --Rdy : OUT  std_logic;
         FIFO_EMPTY : OUT  std_logic;
         FIFO_FULL : OUT  std_logic;
         FIFO_POP : IN  std_logic;
         FIFO_DO : OUT  std_logic_vector(7 downto 0);
         Reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DI : std_logic := '0';
   signal Zegar : std_logic := '0';
   signal FIFO_POP : std_logic := '0';
   signal Reset : std_logic := '0';

   --Outputs
   --signal Rdy : std_logic;
   signal FIFO_EMPTY : std_logic;
   signal FIFO_FULL : std_logic;
   signal FIFO_DO : std_logic_vector(7 downto 0);

   constant CLK_PERIOD : time := 20 ns;
   constant SIM_TIME : time := 400 us;
   constant CLK_CYCLES : positive := SIM_TIME / CLK_PERIOD;

--------------------------------------------------------------------------------
-- Simulate received byte: RX_BYTE - received byte, RX_LINE - receiver line
--------------------------------------------------------------------------------

procedure sim_rx_byte ( RX_BYTE : in std_logic_vector;
                        signal RX_LINE : out std_logic ) is
  begin

    RX_LINE <= '0';             -- START bit
    wait for 8680 ns;

    for i in RX_BYTE'reverse_range loop
      RX_LINE <= RX_BYTE(i);
      wait for 8680 ns;      -- DATA bit i = 0 .. 7
    end loop;

    RX_LINE <= '1';
    wait for 8680 ns;        -- STOP bit

  end procedure sim_rx_byte;
--------------------------------------------------------------------------------

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rec_fifo PORT MAP (
          DI => DI,
          Zegar => Zegar,
          --Rdy => Rdy,
          FIFO_EMPTY => FIFO_EMPTY,
          FIFO_FULL => FIFO_FULL,
          FIFO_POP => FIFO_POP,
          FIFO_DO => FIFO_DO,
          Reset => Reset
        );

-- Clock process definitions
--------------------------------------------------------------------------------

tb_clk : process
  begin
    for i in 1 to CLK_CYCLES loop 
      Zegar <= '0';
      wait for CLK_PERIOD / 2;     
      Zegar <= '1';
      wait for CLK_PERIOD / 2;     
     end loop;
     WAIT;
  end process;

------------------------------------------
   tb_main : PROCESS
   BEGIN
    DI <= '1';
    FIFO_POP <= '0';

    Reset <= '1';
    wait for 100 ns;
    Reset <= '0';

    sim_rx_byte(x"30", DI);  -- '0'     30h
    sim_rx_byte(x"41", DI);  -- 'A'     41h

    wait for 3 * CLK_PERIOD;

    FIFO_POP <= '1';
    wait for CLK_PERIOD;
    FIFO_POP <= '0';

--------------------------------------------------------------
--  Tutaj wystarczylby CLK_PERIOD, dajemy wiecej zeby lepiej
--  zobaczyc jak pobierany jest z kolejki drugi odebrany bajt
--------------------------------------------------------------
    wait for 400 * CLK_PERIOD;

    FIFO_POP <= '1';
    wait for CLK_PERIOD;
    FIFO_POP <= '0';	
		
      wait;
   end process;

END;
