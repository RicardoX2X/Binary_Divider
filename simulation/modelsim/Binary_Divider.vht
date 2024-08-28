-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "08/27/2024 21:00:32"
                                                            
-- Vhdl Test Bench template for design  :  Binary_Divider
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Binary_Divider_vhd_tst IS
END Binary_Divider_vhd_tst;
ARCHITECTURE Binary_Divider_arch OF Binary_Divider_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL Erro : STD_LOGIC;
SIGNAL HEX0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL KEY : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL SW : STD_LOGIC_VECTOR(9 DOWNTO 0);
COMPONENT Binary_Divider
	PORT (
	Erro : BUFFER STD_LOGIC;
	HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Binary_Divider
	PORT MAP (
-- list connections between master ports and signals
	Erro => Erro,
	HEX0 => HEX0,
	HEX1 => HEX1,
	HEX2 => HEX2,
	HEX3 => HEX3,
	HEX4 => HEX4,
	HEX5 => HEX5,
	KEY => KEY,
	SW => SW
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        KEY(1) <= '1';
        -- Primeira simulação
        SW <= "1011000011"; -- Dividendo = 11 -- Divisor = 3
        WAIT FOR 200 ns;

        -- Segunda simulação
        SW <= "1111000010"; -- Dividendo = 15 -- Divisor = 2
        WAIT FOR 200 ns;

        -- Terceira simulação
        SW <= "1101000101"; -- Dividendo = 13 -- Divisor = 5
        WAIT FOR 200 ns;
		  
		  -- Terceira simulação
        SW <= "0101001101"; -- Dividendo = 5 -- Divisor = 13
        WAIT FOR 200 ns;

        -- Simulação de divisão por zero
        SW <= "1001000000"; -- Dividendo = 9 -- Divisor = 0
        WAIT FOR 200 ns;
		  
		  -- Simulação de divisão por zero
        SW <= "0000000000"; -- Dividendo = 0 -- Divisor = 0
        WAIT FOR 200 ns;
		  
		  -- Simulação de divisão por zero
        SW <= "1001001001"; -- Dividendo = 9 -- Divisor = 9
        WAIT FOR 200 ns;
		  
		  -- Simulação de divisão por zero
        SW <= "0000001001"; -- Dividendo = 0 -- Divisor = 9
        WAIT FOR 200 ns;                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END Binary_Divider_arch;
