#Makefile for UVM Testbench
RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../agt_top 
SVTB2 = ../test/test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc 
VSIMCOV= -coverage -sva 
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit uart_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit uart_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit uart_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit uart_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit uart_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit uart_cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit uart_cov7;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit uart_cov8;run -all; exit"
VSIMBATCH9= -c -do  " log -r /* ;coverage save -onexit uart_cov9;run -all; exit"


help:
	@echo =============================================================================================================
	@echo "! USAGE   	--  make target                             											!"
	@echo "! clean   	=>  clean the earlier log and intermediate files.       								!"
	@echo "! sv_cmp    	=>  Create library and compile the code.                   								!"
	@echo "! run_sim    =>  run the simulation in batch mode.                   								!"
	@echo "! run_test	=>  clean, compile & run the simulation for ram_signle_adddr_test in batch mode.		!" 
	@echo "! run_test1	=>  clean, compile & run the simulation for ram_ten_adddr_test in batch mode.			!" 
	@echo "! run_test2	=>  clean, compile & run the simulation for ram_odd_adddr_test in batch mode.			!"
	@echo "! run_test3	=>  clean, compile & run the simulation for ram_even	_adddr_test in batch mode.		!" 
	@echo "! view_wave1 =>  To view the waveform of ram_signle_addr_test	    								!" 
	@echo "! view_wave2 =>  To view the waveform of ram_ten_addr_test	    									!" 
	@echo "! view_wave3 =>  To view the waveform of ram_odd_addr_test	  	  									!" 
	@echo "! view_wave4 =>  To view the waveform of ram_even_addr_test	    									!" 
	@echo "! regress    =>  clean, compile and run all testcases in batch mode.		    						!"
	@echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.			!"
	@echo "! cov        =>  To open merged coverage report in html format.										!"
	@echo ====================================================================================================================

sv_cmp:
	vlib $(work)
	vmap work $(work)
	vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1) 	
	
run_test:sv_cmp
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=base_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov1

	
run_test1:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=fd_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov2
	
run_test2:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=hd_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov3
	
run_test3:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=lb_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov4

run_test4:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log  -sv_seed random  work.top +UVM_TESTNAME=parity_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov5

run_test5:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test6.log  -sv_seed random  work.top +UVM_TESTNAME=framing_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov6

run_test6:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test7.log  -sv_seed random  work.top +UVM_TESTNAME=thr_empty_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov7

run_test7:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave_file8.wlf -l test8.log  -sv_seed random  work.top +UVM_TESTNAME=orr_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov8

run_test8:
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9)  -wlf wave_file9.wlf -l test9.log  -sv_seed random  work.top +UVM_TESTNAME=timeout_test
	vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov9
	
view_wave1:
	vsim -view wave_file1.wlf
	
view_wave2:
	vsim -view wave_file2.wlf
	
view_wave3:
	vsim -view wave_file3.wlf
	
view_wave4:
	vsim -view wave_file4.wlf
	
view_wave5:
	vsim -view wave_file5.wlf
	
view_wave6:
	vsim -view wave_file6.wlf
	
view_wave7:
	vsim -view wave_file7.wlf
	
view_wave8:
	vsim -view wave_file8.wlf

report:
	vcover merge uart_cov uart_cov1 uart_cov2 uart_cov3 uart_cov4 uart_cov5 uart_cov6 uart_cov7 uart_cov8
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html uart_cov

regress: clean run_test run_test1 run_test2 run_test3 run_test4 run_test5 run_test6 run_test7 run_test8 report cov

cov:
	firefox covhtmlreport/index.html&
	
clean:
	rm -rf transcript* *log*  vsim.wlf fcover* covhtml* uart_cov* *.wlf modelsim.ini
	clear

