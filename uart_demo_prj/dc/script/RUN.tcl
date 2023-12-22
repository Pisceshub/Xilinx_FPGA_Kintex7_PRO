# source the uart.tcl and print the process to terminal & compile.log

redirect -tee -file ${WORK_PATH}/run.log {source -echo -verbose My_TOP.tcl}

redirect -tee -file ${WORK_PATH}/com.log {compile -map_effort high       \
												  -area_effort high      \
												  -power_effort high     \
												  -boundary_optimization \
												  -gate_clock            }
