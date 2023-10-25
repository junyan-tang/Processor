transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/dffe.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/skeleton.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/regfile.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/processor.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/dmem.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/alu.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/SX.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/Control.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/reg_12bit.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/clock_divider_by2.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/plus1.v}
vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/imem.v}

vlog -vlog01compat -work work +incdir+C:/ECE550/Processor {C:/ECE550/Processor/skeleton_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  skeleton_tb

add wave *
view structure
view signals
run -all
