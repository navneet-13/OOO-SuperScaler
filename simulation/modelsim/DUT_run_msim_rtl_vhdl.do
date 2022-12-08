transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/Testbench.vhdl}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/DUT.vhdl}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/rs_rob_translator.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/pc_buffer.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/operand_translator.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/memory.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/Main_register_file.vhdl}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/flag_register_file.vhdl}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/fetch.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/decoder.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/branch_predictor.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/ROB.vhdl}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/res_station_updated.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/datapath.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/LS_Ex_Unit.vhd}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/alu.vhdl}
vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/Branch_Jump_Ex.vhd}

vcom -93 -work work {D:/Desktop/GitHub/OOO-SuperScaler/Testbench.vhdl}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L maxv -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all
