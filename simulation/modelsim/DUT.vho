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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "11/30/2022 15:43:41"

-- 
-- Device: Altera 5M1270ZT144C5 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXV;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXV.MAXV_COMPONENTS.ALL;

ENTITY 	alu IS
    PORT (
	opr1 : IN std_logic_vector(15 DOWNTO 0);
	opr2 : IN std_logic_vector(15 DOWNTO 0);
	dest : IN std_logic_vector(15 DOWNTO 0);
	output : OUT std_logic_vector(15 DOWNTO 0);
	opcode : IN std_logic_vector(5 DOWNTO 0);
	cin : IN std_logic;
	zin : IN std_logic;
	enable : IN std_logic;
	reset : IN std_logic;
	C : OUT std_logic;
	Z : OUT std_logic
	);
END alu;

-- Design Ports Information


ARCHITECTURE structure OF alu IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_opr1 : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_opr2 : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_dest : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_output : std_logic_vector(15 DOWNTO 0);
SIGNAL ww_opcode : std_logic_vector(5 DOWNTO 0);
SIGNAL ww_cin : std_logic;
SIGNAL ww_zin : std_logic;
SIGNAL ww_enable : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_C : std_logic;
SIGNAL ww_Z : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \zin~combout\ : std_logic;
SIGNAL \cin~combout\ : std_logic;
SIGNAL \output[0]~0_combout\ : std_logic;
SIGNAL \output[0]~2_combout\ : std_logic;
SIGNAL \output[0]~1_combout\ : std_logic;
SIGNAL \output[0]~52_combout\ : std_logic;
SIGNAL \output[0]~53_combout\ : std_logic;
SIGNAL \reset~combout\ : std_logic;
SIGNAL \enable~combout\ : std_logic;
SIGNAL \output[15]~3_combout\ : std_logic;
SIGNAL \output[15]~4_combout\ : std_logic;
SIGNAL \output[15]~5_combout\ : std_logic;
SIGNAL \output[0]$latch~combout\ : std_logic;
SIGNAL \output~6_combout\ : std_logic;
SIGNAL \output[1]~7_combout\ : std_logic;
SIGNAL \output[1]~50_combout\ : std_logic;
SIGNAL \output[1]~51_combout\ : std_logic;
SIGNAL \output[1]$latch~combout\ : std_logic;
SIGNAL \carry~0_combout\ : std_logic;
SIGNAL \add_temp[2]~0_combout\ : std_logic;
SIGNAL \output~8_combout\ : std_logic;
SIGNAL \adl_temp[2]~0_combout\ : std_logic;
SIGNAL \output[2]~9_combout\ : std_logic;
SIGNAL \output[2]~10_combout\ : std_logic;
SIGNAL \output[2]$latch~combout\ : std_logic;
SIGNAL \output~11_combout\ : std_logic;
SIGNAL \output[3]~12_combout\ : std_logic;
SIGNAL \carry~2_combout\ : std_logic;
SIGNAL \carry~1_combout\ : std_logic;
SIGNAL \carryL~0_combout\ : std_logic;
SIGNAL \adl_temp[3]~1_combout\ : std_logic;
SIGNAL \output[3]~13_combout\ : std_logic;
SIGNAL \output[3]$latch~combout\ : std_logic;
SIGNAL \carryL~1_combout\ : std_logic;
SIGNAL \carryL~2_combout\ : std_logic;
SIGNAL \output~14_combout\ : std_logic;
SIGNAL \output[4]~15_combout\ : std_logic;
SIGNAL \carry~3_combout\ : std_logic;
SIGNAL \add_temp[4]~1_combout\ : std_logic;
SIGNAL \output[4]~16_combout\ : std_logic;
SIGNAL \output[4]$latch~combout\ : std_logic;
SIGNAL \carryL~3_combout\ : std_logic;
SIGNAL \adl_temp[5]~2_combout\ : std_logic;
SIGNAL \carry~5_combout\ : std_logic;
SIGNAL \carry~4_combout\ : std_logic;
SIGNAL \output~17_combout\ : std_logic;
SIGNAL \output[5]~18_combout\ : std_logic;
SIGNAL \output[5]~19_combout\ : std_logic;
SIGNAL \output[5]$latch~combout\ : std_logic;
SIGNAL \carry~6_combout\ : std_logic;
SIGNAL \add_temp[6]~2_combout\ : std_logic;
SIGNAL \carryL~5_combout\ : std_logic;
SIGNAL \carryL~4_combout\ : std_logic;
SIGNAL \output~20_combout\ : std_logic;
SIGNAL \output[6]~21_combout\ : std_logic;
SIGNAL \output[6]~22_combout\ : std_logic;
SIGNAL \output[6]$latch~combout\ : std_logic;
SIGNAL \carry~8_combout\ : std_logic;
SIGNAL \carry~7_combout\ : std_logic;
SIGNAL \output~23_combout\ : std_logic;
SIGNAL \output[7]~24_combout\ : std_logic;
SIGNAL \carryL~6_combout\ : std_logic;
SIGNAL \adl_temp[7]~3_combout\ : std_logic;
SIGNAL \output[7]~25_combout\ : std_logic;
SIGNAL \output[7]$latch~combout\ : std_logic;
SIGNAL \output~26_combout\ : std_logic;
SIGNAL \carryL~7_combout\ : std_logic;
SIGNAL \carryL~8_combout\ : std_logic;
SIGNAL \output[8]~27_combout\ : std_logic;
SIGNAL \carry~9_combout\ : std_logic;
SIGNAL \add_temp[8]~3_combout\ : std_logic;
SIGNAL \output[8]~28_combout\ : std_logic;
SIGNAL \output[8]$latch~combout\ : std_logic;
SIGNAL \carry~11_combout\ : std_logic;
SIGNAL \carry~10_combout\ : std_logic;
SIGNAL \carryL~9_combout\ : std_logic;
SIGNAL \adl_temp[9]~4_combout\ : std_logic;
SIGNAL \output~29_combout\ : std_logic;
SIGNAL \output[9]~30_combout\ : std_logic;
SIGNAL \output[9]~31_combout\ : std_logic;
SIGNAL \output[9]$latch~combout\ : std_logic;
SIGNAL \carry~12_combout\ : std_logic;
SIGNAL \add_temp[10]~4_combout\ : std_logic;
SIGNAL \carryL~10_combout\ : std_logic;
SIGNAL \carryL~11_combout\ : std_logic;
SIGNAL \output~32_combout\ : std_logic;
SIGNAL \output[10]~33_combout\ : std_logic;
SIGNAL \output[10]~34_combout\ : std_logic;
SIGNAL \output[10]$latch~combout\ : std_logic;
SIGNAL \carryL~12_combout\ : std_logic;
SIGNAL \adl_temp[11]~5_combout\ : std_logic;
SIGNAL \carry~13_combout\ : std_logic;
SIGNAL \carry~14_combout\ : std_logic;
SIGNAL \output~35_combout\ : std_logic;
SIGNAL \output[11]~36_combout\ : std_logic;
SIGNAL \output[11]~37_combout\ : std_logic;
SIGNAL \output[11]$latch~combout\ : std_logic;
SIGNAL \carry~15_combout\ : std_logic;
SIGNAL \add_temp[12]~5_combout\ : std_logic;
SIGNAL \carryL~13_combout\ : std_logic;
SIGNAL \carryL~14_combout\ : std_logic;
SIGNAL \output~38_combout\ : std_logic;
SIGNAL \output[12]~39_combout\ : std_logic;
SIGNAL \output[12]~40_combout\ : std_logic;
SIGNAL \output[12]$latch~combout\ : std_logic;
SIGNAL \carry~16_combout\ : std_logic;
SIGNAL \carry~17_combout\ : std_logic;
SIGNAL \carryL~15_combout\ : std_logic;
SIGNAL \adl_temp[13]~6_combout\ : std_logic;
SIGNAL \output~41_combout\ : std_logic;
SIGNAL \output[13]~42_combout\ : std_logic;
SIGNAL \output[13]~43_combout\ : std_logic;
SIGNAL \output[13]$latch~combout\ : std_logic;
SIGNAL \carry~18_combout\ : std_logic;
SIGNAL \add_temp[14]~6_combout\ : std_logic;
SIGNAL \output~44_combout\ : std_logic;
SIGNAL \carryL~17_combout\ : std_logic;
SIGNAL \carryL~16_combout\ : std_logic;
SIGNAL \output[14]~45_combout\ : std_logic;
SIGNAL \output[14]~46_combout\ : std_logic;
SIGNAL \output[14]$latch~combout\ : std_logic;
SIGNAL \output~47_combout\ : std_logic;
SIGNAL \output[15]~48_combout\ : std_logic;
SIGNAL \carryL~18_combout\ : std_logic;
SIGNAL \adl_temp[15]~7_combout\ : std_logic;
SIGNAL \carry~20_combout\ : std_logic;
SIGNAL \carry~19_combout\ : std_logic;
SIGNAL \output[15]~49_combout\ : std_logic;
SIGNAL \output[15]$latch~combout\ : std_logic;
SIGNAL \C~2_combout\ : std_logic;
SIGNAL \add_temp[16]~7_combout\ : std_logic;
SIGNAL \C~0_combout\ : std_logic;
SIGNAL \C~1_combout\ : std_logic;
SIGNAL \C~3_combout\ : std_logic;
SIGNAL \C~4_combout\ : std_logic;
SIGNAL \C~5_combout\ : std_logic;
SIGNAL \C$latch~combout\ : std_logic;
SIGNAL \Z~0_combout\ : std_logic;
SIGNAL \WideOr0~0_combout\ : std_logic;
SIGNAL \WideOr0~3_combout\ : std_logic;
SIGNAL \WideOr0~1_combout\ : std_logic;
SIGNAL \WideOr0~2_combout\ : std_logic;
SIGNAL \WideOr0~4_combout\ : std_logic;
SIGNAL \Z~1_combout\ : std_logic;
SIGNAL \Z$latch~combout\ : std_logic;
SIGNAL \dest~combout\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \opcode~combout\ : std_logic_vector(5 DOWNTO 0);
SIGNAL \opr2~combout\ : std_logic_vector(15 DOWNTO 0);
SIGNAL \opr1~combout\ : std_logic_vector(15 DOWNTO 0);
SIGNAL add_temp : std_logic_vector(16 DOWNTO 0);
SIGNAL adl_temp : std_logic_vector(16 DOWNTO 0);

BEGIN

ww_opr1 <= opr1;
ww_opr2 <= opr2;
ww_dest <= dest;
output <= ww_output;
ww_opcode <= opcode;
ww_cin <= cin;
ww_zin <= zin;
ww_enable <= enable;
ww_reset <= reset;
C <= ww_C;
Z <= ww_Z;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: PIN_62,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opcode[0]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opcode(0),
	combout => \opcode~combout\(0));

-- Location: PIN_66,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opcode[1]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opcode(1),
	combout => \opcode~combout\(1));

-- Location: PIN_73,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opcode[4]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opcode(4),
	combout => \opcode~combout\(4));

-- Location: PIN_76,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opcode[2]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opcode(2),
	combout => \opcode~combout\(2));

-- Location: PIN_74,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opcode[5]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opcode(5),
	combout => \opcode~combout\(5));

-- Location: PIN_79,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opcode[3]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opcode(3),
	combout => \opcode~combout\(3));

-- Location: LC_X12_Y3_N5
\Equal0~0\ : maxv_lcell
-- Equation(s):
-- \Equal0~0_combout\ = (!\opcode~combout\(4) & (\opcode~combout\(2) & (!\opcode~combout\(5) & !\opcode~combout\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0004",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opcode~combout\(4),
	datab => \opcode~combout\(2),
	datac => \opcode~combout\(5),
	datad => \opcode~combout\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Equal0~0_combout\);

-- Location: PIN_61,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\zin~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_zin,
	combout => \zin~combout\);

-- Location: PIN_81,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\cin~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_cin,
	combout => \cin~combout\);

-- Location: LC_X12_Y4_N4
\output[0]~0\ : maxv_lcell
-- Equation(s):
-- \output[0]~0_combout\ = (\opcode~combout\(0) & (!\zin~combout\)) # (!\opcode~combout\(0) & (((\opcode~combout\(1) & !\cin~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "505c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \zin~combout\,
	datab => \opcode~combout\(1),
	datac => \opcode~combout\(0),
	datad => \cin~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[0]~0_combout\);

-- Location: LC_X12_Y4_N5
\output[0]~2\ : maxv_lcell
-- Equation(s):
-- \output[0]~2_combout\ = (\Equal0~0_combout\ & ((\opcode~combout\(0) $ (!\opcode~combout\(1))) # (!\output[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "90f0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opcode~combout\(0),
	datab => \opcode~combout\(1),
	datac => \Equal0~0_combout\,
	datad => \output[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[0]~2_combout\);

-- Location: LC_X12_Y4_N2
\output[0]~1\ : maxv_lcell
-- Equation(s):
-- \output[0]~1_combout\ = (\Equal0~0_combout\ & (((!\opcode~combout\(1)) # (!\opcode~combout\(0))))) # (!\Equal0~0_combout\ & (\output[0]~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2eee",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~0_combout\,
	datab => \Equal0~0_combout\,
	datac => \opcode~combout\(0),
	datad => \opcode~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[0]~1_combout\);

-- Location: PIN_69,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[0]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(0),
	combout => \opr2~combout\(0));

-- Location: PIN_68,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[0]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(0),
	combout => \dest~combout\(0));

-- Location: LC_X13_Y5_N6
\output[0]~52\ : maxv_lcell
-- Equation(s):
-- \output[0]~52_combout\ = (\output[0]~2_combout\ & (((\opr2~combout\(0))) # (!\output[0]~1_combout\))) # (!\output[0]~2_combout\ & ((\output[0]~1_combout\ & ((\dest~combout\(0)))) # (!\output[0]~1_combout\ & (!\opr2~combout\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e7a3",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~2_combout\,
	datab => \output[0]~1_combout\,
	datac => \opr2~combout\(0),
	datad => \dest~combout\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[0]~52_combout\);

-- Location: PIN_70,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[0]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(0),
	combout => \opr1~combout\(0));

-- Location: LC_X13_Y5_N5
\output[0]~53\ : maxv_lcell
-- Equation(s):
-- \output[0]~53_combout\ = (\output[0]~1_combout\ & (\output[0]~52_combout\ $ (((\output[0]~2_combout\ & \opr1~combout\(0)))))) # (!\output[0]~1_combout\ & ((\opr1~combout\(0) & (\output[0]~52_combout\)) # (!\opr1~combout\(0) & ((!\output[0]~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "6a8b",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~52_combout\,
	datab => \output[0]~1_combout\,
	datac => \output[0]~2_combout\,
	datad => \opr1~combout\(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[0]~53_combout\);

-- Location: PIN_67,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\reset~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_reset,
	combout => \reset~combout\);

-- Location: PIN_80,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\enable~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_enable,
	combout => \enable~combout\);

-- Location: LC_X12_Y3_N8
\output[15]~3\ : maxv_lcell
-- Equation(s):
-- \output[15]~3_combout\ = (!\opcode~combout\(5) & (!\opcode~combout\(4) & ((!\opcode~combout\(0)) # (!\opcode~combout\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0015",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opcode~combout\(5),
	datab => \opcode~combout\(1),
	datac => \opcode~combout\(0),
	datad => \opcode~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[15]~3_combout\);

-- Location: LC_X12_Y3_N6
\output[15]~4\ : maxv_lcell
-- Equation(s):
-- \output[15]~4_combout\ = (\output[15]~3_combout\ & (((!\opcode~combout\(2) & \opcode~combout\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0a00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[15]~3_combout\,
	datac => \opcode~combout\(2),
	datad => \opcode~combout\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[15]~4_combout\);

-- Location: LC_X12_Y3_N7
\output[15]~5\ : maxv_lcell
-- Equation(s):
-- \output[15]~5_combout\ = (!\reset~combout\ & (\enable~combout\ & (\Equal0~0_combout\ $ (\output[15]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1040",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \reset~combout\,
	datab => \Equal0~0_combout\,
	datac => \enable~combout\,
	datad => \output[15]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[15]~5_combout\);

-- Location: LC_X11_Y5_N2
\output[0]$latch\ : maxv_lcell
-- Equation(s):
-- \output[0]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[0]~53_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[0]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aacc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~53_combout\,
	datab => \output[0]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[0]$latch~combout\);

-- Location: PIN_75,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[1]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(1),
	combout => \opr2~combout\(1));

-- Location: PIN_84,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[1]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(1),
	combout => \opr1~combout\(1));

-- Location: LC_X13_Y5_N4
\output~6\ : maxv_lcell
-- Equation(s):
-- \output~6_combout\ = (((\opr2~combout\(1) & \opr1~combout\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr2~combout\(1),
	datad => \opr1~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~6_combout\);

-- Location: PIN_72,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[1]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(1),
	combout => \dest~combout\(1));

-- Location: LC_X13_Y5_N8
\output[1]~7\ : maxv_lcell
-- Equation(s):
-- \output[1]~7_combout\ = (\output[0]~1_combout\ & (((\output[0]~2_combout\) # (\dest~combout\(1))))) # (!\output[0]~1_combout\ & (!\output~6_combout\ & (!\output[0]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cdc1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output~6_combout\,
	datab => \output[0]~1_combout\,
	datac => \output[0]~2_combout\,
	datad => \dest~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[1]~7_combout\);

-- Location: LC_X13_Y5_N7
\output[1]~50\ : maxv_lcell
-- Equation(s):
-- \output[1]~50_combout\ = \opr1~combout\(1) $ (((\opr2~combout\(0) & ((\opr1~combout\(0)) # (!\output[1]~7_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "2fd0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[1]~7_combout\,
	datab => \opr1~combout\(0),
	datac => \opr2~combout\(0),
	datad => \opr1~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[1]~50_combout\);

-- Location: LC_X13_Y5_N9
\output[1]~51\ : maxv_lcell
-- Equation(s):
-- \output[1]~51_combout\ = (\output[0]~2_combout\ & (\output[1]~50_combout\ $ (((\opr2~combout\(1) & \output[1]~7_combout\))))) # (!\output[0]~2_combout\ & (((\output[1]~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "7d88",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~2_combout\,
	datab => \output[1]~50_combout\,
	datac => \opr2~combout\(1),
	datad => \output[1]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[1]~51_combout\);

-- Location: LC_X11_Y5_N6
\output[1]$latch\ : maxv_lcell
-- Equation(s):
-- \output[1]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & ((\output[1]~51_combout\))) # (!GLOBAL(\output[15]~5_combout\) & (\output[1]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0aa",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[1]$latch~combout\,
	datac => \output[1]~51_combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[1]$latch~combout\);

-- Location: LC_X13_Y5_N3
\carry~0\ : maxv_lcell
-- Equation(s):
-- \carry~0_combout\ = (\opr2~combout\(1) & ((\opr1~combout\(1)) # ((\opr1~combout\(0) & \opr2~combout\(0))))) # (!\opr2~combout\(1) & (\opr1~combout\(0) & (\opr2~combout\(0) & \opr1~combout\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ea80",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(1),
	datab => \opr1~combout\(0),
	datac => \opr2~combout\(0),
	datad => \opr1~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~0_combout\);

-- Location: PIN_118,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[2]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(2),
	combout => \opr2~combout\(2));

-- Location: PIN_101,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[2]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(2),
	combout => \opr1~combout\(2));

-- Location: LC_X11_Y6_N4
\add_temp[2]~0\ : maxv_lcell
-- Equation(s):
-- \add_temp[2]~0_combout\ = \carry~0_combout\ $ (((\opr2~combout\(2) $ (\opr1~combout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~0_combout\,
	datac => \opr2~combout\(2),
	datad => \opr1~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[2]~0_combout\);

-- Location: LC_X11_Y6_N6
\output~8\ : maxv_lcell
-- Equation(s):
-- \output~8_combout\ = (((\opr2~combout\(2) & \opr1~combout\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr2~combout\(2),
	datad => \opr1~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~8_combout\);

-- Location: LC_X13_Y5_N2
\adl_temp[2]~0\ : maxv_lcell
-- Equation(s):
-- \adl_temp[2]~0_combout\ = \opr2~combout\(1) $ (\opr1~combout\(2) $ (((\opr1~combout\(1) & \opr2~combout\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "956a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(1),
	datab => \opr1~combout\(1),
	datac => \opr2~combout\(0),
	datad => \opr1~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[2]~0_combout\);

-- Location: LC_X11_Y6_N0
\output[2]~9\ : maxv_lcell
-- Equation(s):
-- \output[2]~9_combout\ = (\output[0]~2_combout\ & ((\output[0]~1_combout\) # ((\adl_temp[2]~0_combout\)))) # (!\output[0]~2_combout\ & (!\output[0]~1_combout\ & (!\output~8_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ab89",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~2_combout\,
	datab => \output[0]~1_combout\,
	datac => \output~8_combout\,
	datad => \adl_temp[2]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[2]~9_combout\);

-- Location: PIN_97,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[2]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(2),
	combout => \dest~combout\(2));

-- Location: LC_X11_Y6_N5
\output[2]~10\ : maxv_lcell
-- Equation(s):
-- \output[2]~10_combout\ = (\output[2]~9_combout\ & ((\add_temp[2]~0_combout\) # ((!\output[0]~1_combout\)))) # (!\output[2]~9_combout\ & (((\output[0]~1_combout\ & \dest~combout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "bc8c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \add_temp[2]~0_combout\,
	datab => \output[2]~9_combout\,
	datac => \output[0]~1_combout\,
	datad => \dest~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[2]~10_combout\);

-- Location: LC_X11_Y5_N5
\output[2]$latch\ : maxv_lcell
-- Equation(s):
-- \output[2]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[2]~10_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[2]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[2]~10_combout\,
	datac => \output[2]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[2]$latch~combout\);

-- Location: PIN_117,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[3]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(3),
	combout => \opr2~combout\(3));

-- Location: PIN_107,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[3]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(3),
	combout => \opr1~combout\(3));

-- Location: LC_X11_Y7_N2
\output~11\ : maxv_lcell
-- Equation(s):
-- \output~11_combout\ = ((\opr2~combout\(3) & (\opr1~combout\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr2~combout\(3),
	datac => \opr1~combout\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~11_combout\);

-- Location: PIN_121,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[3]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(3),
	combout => \dest~combout\(3));

-- Location: LC_X10_Y7_N4
\output[3]~12\ : maxv_lcell
-- Equation(s):
-- \output[3]~12_combout\ = (\output[0]~1_combout\ & (((\dest~combout\(3)) # (\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & (!\output~11_combout\ & ((!\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aab1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => \output~11_combout\,
	datac => \dest~combout\(3),
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[3]~12_combout\);

-- Location: LC_X11_Y6_N8
\carry~2\ : maxv_lcell
-- Equation(s):
-- \carry~2_combout\ = ((\opr2~combout\(2) & ((\carry~0_combout\) # (\opr1~combout\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~0_combout\,
	datac => \opr2~combout\(2),
	datad => \opr1~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~2_combout\);

-- Location: LC_X11_Y7_N3
\carry~1\ : maxv_lcell
-- Equation(s):
-- \carry~1_combout\ = (((\carry~0_combout\ & \opr1~combout\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \carry~0_combout\,
	datad => \opr1~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~1_combout\);

-- Location: LC_X11_Y7_N8
\add_temp[3]\ : maxv_lcell
-- Equation(s):
-- add_temp(3) = \opr1~combout\(3) $ (\opr2~combout\(3) $ (((\carry~2_combout\) # (\carry~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "9996",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(3),
	datab => \opr2~combout\(3),
	datac => \carry~2_combout\,
	datad => \carry~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(3));

-- Location: LC_X13_Y5_N1
\carryL~0\ : maxv_lcell
-- Equation(s):
-- \carryL~0_combout\ = (\opr2~combout\(1) & ((\opr1~combout\(2)) # ((\opr1~combout\(1) & \opr2~combout\(0))))) # (!\opr2~combout\(1) & (\opr1~combout\(1) & (\opr2~combout\(0) & \opr1~combout\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ea80",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(1),
	datab => \opr1~combout\(1),
	datac => \opr2~combout\(0),
	datad => \opr1~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~0_combout\);

-- Location: LC_X11_Y7_N9
\adl_temp[3]~1\ : maxv_lcell
-- Equation(s):
-- \adl_temp[3]~1_combout\ = \opr1~combout\(3) $ (\carryL~0_combout\ $ ((\opr2~combout\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "9696",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(3),
	datab => \carryL~0_combout\,
	datac => \opr2~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[3]~1_combout\);

-- Location: LC_X10_Y7_N9
\output[3]~13\ : maxv_lcell
-- Equation(s):
-- \output[3]~13_combout\ = (\output[3]~12_combout\ & ((add_temp(3)) # ((!\output[0]~2_combout\)))) # (!\output[3]~12_combout\ & (((\adl_temp[3]~1_combout\ & \output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "d8aa",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[3]~12_combout\,
	datab => add_temp(3),
	datac => \adl_temp[3]~1_combout\,
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[3]~13_combout\);

-- Location: LC_X9_Y5_N5
\output[3]$latch\ : maxv_lcell
-- Equation(s):
-- \output[3]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[3]~13_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[3]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[3]~13_combout\,
	datac => \output[3]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[3]$latch~combout\);

-- Location: LC_X11_Y7_N6
\carryL~1\ : maxv_lcell
-- Equation(s):
-- \carryL~1_combout\ = ((\carryL~0_combout\ & (\opr1~combout\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \carryL~0_combout\,
	datac => \opr1~combout\(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~1_combout\);

-- Location: LC_X11_Y7_N4
\carryL~2\ : maxv_lcell
-- Equation(s):
-- \carryL~2_combout\ = (\opr2~combout\(2) & ((\opr1~combout\(3)) # ((\carryL~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e0e0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(3),
	datab => \carryL~0_combout\,
	datac => \opr2~combout\(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~2_combout\);

-- Location: PIN_113,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[4]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(4),
	combout => \opr1~combout\(4));

-- Location: LC_X11_Y7_N7
\adl_temp[4]\ : maxv_lcell
-- Equation(s):
-- adl_temp(4) = \opr2~combout\(3) $ (\opr1~combout\(4) $ (((\carryL~1_combout\) # (\carryL~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c936",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~1_combout\,
	datab => \opr2~combout\(3),
	datac => \carryL~2_combout\,
	datad => \opr1~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(4));

-- Location: PIN_114,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[4]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(4),
	combout => \opr2~combout\(4));

-- Location: LC_X12_Y5_N9
\output~14\ : maxv_lcell
-- Equation(s):
-- \output~14_combout\ = (((\opr2~combout\(4) & \opr1~combout\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr2~combout\(4),
	datad => \opr1~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~14_combout\);

-- Location: LC_X10_Y6_N3
\output[4]~15\ : maxv_lcell
-- Equation(s):
-- \output[4]~15_combout\ = (\output[0]~1_combout\ & (\output[0]~2_combout\)) # (!\output[0]~1_combout\ & ((\output[0]~2_combout\ & (adl_temp(4))) # (!\output[0]~2_combout\ & ((!\output~14_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c8d9",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => \output[0]~2_combout\,
	datac => adl_temp(4),
	datad => \output~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[4]~15_combout\);

-- Location: PIN_44,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[4]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(4),
	combout => \dest~combout\(4));

-- Location: LC_X11_Y7_N0
\carry~3\ : maxv_lcell
-- Equation(s):
-- \carry~3_combout\ = (\opr1~combout\(3) & ((\opr2~combout\(3)) # ((\carry~2_combout\) # (\carry~1_combout\)))) # (!\opr1~combout\(3) & (\opr2~combout\(3) & ((\carry~2_combout\) # (\carry~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eee8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(3),
	datab => \opr2~combout\(3),
	datac => \carry~2_combout\,
	datad => \carry~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~3_combout\);

-- Location: LC_X12_Y5_N8
\add_temp[4]~1\ : maxv_lcell
-- Equation(s):
-- \add_temp[4]~1_combout\ = \opr2~combout\(4) $ (((\carry~3_combout\ $ (\opr1~combout\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(4),
	datac => \carry~3_combout\,
	datad => \opr1~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[4]~1_combout\);

-- Location: LC_X8_Y5_N1
\output[4]~16\ : maxv_lcell
-- Equation(s):
-- \output[4]~16_combout\ = (\output[4]~15_combout\ & (((\add_temp[4]~1_combout\) # (!\output[0]~1_combout\)))) # (!\output[4]~15_combout\ & (\dest~combout\(4) & (\output[0]~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ea4a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[4]~15_combout\,
	datab => \dest~combout\(4),
	datac => \output[0]~1_combout\,
	datad => \add_temp[4]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[4]~16_combout\);

-- Location: LC_X11_Y5_N0
\output[4]$latch\ : maxv_lcell
-- Equation(s):
-- \output[4]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[4]~16_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[4]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[4]~16_combout\,
	datac => \output[4]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[4]$latch~combout\);

-- Location: LC_X11_Y7_N1
\carryL~3\ : maxv_lcell
-- Equation(s):
-- \carryL~3_combout\ = (\opr2~combout\(3) & ((\carryL~1_combout\) # ((\carryL~2_combout\) # (\opr1~combout\(4))))) # (!\opr2~combout\(3) & (\opr1~combout\(4) & ((\carryL~1_combout\) # (\carryL~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fec8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~1_combout\,
	datab => \opr2~combout\(3),
	datac => \carryL~2_combout\,
	datad => \opr1~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~3_combout\);

-- Location: PIN_112,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[5]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(5),
	combout => \opr1~combout\(5));

-- Location: LC_X12_Y7_N6
\adl_temp[5]~2\ : maxv_lcell
-- Equation(s):
-- \adl_temp[5]~2_combout\ = \carryL~3_combout\ $ (((\opr2~combout\(4) $ (\opr1~combout\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~3_combout\,
	datac => \opr2~combout\(4),
	datad => \opr1~combout\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[5]~2_combout\);

-- Location: LC_X12_Y5_N5
\carry~5\ : maxv_lcell
-- Equation(s):
-- \carry~5_combout\ = (\opr2~combout\(4) & (((\carry~3_combout\) # (\opr1~combout\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(4),
	datac => \carry~3_combout\,
	datad => \opr1~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~5_combout\);

-- Location: PIN_105,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[5]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(5),
	combout => \opr2~combout\(5));

-- Location: LC_X11_Y7_N5
\carry~4\ : maxv_lcell
-- Equation(s):
-- \carry~4_combout\ = (((\carry~3_combout\ & \opr1~combout\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \carry~3_combout\,
	datad => \opr1~combout\(4),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~4_combout\);

-- Location: LC_X12_Y7_N0
\add_temp[5]\ : maxv_lcell
-- Equation(s):
-- add_temp(5) = \opr1~combout\(5) $ (\opr2~combout\(5) $ (((\carry~5_combout\) # (\carry~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a596",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(5),
	datab => \carry~5_combout\,
	datac => \opr2~combout\(5),
	datad => \carry~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(5));

-- Location: LC_X12_Y7_N3
\output~17\ : maxv_lcell
-- Equation(s):
-- \output~17_combout\ = (\opr1~combout\(5) & (((\opr2~combout\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(5),
	datac => \opr2~combout\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~17_combout\);

-- Location: PIN_103,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[5]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(5),
	combout => \dest~combout\(5));

-- Location: LC_X12_Y7_N2
\output[5]~18\ : maxv_lcell
-- Equation(s):
-- \output[5]~18_combout\ = (\output[0]~1_combout\ & (((\output[0]~2_combout\) # (\dest~combout\(5))))) # (!\output[0]~1_combout\ & (!\output~17_combout\ & (!\output[0]~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cdc1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output~17_combout\,
	datab => \output[0]~1_combout\,
	datac => \output[0]~2_combout\,
	datad => \dest~combout\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[5]~18_combout\);

-- Location: LC_X12_Y7_N1
\output[5]~19\ : maxv_lcell
-- Equation(s):
-- \output[5]~19_combout\ = (\output[0]~2_combout\ & ((\output[5]~18_combout\ & ((add_temp(5)))) # (!\output[5]~18_combout\ & (\adl_temp[5]~2_combout\)))) # (!\output[0]~2_combout\ & (((\output[5]~18_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cfa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \adl_temp[5]~2_combout\,
	datab => add_temp(5),
	datac => \output[0]~2_combout\,
	datad => \output[5]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[5]~19_combout\);

-- Location: LC_X10_Y5_N1
\output[5]$latch\ : maxv_lcell
-- Equation(s):
-- \output[5]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & ((\output[5]~19_combout\))) # (!GLOBAL(\output[15]~5_combout\) & (\output[5]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[5]$latch~combout\,
	datac => \output[5]~19_combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[5]$latch~combout\);

-- Location: PIN_94,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[6]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(6),
	combout => \opr2~combout\(6));

-- Location: PIN_102,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[6]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(6),
	combout => \opr1~combout\(6));

-- Location: LC_X12_Y7_N5
\carry~6\ : maxv_lcell
-- Equation(s):
-- \carry~6_combout\ = (\opr1~combout\(5) & ((\carry~5_combout\) # ((\opr2~combout\(5)) # (\carry~4_combout\)))) # (!\opr1~combout\(5) & (\opr2~combout\(5) & ((\carry~5_combout\) # (\carry~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fae8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(5),
	datab => \carry~5_combout\,
	datac => \opr2~combout\(5),
	datad => \carry~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~6_combout\);

-- Location: LC_X12_Y6_N6
\add_temp[6]~2\ : maxv_lcell
-- Equation(s):
-- \add_temp[6]~2_combout\ = \opr2~combout\(6) $ (((\opr1~combout\(6) $ (\carry~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(6),
	datac => \opr1~combout\(6),
	datad => \carry~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[6]~2_combout\);

-- Location: LC_X12_Y7_N4
\carryL~5\ : maxv_lcell
-- Equation(s):
-- \carryL~5_combout\ = ((\opr2~combout\(4) & ((\carryL~3_combout\) # (\opr1~combout\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~3_combout\,
	datac => \opr2~combout\(4),
	datad => \opr1~combout\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~5_combout\);

-- Location: LC_X12_Y7_N7
\carryL~4\ : maxv_lcell
-- Equation(s):
-- \carryL~4_combout\ = (((\carryL~3_combout\ & \opr1~combout\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \carryL~3_combout\,
	datad => \opr1~combout\(5),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~4_combout\);

-- Location: LC_X12_Y7_N9
\adl_temp[6]\ : maxv_lcell
-- Equation(s):
-- adl_temp(6) = \opr2~combout\(5) $ (\opr1~combout\(6) $ (((\carryL~5_combout\) # (\carryL~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e11e",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~5_combout\,
	datab => \carryL~4_combout\,
	datac => \opr2~combout\(5),
	datad => \opr1~combout\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(6));

-- Location: LC_X12_Y6_N7
\output~20\ : maxv_lcell
-- Equation(s):
-- \output~20_combout\ = (\opr1~combout\(6) & (((\opr2~combout\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(6),
	datac => \opr2~combout\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~20_combout\);

-- Location: LC_X11_Y6_N7
\output[6]~21\ : maxv_lcell
-- Equation(s):
-- \output[6]~21_combout\ = (\output[0]~2_combout\ & ((adl_temp(6)) # ((\output[0]~1_combout\)))) # (!\output[0]~2_combout\ & (((!\output[0]~1_combout\ & !\output~20_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a8ad",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~2_combout\,
	datab => adl_temp(6),
	datac => \output[0]~1_combout\,
	datad => \output~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[6]~21_combout\);

-- Location: PIN_96,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[6]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(6),
	combout => \dest~combout\(6));

-- Location: LC_X11_Y6_N9
\output[6]~22\ : maxv_lcell
-- Equation(s):
-- \output[6]~22_combout\ = (\output[0]~1_combout\ & ((\output[6]~21_combout\ & (\add_temp[6]~2_combout\)) # (!\output[6]~21_combout\ & ((\dest~combout\(6)))))) # (!\output[0]~1_combout\ & (((\output[6]~21_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "bcb0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \add_temp[6]~2_combout\,
	datab => \output[0]~1_combout\,
	datac => \output[6]~21_combout\,
	datad => \dest~combout\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[6]~22_combout\);

-- Location: LC_X10_Y5_N0
\output[6]$latch\ : maxv_lcell
-- Equation(s):
-- \output[6]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[6]~22_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[6]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f3c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[15]~5_combout\,
	datac => \output[6]~22_combout\,
	datad => \output[6]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[6]$latch~combout\);

-- Location: PIN_93,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[7]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(7),
	combout => \opr2~combout\(7));

-- Location: LC_X12_Y6_N0
\carry~8\ : maxv_lcell
-- Equation(s):
-- \carry~8_combout\ = (\opr2~combout\(6) & (((\opr1~combout\(6)) # (\carry~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(6),
	datac => \opr1~combout\(6),
	datad => \carry~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~8_combout\);

-- Location: LC_X12_Y6_N4
\carry~7\ : maxv_lcell
-- Equation(s):
-- \carry~7_combout\ = (\opr1~combout\(6) & (((\carry~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(6),
	datac => \carry~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~7_combout\);

-- Location: PIN_104,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[7]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(7),
	combout => \opr1~combout\(7));

-- Location: LC_X12_Y6_N3
\add_temp[7]\ : maxv_lcell
-- Equation(s):
-- add_temp(7) = \opr2~combout\(7) $ (\opr1~combout\(7) $ (((\carry~8_combout\) # (\carry~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a956",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(7),
	datab => \carry~8_combout\,
	datac => \carry~7_combout\,
	datad => \opr1~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(7));

-- Location: LC_X12_Y6_N5
\output~23\ : maxv_lcell
-- Equation(s):
-- \output~23_combout\ = (\opr2~combout\(7) & (((\opr1~combout\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aa00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(7),
	datad => \opr1~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~23_combout\);

-- Location: PIN_95,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[7]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(7),
	combout => \dest~combout\(7));

-- Location: LC_X11_Y6_N1
\output[7]~24\ : maxv_lcell
-- Equation(s):
-- \output[7]~24_combout\ = (\output[0]~2_combout\ & (((\output[0]~1_combout\)))) # (!\output[0]~2_combout\ & ((\output[0]~1_combout\ & ((\dest~combout\(7)))) # (!\output[0]~1_combout\ & (!\output~23_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f1a1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~2_combout\,
	datab => \output~23_combout\,
	datac => \output[0]~1_combout\,
	datad => \dest~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[7]~24_combout\);

-- Location: LC_X12_Y7_N8
\carryL~6\ : maxv_lcell
-- Equation(s):
-- \carryL~6_combout\ = (\opr2~combout\(5) & ((\carryL~5_combout\) # ((\carryL~4_combout\) # (\opr1~combout\(6))))) # (!\opr2~combout\(5) & (\opr1~combout\(6) & ((\carryL~5_combout\) # (\carryL~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fee0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~5_combout\,
	datab => \carryL~4_combout\,
	datac => \opr2~combout\(5),
	datad => \opr1~combout\(6),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~6_combout\);

-- Location: LC_X12_Y6_N9
\adl_temp[7]~3\ : maxv_lcell
-- Equation(s):
-- \adl_temp[7]~3_combout\ = \opr2~combout\(6) $ (((\carryL~6_combout\ $ (\opr1~combout\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(6),
	datac => \carryL~6_combout\,
	datad => \opr1~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[7]~3_combout\);

-- Location: LC_X11_Y5_N9
\output[7]~25\ : maxv_lcell
-- Equation(s):
-- \output[7]~25_combout\ = (\output[0]~2_combout\ & ((\output[7]~24_combout\ & (add_temp(7))) # (!\output[7]~24_combout\ & ((\adl_temp[7]~3_combout\))))) # (!\output[0]~2_combout\ & (((\output[7]~24_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "dad0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~2_combout\,
	datab => add_temp(7),
	datac => \output[7]~24_combout\,
	datad => \adl_temp[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[7]~25_combout\);

-- Location: LC_X11_Y5_N1
\output[7]$latch\ : maxv_lcell
-- Equation(s):
-- \output[7]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & ((\output[7]~25_combout\))) # (!GLOBAL(\output[15]~5_combout\) & (\output[7]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[7]$latch~combout\,
	datac => \output[7]~25_combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[7]$latch~combout\);

-- Location: PIN_48,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[8]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(8),
	combout => \opr2~combout\(8));

-- Location: PIN_91,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[8]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(8),
	combout => \opr1~combout\(8));

-- Location: LC_X12_Y5_N4
\output~26\ : maxv_lcell
-- Equation(s):
-- \output~26_combout\ = (((\opr2~combout\(8) & \opr1~combout\(8))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr2~combout\(8),
	datad => \opr1~combout\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~26_combout\);

-- Location: LC_X12_Y6_N8
\carryL~7\ : maxv_lcell
-- Equation(s):
-- \carryL~7_combout\ = (((\carryL~6_combout\ & \opr1~combout\(7))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \carryL~6_combout\,
	datad => \opr1~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~7_combout\);

-- Location: LC_X12_Y6_N2
\carryL~8\ : maxv_lcell
-- Equation(s):
-- \carryL~8_combout\ = (\opr2~combout\(6) & (((\carryL~6_combout\) # (\opr1~combout\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(6),
	datac => \carryL~6_combout\,
	datad => \opr1~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~8_combout\);

-- Location: LC_X12_Y5_N1
\adl_temp[8]\ : maxv_lcell
-- Equation(s):
-- adl_temp(8) = \opr1~combout\(8) $ (\opr2~combout\(7) $ (((\carryL~7_combout\) # (\carryL~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c936",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~7_combout\,
	datab => \opr1~combout\(8),
	datac => \carryL~8_combout\,
	datad => \opr2~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(8));

-- Location: LC_X12_Y5_N0
\output[8]~27\ : maxv_lcell
-- Equation(s):
-- \output[8]~27_combout\ = (\output[0]~1_combout\ & (((\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & ((\output[0]~2_combout\ & ((adl_temp(8)))) # (!\output[0]~2_combout\ & (!\output~26_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f1c1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output~26_combout\,
	datab => \output[0]~1_combout\,
	datac => \output[0]~2_combout\,
	datad => adl_temp(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[8]~27_combout\);

-- Location: LC_X12_Y6_N1
\carry~9\ : maxv_lcell
-- Equation(s):
-- \carry~9_combout\ = (\opr2~combout\(7) & ((\carry~8_combout\) # ((\carry~7_combout\) # (\opr1~combout\(7))))) # (!\opr2~combout\(7) & (\opr1~combout\(7) & ((\carry~8_combout\) # (\carry~7_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fea8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(7),
	datab => \carry~8_combout\,
	datac => \carry~7_combout\,
	datad => \opr1~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~9_combout\);

-- Location: LC_X12_Y5_N7
\add_temp[8]~3\ : maxv_lcell
-- Equation(s):
-- \add_temp[8]~3_combout\ = \carry~9_combout\ $ (((\opr2~combout\(8) $ (\opr1~combout\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~9_combout\,
	datac => \opr2~combout\(8),
	datad => \opr1~combout\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[8]~3_combout\);

-- Location: PIN_106,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[8]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(8),
	combout => \dest~combout\(8));

-- Location: LC_X13_Y5_N0
\output[8]~28\ : maxv_lcell
-- Equation(s):
-- \output[8]~28_combout\ = (\output[8]~27_combout\ & ((\add_temp[8]~3_combout\) # ((!\output[0]~1_combout\)))) # (!\output[8]~27_combout\ & (((\output[0]~1_combout\ & \dest~combout\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "da8a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[8]~27_combout\,
	datab => \add_temp[8]~3_combout\,
	datac => \output[0]~1_combout\,
	datad => \dest~combout\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[8]~28_combout\);

-- Location: LC_X11_Y5_N7
\output[8]$latch\ : maxv_lcell
-- Equation(s):
-- \output[8]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[8]~28_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[8]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[8]~28_combout\,
	datac => \output[8]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[8]$latch~combout\);

-- Location: LC_X12_Y5_N6
\carry~11\ : maxv_lcell
-- Equation(s):
-- \carry~11_combout\ = ((\opr2~combout\(8) & ((\carry~9_combout\) # (\opr1~combout\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~9_combout\,
	datac => \opr2~combout\(8),
	datad => \opr1~combout\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~11_combout\);

-- Location: PIN_132,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[9]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(9),
	combout => \opr2~combout\(9));

-- Location: PIN_130,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[9]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(9),
	combout => \opr1~combout\(9));

-- Location: LC_X12_Y5_N2
\carry~10\ : maxv_lcell
-- Equation(s):
-- \carry~10_combout\ = (\carry~9_combout\ & (((\opr1~combout\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aa00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~9_combout\,
	datad => \opr1~combout\(8),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~10_combout\);

-- Location: LC_X8_Y6_N4
\add_temp[9]\ : maxv_lcell
-- Equation(s):
-- add_temp(9) = \opr2~combout\(9) $ (\opr1~combout\(9) $ (((\carry~11_combout\) # (\carry~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c396",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~11_combout\,
	datab => \opr2~combout\(9),
	datac => \opr1~combout\(9),
	datad => \carry~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(9));

-- Location: LC_X12_Y5_N3
\carryL~9\ : maxv_lcell
-- Equation(s):
-- \carryL~9_combout\ = (\opr1~combout\(8) & ((\carryL~7_combout\) # ((\carryL~8_combout\) # (\opr2~combout\(7))))) # (!\opr1~combout\(8) & (\opr2~combout\(7) & ((\carryL~7_combout\) # (\carryL~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fec8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~7_combout\,
	datab => \opr1~combout\(8),
	datac => \carryL~8_combout\,
	datad => \opr2~combout\(7),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~9_combout\);

-- Location: LC_X8_Y6_N9
\adl_temp[9]~4\ : maxv_lcell
-- Equation(s):
-- \adl_temp[9]~4_combout\ = \opr2~combout\(8) $ (((\opr1~combout\(9) $ (\carryL~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(8),
	datac => \opr1~combout\(9),
	datad => \carryL~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[9]~4_combout\);

-- Location: LC_X8_Y6_N2
\output~29\ : maxv_lcell
-- Equation(s):
-- \output~29_combout\ = ((\opr2~combout\(9) & (\opr1~combout\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr2~combout\(9),
	datac => \opr1~combout\(9),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~29_combout\);

-- Location: PIN_22,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[9]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(9),
	combout => \dest~combout\(9));

-- Location: LC_X8_Y6_N6
\output[9]~30\ : maxv_lcell
-- Equation(s):
-- \output[9]~30_combout\ = (\output[0]~1_combout\ & (((\dest~combout\(9)) # (\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & (!\output~29_combout\ & ((!\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aab1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => \output~29_combout\,
	datac => \dest~combout\(9),
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[9]~30_combout\);

-- Location: LC_X8_Y6_N5
\output[9]~31\ : maxv_lcell
-- Equation(s):
-- \output[9]~31_combout\ = (\output[9]~30_combout\ & ((add_temp(9)) # ((!\output[0]~2_combout\)))) # (!\output[9]~30_combout\ & (((\adl_temp[9]~4_combout\ & \output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "acf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => add_temp(9),
	datab => \adl_temp[9]~4_combout\,
	datac => \output[9]~30_combout\,
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[9]~31_combout\);

-- Location: LC_X10_Y5_N8
\output[9]$latch\ : maxv_lcell
-- Equation(s):
-- \output[9]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[9]~31_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[9]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aacc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[9]~31_combout\,
	datab => \output[9]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[9]$latch~combout\);

-- Location: PIN_50,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[10]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(10),
	combout => \opr2~combout\(10));

-- Location: PIN_51,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[10]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(10),
	combout => \opr1~combout\(10));

-- Location: LC_X8_Y6_N7
\carry~12\ : maxv_lcell
-- Equation(s):
-- \carry~12_combout\ = (\opr2~combout\(9) & ((\carry~11_combout\) # ((\opr1~combout\(9)) # (\carry~10_combout\)))) # (!\opr2~combout\(9) & (\opr1~combout\(9) & ((\carry~11_combout\) # (\carry~10_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fce8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~11_combout\,
	datab => \opr2~combout\(9),
	datac => \opr1~combout\(9),
	datad => \carry~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~12_combout\);

-- Location: LC_X8_Y5_N8
\add_temp[10]~4\ : maxv_lcell
-- Equation(s):
-- \add_temp[10]~4_combout\ = (\opr2~combout\(10) $ (\opr1~combout\(10) $ (\carry~12_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c33c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr2~combout\(10),
	datac => \opr1~combout\(10),
	datad => \carry~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[10]~4_combout\);

-- Location: PIN_137,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[10]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(10),
	combout => \dest~combout\(10));

-- Location: LC_X8_Y6_N8
\carryL~10\ : maxv_lcell
-- Equation(s):
-- \carryL~10_combout\ = (((\opr1~combout\(9) & \carryL~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr1~combout\(9),
	datad => \carryL~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~10_combout\);

-- Location: LC_X8_Y6_N1
\carryL~11\ : maxv_lcell
-- Equation(s):
-- \carryL~11_combout\ = (\opr2~combout\(8) & (((\opr1~combout\(9)) # (\carryL~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(8),
	datac => \opr1~combout\(9),
	datad => \carryL~9_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~11_combout\);

-- Location: LC_X8_Y6_N3
\adl_temp[10]\ : maxv_lcell
-- Equation(s):
-- adl_temp(10) = \opr2~combout\(9) $ (\opr1~combout\(10) $ (((\carryL~10_combout\) # (\carryL~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c396",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~10_combout\,
	datab => \opr2~combout\(9),
	datac => \opr1~combout\(10),
	datad => \carryL~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(10));

-- Location: LC_X8_Y5_N4
\output~32\ : maxv_lcell
-- Equation(s):
-- \output~32_combout\ = (((\opr1~combout\(10) & \opr2~combout\(10))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr1~combout\(10),
	datad => \opr2~combout\(10),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~32_combout\);

-- Location: LC_X8_Y5_N2
\output[10]~33\ : maxv_lcell
-- Equation(s):
-- \output[10]~33_combout\ = (\output[0]~1_combout\ & (((\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & ((\output[0]~2_combout\ & (adl_temp(10))) # (!\output[0]~2_combout\ & ((!\output~32_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ee05",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => adl_temp(10),
	datac => \output~32_combout\,
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[10]~33_combout\);

-- Location: LC_X8_Y5_N9
\output[10]~34\ : maxv_lcell
-- Equation(s):
-- \output[10]~34_combout\ = (\output[0]~1_combout\ & ((\output[10]~33_combout\ & (\add_temp[10]~4_combout\)) # (!\output[10]~33_combout\ & ((\dest~combout\(10)))))) # (!\output[0]~1_combout\ & (((\output[10]~33_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "afc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \add_temp[10]~4_combout\,
	datab => \dest~combout\(10),
	datac => \output[0]~1_combout\,
	datad => \output[10]~33_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[10]~34_combout\);

-- Location: LC_X11_Y5_N8
\output[10]$latch\ : maxv_lcell
-- Equation(s):
-- \output[10]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[10]~34_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[10]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f3c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[15]~5_combout\,
	datac => \output[10]~34_combout\,
	datad => \output[10]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[10]$latch~combout\);

-- Location: LC_X8_Y6_N0
\carryL~12\ : maxv_lcell
-- Equation(s):
-- \carryL~12_combout\ = (\opr2~combout\(9) & ((\carryL~10_combout\) # ((\opr1~combout\(10)) # (\carryL~11_combout\)))) # (!\opr2~combout\(9) & (\opr1~combout\(10) & ((\carryL~10_combout\) # (\carryL~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fce8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~10_combout\,
	datab => \opr2~combout\(9),
	datac => \opr1~combout\(10),
	datad => \carryL~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~12_combout\);

-- Location: PIN_129,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[11]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(11),
	combout => \opr1~combout\(11));

-- Location: LC_X8_Y7_N8
\adl_temp[11]~5\ : maxv_lcell
-- Equation(s):
-- \adl_temp[11]~5_combout\ = (\opr2~combout\(10) $ (\carryL~12_combout\ $ (\opr1~combout\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c33c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr2~combout\(10),
	datac => \carryL~12_combout\,
	datad => \opr1~combout\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[11]~5_combout\);

-- Location: LC_X8_Y5_N6
\carry~13\ : maxv_lcell
-- Equation(s):
-- \carry~13_combout\ = (((\opr1~combout\(10) & \carry~12_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr1~combout\(10),
	datad => \carry~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~13_combout\);

-- Location: LC_X8_Y5_N7
\carry~14\ : maxv_lcell
-- Equation(s):
-- \carry~14_combout\ = ((\opr2~combout\(10) & ((\opr1~combout\(10)) # (\carry~12_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr2~combout\(10),
	datac => \opr1~combout\(10),
	datad => \carry~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~14_combout\);

-- Location: PIN_15,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[11]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(11),
	combout => \opr2~combout\(11));

-- Location: LC_X8_Y7_N1
\add_temp[11]\ : maxv_lcell
-- Equation(s):
-- add_temp(11) = \opr2~combout\(11) $ (\opr1~combout\(11) $ (((\carry~13_combout\) # (\carry~14_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e11e",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~13_combout\,
	datab => \carry~14_combout\,
	datac => \opr2~combout\(11),
	datad => \opr1~combout\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(11));

-- Location: LC_X8_Y7_N9
\output~35\ : maxv_lcell
-- Equation(s):
-- \output~35_combout\ = (((\opr2~combout\(11) & \opr1~combout\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr2~combout\(11),
	datad => \opr1~combout\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~35_combout\);

-- Location: PIN_134,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[11]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(11),
	combout => \dest~combout\(11));

-- Location: LC_X8_Y7_N6
\output[11]~36\ : maxv_lcell
-- Equation(s):
-- \output[11]~36_combout\ = (\output[0]~1_combout\ & (((\dest~combout\(11)) # (\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & (!\output~35_combout\ & ((!\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aab1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => \output~35_combout\,
	datac => \dest~combout\(11),
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[11]~36_combout\);

-- Location: LC_X8_Y7_N0
\output[11]~37\ : maxv_lcell
-- Equation(s):
-- \output[11]~37_combout\ = (\output[11]~36_combout\ & (((add_temp(11)) # (!\output[0]~2_combout\)))) # (!\output[11]~36_combout\ & (\adl_temp[11]~5_combout\ & ((\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "caf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \adl_temp[11]~5_combout\,
	datab => add_temp(11),
	datac => \output[11]~36_combout\,
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[11]~37_combout\);

-- Location: LC_X9_Y5_N6
\output[11]$latch\ : maxv_lcell
-- Equation(s):
-- \output[11]$latch~combout\ = (GLOBAL(\output[15]~5_combout\) & (\output[11]~37_combout\)) # (!GLOBAL(\output[15]~5_combout\) & (((\output[11]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "b8b8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[11]~37_combout\,
	datab => \output[15]~5_combout\,
	datac => \output[11]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[11]$latch~combout\);

-- Location: PIN_131,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[12]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(12),
	combout => \opr1~combout\(12));

-- Location: LC_X8_Y7_N5
\carry~15\ : maxv_lcell
-- Equation(s):
-- \carry~15_combout\ = (\opr2~combout\(11) & ((\carry~13_combout\) # ((\carry~14_combout\) # (\opr1~combout\(11))))) # (!\opr2~combout\(11) & (\opr1~combout\(11) & ((\carry~13_combout\) # (\carry~14_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fee0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~13_combout\,
	datab => \carry~14_combout\,
	datac => \opr2~combout\(11),
	datad => \opr1~combout\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~15_combout\);

-- Location: PIN_127,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[12]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(12),
	combout => \opr2~combout\(12));

-- Location: LC_X9_Y6_N4
\add_temp[12]~5\ : maxv_lcell
-- Equation(s):
-- \add_temp[12]~5_combout\ = \opr1~combout\(12) $ (((\carry~15_combout\ $ (\opr2~combout\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a55a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(12),
	datac => \carry~15_combout\,
	datad => \opr2~combout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[12]~5_combout\);

-- Location: LC_X8_Y7_N2
\carryL~13\ : maxv_lcell
-- Equation(s):
-- \carryL~13_combout\ = (((\carryL~12_combout\ & \opr1~combout\(11))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \carryL~12_combout\,
	datad => \opr1~combout\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~13_combout\);

-- Location: LC_X8_Y7_N3
\carryL~14\ : maxv_lcell
-- Equation(s):
-- \carryL~14_combout\ = ((\opr2~combout\(10) & ((\carryL~12_combout\) # (\opr1~combout\(11)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccc0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr2~combout\(10),
	datac => \carryL~12_combout\,
	datad => \opr1~combout\(11),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~14_combout\);

-- Location: LC_X8_Y7_N4
\adl_temp[12]\ : maxv_lcell
-- Equation(s):
-- adl_temp(12) = \opr2~combout\(11) $ (\opr1~combout\(12) $ (((\carryL~13_combout\) # (\carryL~14_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a596",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(11),
	datab => \carryL~13_combout\,
	datac => \opr1~combout\(12),
	datad => \carryL~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(12));

-- Location: LC_X9_Y6_N6
\output~38\ : maxv_lcell
-- Equation(s):
-- \output~38_combout\ = (((\opr1~combout\(12) & \opr2~combout\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr1~combout\(12),
	datad => \opr2~combout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~38_combout\);

-- Location: LC_X11_Y6_N2
\output[12]~39\ : maxv_lcell
-- Equation(s):
-- \output[12]~39_combout\ = (\output[0]~1_combout\ & (((\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & ((\output[0]~2_combout\ & (adl_temp(12))) # (!\output[0]~2_combout\ & ((!\output~38_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa03",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => adl_temp(12),
	datab => \output~38_combout\,
	datac => \output[0]~1_combout\,
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[12]~39_combout\);

-- Location: PIN_98,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[12]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(12),
	combout => \dest~combout\(12));

-- Location: LC_X11_Y6_N3
\output[12]~40\ : maxv_lcell
-- Equation(s):
-- \output[12]~40_combout\ = (\output[12]~39_combout\ & ((\add_temp[12]~5_combout\) # ((!\output[0]~1_combout\)))) # (!\output[12]~39_combout\ & (((\output[0]~1_combout\ & \dest~combout\(12)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "bc8c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \add_temp[12]~5_combout\,
	datab => \output[12]~39_combout\,
	datac => \output[0]~1_combout\,
	datad => \dest~combout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[12]~40_combout\);

-- Location: LC_X11_Y5_N3
\output[12]$latch\ : maxv_lcell
-- Equation(s):
-- \output[12]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & ((\output[12]~40_combout\))) # (!GLOBAL(\output[15]~5_combout\) & (\output[12]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0aa",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[12]$latch~combout\,
	datac => \output[12]~40_combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[12]$latch~combout\);

-- Location: PIN_133,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[13]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(13),
	combout => \opr1~combout\(13));

-- Location: LC_X9_Y6_N2
\carry~16\ : maxv_lcell
-- Equation(s):
-- \carry~16_combout\ = (\opr1~combout\(12) & (((\carry~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(12),
	datac => \carry~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~16_combout\);

-- Location: PIN_124,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[13]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(13),
	combout => \opr2~combout\(13));

-- Location: LC_X9_Y6_N8
\carry~17\ : maxv_lcell
-- Equation(s):
-- \carry~17_combout\ = ((\opr2~combout\(12) & ((\opr1~combout\(12)) # (\carry~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fa00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(12),
	datac => \carry~15_combout\,
	datad => \opr2~combout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~17_combout\);

-- Location: LC_X9_Y6_N1
\add_temp[13]\ : maxv_lcell
-- Equation(s):
-- add_temp(13) = \opr1~combout\(13) $ (\opr2~combout\(13) $ (((\carry~16_combout\) # (\carry~17_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a596",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(13),
	datab => \carry~16_combout\,
	datac => \opr2~combout\(13),
	datad => \carry~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(13));

-- Location: LC_X8_Y7_N7
\carryL~15\ : maxv_lcell
-- Equation(s):
-- \carryL~15_combout\ = (\opr2~combout\(11) & ((\carryL~13_combout\) # ((\opr1~combout\(12)) # (\carryL~14_combout\)))) # (!\opr2~combout\(11) & (\opr1~combout\(12) & ((\carryL~13_combout\) # (\carryL~14_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fae8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(11),
	datab => \carryL~13_combout\,
	datac => \opr1~combout\(12),
	datad => \carryL~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~15_combout\);

-- Location: LC_X9_Y6_N3
\adl_temp[13]~6\ : maxv_lcell
-- Equation(s):
-- \adl_temp[13]~6_combout\ = (\carryL~15_combout\ $ (\opr1~combout\(13) $ (\opr2~combout\(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c33c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \carryL~15_combout\,
	datac => \opr1~combout\(13),
	datad => \opr2~combout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[13]~6_combout\);

-- Location: LC_X9_Y6_N9
\output~41\ : maxv_lcell
-- Equation(s):
-- \output~41_combout\ = (\opr2~combout\(13) & (((\opr1~combout\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(13),
	datac => \opr1~combout\(13),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~41_combout\);

-- Location: PIN_43,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[13]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(13),
	combout => \dest~combout\(13));

-- Location: LC_X8_Y5_N5
\output[13]~42\ : maxv_lcell
-- Equation(s):
-- \output[13]~42_combout\ = (\output[0]~1_combout\ & (((\dest~combout\(13)) # (\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & (!\output~41_combout\ & ((!\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aab1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => \output~41_combout\,
	datac => \dest~combout\(13),
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[13]~42_combout\);

-- Location: LC_X8_Y5_N3
\output[13]~43\ : maxv_lcell
-- Equation(s):
-- \output[13]~43_combout\ = (\output[13]~42_combout\ & ((add_temp(13)) # ((!\output[0]~2_combout\)))) # (!\output[13]~42_combout\ & (((\adl_temp[13]~6_combout\ & \output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "acf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => add_temp(13),
	datab => \adl_temp[13]~6_combout\,
	datac => \output[13]~42_combout\,
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[13]~43_combout\);

-- Location: LC_X11_Y5_N4
\output[13]$latch\ : maxv_lcell
-- Equation(s):
-- \output[13]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[13]~43_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[13]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ccf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[13]~43_combout\,
	datac => \output[13]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[13]$latch~combout\);

-- Location: LC_X9_Y6_N5
\carry~18\ : maxv_lcell
-- Equation(s):
-- \carry~18_combout\ = (\opr1~combout\(13) & ((\carry~16_combout\) # ((\opr2~combout\(13)) # (\carry~17_combout\)))) # (!\opr1~combout\(13) & (\opr2~combout\(13) & ((\carry~16_combout\) # (\carry~17_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fae8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(13),
	datab => \carry~16_combout\,
	datac => \opr2~combout\(13),
	datad => \carry~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~18_combout\);

-- Location: PIN_59,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[14]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(14),
	combout => \opr1~combout\(14));

-- Location: PIN_123,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[14]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(14),
	combout => \opr2~combout\(14));

-- Location: LC_X9_Y5_N2
\add_temp[14]~6\ : maxv_lcell
-- Equation(s):
-- \add_temp[14]~6_combout\ = \carry~18_combout\ $ (\opr1~combout\(14) $ ((\opr2~combout\(14))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "9696",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~18_combout\,
	datab => \opr1~combout\(14),
	datac => \opr2~combout\(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[14]~6_combout\);

-- Location: LC_X9_Y5_N4
\output~44\ : maxv_lcell
-- Equation(s):
-- \output~44_combout\ = ((\opr1~combout\(14) & (\opr2~combout\(14))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0c0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr1~combout\(14),
	datac => \opr2~combout\(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~44_combout\);

-- Location: LC_X9_Y6_N7
\carryL~17\ : maxv_lcell
-- Equation(s):
-- \carryL~17_combout\ = ((\opr2~combout\(12) & ((\carryL~15_combout\) # (\opr1~combout\(13)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \carryL~15_combout\,
	datac => \opr1~combout\(13),
	datad => \opr2~combout\(12),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~17_combout\);

-- Location: LC_X9_Y6_N0
\carryL~16\ : maxv_lcell
-- Equation(s):
-- \carryL~16_combout\ = (((\opr1~combout\(13) & \carryL~15_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr1~combout\(13),
	datad => \carryL~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~16_combout\);

-- Location: LC_X9_Y5_N8
\adl_temp[14]\ : maxv_lcell
-- Equation(s):
-- adl_temp(14) = \opr1~combout\(14) $ (\opr2~combout\(13) $ (((\carryL~17_combout\) # (\carryL~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c936",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~17_combout\,
	datab => \opr1~combout\(14),
	datac => \carryL~16_combout\,
	datad => \opr2~combout\(13),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(14));

-- Location: LC_X9_Y5_N9
\output[14]~45\ : maxv_lcell
-- Equation(s):
-- \output[14]~45_combout\ = (\output[0]~1_combout\ & (((\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & ((\output[0]~2_combout\ & ((adl_temp(14)))) # (!\output[0]~2_combout\ & (!\output~44_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f1c1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output~44_combout\,
	datab => \output[0]~1_combout\,
	datac => \output[0]~2_combout\,
	datad => adl_temp(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[14]~45_combout\);

-- Location: PIN_42,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[14]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(14),
	combout => \dest~combout\(14));

-- Location: LC_X9_Y5_N3
\output[14]~46\ : maxv_lcell
-- Equation(s):
-- \output[14]~46_combout\ = (\output[14]~45_combout\ & ((\add_temp[14]~6_combout\) # ((!\output[0]~1_combout\)))) # (!\output[14]~45_combout\ & (((\dest~combout\(14) & \output[0]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "b8cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \add_temp[14]~6_combout\,
	datab => \output[14]~45_combout\,
	datac => \dest~combout\(14),
	datad => \output[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[14]~46_combout\);

-- Location: LC_X9_Y5_N7
\output[14]$latch\ : maxv_lcell
-- Equation(s):
-- \output[14]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & (\output[14]~46_combout\)) # (!GLOBAL(\output[15]~5_combout\) & ((\output[14]$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aaf0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[14]~46_combout\,
	datac => \output[14]$latch~combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[14]$latch~combout\);

-- Location: PIN_120,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr1[15]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr1(15),
	combout => \opr1~combout\(15));

-- Location: PIN_122,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\opr2[15]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_opr2(15),
	combout => \opr2~combout\(15));

-- Location: LC_X10_Y6_N1
\output~47\ : maxv_lcell
-- Equation(s):
-- \output~47_combout\ = (((\opr1~combout\(15) & \opr2~combout\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opr1~combout\(15),
	datad => \opr2~combout\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output~47_combout\);

-- Location: PIN_125,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\dest[15]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_dest(15),
	combout => \dest~combout\(15));

-- Location: LC_X10_Y6_N4
\output[15]~48\ : maxv_lcell
-- Equation(s):
-- \output[15]~48_combout\ = (\output[0]~1_combout\ & (((\dest~combout\(15)) # (\output[0]~2_combout\)))) # (!\output[0]~1_combout\ & (!\output~47_combout\ & ((!\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "aab1",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[0]~1_combout\,
	datab => \output~47_combout\,
	datac => \dest~combout\(15),
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[15]~48_combout\);

-- Location: LC_X9_Y5_N0
\carryL~18\ : maxv_lcell
-- Equation(s):
-- \carryL~18_combout\ = (\opr1~combout\(14) & ((\carryL~17_combout\) # ((\carryL~16_combout\) # (\opr2~combout\(13))))) # (!\opr1~combout\(14) & (\opr2~combout\(13) & ((\carryL~17_combout\) # (\carryL~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fec8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carryL~17_combout\,
	datab => \opr1~combout\(14),
	datac => \carryL~16_combout\,
	datad => \opr2~combout\(13),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carryL~18_combout\);

-- Location: LC_X10_Y6_N2
\adl_temp[15]~7\ : maxv_lcell
-- Equation(s):
-- \adl_temp[15]~7_combout\ = \opr2~combout\(14) $ (\carryL~18_combout\ $ ((\opr1~combout\(15))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "9696",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(14),
	datab => \carryL~18_combout\,
	datac => \opr1~combout\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \adl_temp[15]~7_combout\);

-- Location: LC_X10_Y6_N0
\carry~20\ : maxv_lcell
-- Equation(s):
-- \carry~20_combout\ = (\opr2~combout\(14) & ((\carry~18_combout\) # ((\opr1~combout\(14)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e0e0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \carry~18_combout\,
	datab => \opr1~combout\(14),
	datac => \opr2~combout\(14),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~20_combout\);

-- Location: LC_X10_Y6_N6
\carry~19\ : maxv_lcell
-- Equation(s):
-- \carry~19_combout\ = ((\opr1~combout\(14) & ((\carry~18_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cc00",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opr1~combout\(14),
	datad => \carry~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \carry~19_combout\);

-- Location: LC_X10_Y6_N5
\add_temp[15]\ : maxv_lcell
-- Equation(s):
-- add_temp(15) = \opr1~combout\(15) $ (\opr2~combout\(15) $ (((\carry~20_combout\) # (\carry~19_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a956",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(15),
	datab => \carry~20_combout\,
	datac => \carry~19_combout\,
	datad => \opr2~combout\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => add_temp(15));

-- Location: LC_X10_Y6_N9
\output[15]~49\ : maxv_lcell
-- Equation(s):
-- \output[15]~49_combout\ = (\output[15]~48_combout\ & (((add_temp(15)) # (!\output[0]~2_combout\)))) # (!\output[15]~48_combout\ & (\adl_temp[15]~7_combout\ & ((\output[0]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "e4aa",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[15]~48_combout\,
	datab => \adl_temp[15]~7_combout\,
	datac => add_temp(15),
	datad => \output[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[15]~49_combout\);

-- Location: LC_X9_Y5_N1
\output[15]$latch\ : maxv_lcell
-- Equation(s):
-- \output[15]$latch~combout\ = ((GLOBAL(\output[15]~5_combout\) & ((\output[15]~49_combout\))) # (!GLOBAL(\output[15]~5_combout\) & (\output[15]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f0cc",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \output[15]$latch~combout\,
	datac => \output[15]~49_combout\,
	datad => \output[15]~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \output[15]$latch~combout\);

-- Location: LC_X12_Y4_N8
\C~2\ : maxv_lcell
-- Equation(s):
-- \C~2_combout\ = ((\opcode~combout\(1) & (!\opcode~combout\(0) & \cin~combout\)) # (!\opcode~combout\(1) & (\opcode~combout\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "3c30",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \opcode~combout\(1),
	datac => \opcode~combout\(0),
	datad => \cin~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C~2_combout\);

-- Location: LC_X10_Y6_N8
\add_temp[16]~7\ : maxv_lcell
-- Equation(s):
-- \add_temp[16]~7_combout\ = (\opr1~combout\(15) & ((\carry~20_combout\) # ((\carry~19_combout\) # (\opr2~combout\(15))))) # (!\opr1~combout\(15) & (\opr2~combout\(15) & ((\carry~20_combout\) # (\carry~19_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fea8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr1~combout\(15),
	datab => \carry~20_combout\,
	datac => \carry~19_combout\,
	datad => \opr2~combout\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \add_temp[16]~7_combout\);

-- Location: LC_X12_Y4_N3
\C~0\ : maxv_lcell
-- Equation(s):
-- \C~0_combout\ = ((\opcode~combout\(0) $ (!\opcode~combout\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f00f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => \opcode~combout\(0),
	datad => \opcode~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C~0_combout\);

-- Location: LC_X10_Y6_N7
\adl_temp[16]\ : maxv_lcell
-- Equation(s):
-- adl_temp(16) = \opr2~combout\(15) $ (((\opr2~combout\(14) & ((\carryL~18_combout\) # (\opr1~combout\(15)))) # (!\opr2~combout\(14) & (\carryL~18_combout\ & \opr1~combout\(15)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "17e8",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opr2~combout\(14),
	datab => \carryL~18_combout\,
	datac => \opr1~combout\(15),
	datad => \opr2~combout\(15),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => adl_temp(16));

-- Location: LC_X12_Y4_N6
\C~1\ : maxv_lcell
-- Equation(s):
-- \C~1_combout\ = (\Equal0~0_combout\ & (\C~0_combout\ & (adl_temp(16)))) # (!\Equal0~0_combout\ & (((\cin~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "8f80",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \C~0_combout\,
	datab => adl_temp(16),
	datac => \Equal0~0_combout\,
	datad => \cin~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C~1_combout\);

-- Location: LC_X12_Y4_N7
\C~3\ : maxv_lcell
-- Equation(s):
-- \C~3_combout\ = (\C~1_combout\) # ((\C~2_combout\ & (\add_temp[16]~7_combout\ & \Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff80",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \C~2_combout\,
	datab => \add_temp[16]~7_combout\,
	datac => \Equal0~0_combout\,
	datad => \C~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C~3_combout\);

-- Location: LC_X12_Y3_N2
\C~4\ : maxv_lcell
-- Equation(s):
-- \C~4_combout\ = ((\opcode~combout\(1)) # ((\zin~combout\ & \opcode~combout\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffa0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \zin~combout\,
	datac => \opcode~combout\(0),
	datad => \opcode~combout\(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C~4_combout\);

-- Location: LC_X12_Y3_N4
\C~5\ : maxv_lcell
-- Equation(s):
-- \C~5_combout\ = (\enable~combout\ & ((\Equal0~0_combout\ & ((\C~4_combout\))) # (!\Equal0~0_combout\ & (\output[15]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "c0a0",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[15]~4_combout\,
	datab => \C~4_combout\,
	datac => \enable~combout\,
	datad => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C~5_combout\);

-- Location: LC_X12_Y3_N9
\C$latch\ : maxv_lcell
-- Equation(s):
-- \C$latch~combout\ = (!\reset~combout\ & ((GLOBAL(\C~5_combout\) & (\C~3_combout\)) # (!GLOBAL(\C~5_combout\) & ((\C$latch~combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "4540",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \reset~combout\,
	datab => \C~3_combout\,
	datac => \C~5_combout\,
	datad => \C$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \C$latch~combout\);

-- Location: LC_X12_Y4_N9
\Z~0\ : maxv_lcell
-- Equation(s):
-- \Z~0_combout\ = (\opcode~combout\(0) & (((\Equal0~0_combout\)))) # (!\opcode~combout\(0) & (\opcode~combout\(1) & ((!\cin~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "a0e4",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \opcode~combout\(0),
	datab => \opcode~combout\(1),
	datac => \Equal0~0_combout\,
	datad => \cin~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Z~0_combout\);

-- Location: LC_X10_Y5_N3
\WideOr0~0\ : maxv_lcell
-- Equation(s):
-- \WideOr0~0_combout\ = (\output[3]$latch~combout\) # ((\output[0]$latch~combout\) # ((\output[1]$latch~combout\) # (\output[2]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[3]$latch~combout\,
	datab => \output[0]$latch~combout\,
	datac => \output[1]$latch~combout\,
	datad => \output[2]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \WideOr0~0_combout\);

-- Location: LC_X10_Y5_N2
\WideOr0~3\ : maxv_lcell
-- Equation(s):
-- \WideOr0~3_combout\ = (\output[12]$latch~combout\) # ((\output[14]$latch~combout\) # ((\output[15]$latch~combout\) # (\output[13]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[12]$latch~combout\,
	datab => \output[14]$latch~combout\,
	datac => \output[15]$latch~combout\,
	datad => \output[13]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \WideOr0~3_combout\);

-- Location: LC_X10_Y5_N4
\WideOr0~1\ : maxv_lcell
-- Equation(s):
-- \WideOr0~1_combout\ = (\output[4]$latch~combout\) # ((\output[5]$latch~combout\) # ((\output[6]$latch~combout\) # (\output[7]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[4]$latch~combout\,
	datab => \output[5]$latch~combout\,
	datac => \output[6]$latch~combout\,
	datad => \output[7]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \WideOr0~1_combout\);

-- Location: LC_X10_Y5_N9
\WideOr0~2\ : maxv_lcell
-- Equation(s):
-- \WideOr0~2_combout\ = (\output[9]$latch~combout\) # ((\output[10]$latch~combout\) # ((\output[11]$latch~combout\) # (\output[8]$latch~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \output[9]$latch~combout\,
	datab => \output[10]$latch~combout\,
	datac => \output[11]$latch~combout\,
	datad => \output[8]$latch~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \WideOr0~2_combout\);

-- Location: LC_X10_Y5_N5
\WideOr0~4\ : maxv_lcell
-- Equation(s):
-- \WideOr0~4_combout\ = (\WideOr0~0_combout\) # ((\WideOr0~3_combout\) # ((\WideOr0~1_combout\) # (\WideOr0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "fffe",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr0~0_combout\,
	datab => \WideOr0~3_combout\,
	datac => \WideOr0~1_combout\,
	datad => \WideOr0~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \WideOr0~4_combout\);

-- Location: LC_X10_Y5_N6
\Z~1\ : maxv_lcell
-- Equation(s):
-- \Z~1_combout\ = (\zin~combout\ & ((\WideOr0~4_combout\) # ((\Z~0_combout\ & !\opcode~combout\(0))))) # (!\zin~combout\ & (\WideOr0~4_combout\ & (\Z~0_combout\ $ (!\opcode~combout\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "eb08",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \zin~combout\,
	datab => \Z~0_combout\,
	datac => \opcode~combout\(0),
	datad => \WideOr0~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Z~1_combout\);

-- Location: LC_X10_Y5_N7
\Z$latch\ : maxv_lcell
-- Equation(s):
-- \Z$latch~combout\ = (!\reset~combout\ & ((GLOBAL(\C~5_combout\) & ((\Z~1_combout\))) # (!GLOBAL(\C~5_combout\) & (\Z$latch~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5404",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \reset~combout\,
	datab => \Z$latch~combout\,
	datac => \C~5_combout\,
	datad => \Z~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Z$latch~combout\);

-- Location: PIN_53,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[0]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[0]$latch~combout\,
	oe => VCC,
	padio => ww_output(0));

-- Location: PIN_52,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[1]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[1]$latch~combout\,
	oe => VCC,
	padio => ww_output(1));

-- Location: PIN_63,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[2]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[2]$latch~combout\,
	oe => VCC,
	padio => ww_output(2));

-- Location: PIN_57,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[3]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[3]$latch~combout\,
	oe => VCC,
	padio => ww_output(3));

-- Location: PIN_55,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[4]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[4]$latch~combout\,
	oe => VCC,
	padio => ww_output(4));

-- Location: PIN_45,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[5]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[5]$latch~combout\,
	oe => VCC,
	padio => ww_output(5));

-- Location: PIN_40,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[6]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[6]$latch~combout\,
	oe => VCC,
	padio => ww_output(6));

-- Location: PIN_86,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[7]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[7]$latch~combout\,
	oe => VCC,
	padio => ww_output(7));

-- Location: PIN_88,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[8]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[8]$latch~combout\,
	oe => VCC,
	padio => ww_output(8));

-- Location: PIN_85,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[9]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[9]$latch~combout\,
	oe => VCC,
	padio => ww_output(9));

-- Location: PIN_89,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[10]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[10]$latch~combout\,
	oe => VCC,
	padio => ww_output(10));

-- Location: PIN_58,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[11]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[11]$latch~combout\,
	oe => VCC,
	padio => ww_output(11));

-- Location: PIN_87,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[12]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[12]$latch~combout\,
	oe => VCC,
	padio => ww_output(12));

-- Location: PIN_119,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[13]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[13]$latch~combout\,
	oe => VCC,
	padio => ww_output(13));

-- Location: PIN_60,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[14]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[14]$latch~combout\,
	oe => VCC,
	padio => ww_output(14));

-- Location: PIN_49,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[15]~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[15]$latch~combout\,
	oe => VCC,
	padio => ww_output(15));

-- Location: PIN_77,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\C~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \C$latch~combout\,
	oe => VCC,
	padio => ww_C);

-- Location: PIN_30,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\Z~I\ : maxv_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \Z$latch~combout\,
	oe => VCC,
	padio => ww_Z);
END structure;


