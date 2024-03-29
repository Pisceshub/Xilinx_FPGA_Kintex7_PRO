export LD_LIBRARY_PATH=$(VERDI_HOME)/share/PLI/VCS/linux64
UVM_HOME = /home/ICer/my_ic/uvm/uvm_lib/uvm-1.1d
include $(UVM_HOME)/examples/Makefile.vcs
################################################################################
#-----------------------------------VCS---------------------------------------##
################################################################################


#################################define and path###############################
top_tbfile_name = M0_tb
sub_file_path = 000.uvm

ALL_DEFINE = +define+FSDB

# 库文件路径
# K7
k7_vcs_libs_path = /home/ICer/my_ic/k7_vcs_libs

# VERDI
VERDI_HOME=/home/synopsys/verdi/Verdi_O-2018.09-SP2
# /home/synopsys/verdi/Verdi_O-2018.09-SP2/share/PLI/VCS/linux64
NOVAS_HOME=$(VERDI_HOME)
DEBUSSY_PLI=-P $(NOVAS_HOME)/share/PLI/VCS/linux64/novas.tab $(NOVAS_HOME)/share/PLI/VCS/linux64/pli.a

prj_path = ../..
## 源码有关的path
src_path = $(prj_path)/src

rtl_path = $(src_path)/rtl/$(sub_file_path)/
tb_path = $(src_path)/tb/$(sub_file_path)/
xdc_path = $(src_path)/xdc/$(sub_file_path)/
ipcore_path = $(src_path)/ipcore/
glbl_path = $(src_path)/glbl/
software_path = $(src_path)/software/

# vcs平台path
vcs_path = $(prj_path)/vcs

dataFile_path = $(vcs_path)/datafile
macro_path 	= $(vcs_path)/macro
model_path = $(vcs_path)/model
syssim_path = $(vcs_path)/syssim
wavefile_path = $(vcs_path)/wavefile
vcs_work_path = $(vcs_path)/work
log_file_path = $(vcs_path)/work/log_file

################################# ANALYSIS #########################################
vcs_all_file = -f $(vcs_path)/work/vcs_all_file.list

filelist = -f $(vcs_all_file)

# -work > Xilinx_Lib
OTHERS=$(k7_vcs_libs_path)/synopsys_sim.setup
Xilinx_Lib : $(k7_vcs_libs_path) # 2. 指定编译库路径
WORK_LIB_NAME = WORK_LIB
VLOGAN_OPTS = -work $(WORK_LIB_NAME) -full64 +v2k -l $(log_file_path)/analysis.log +define+SIMULATION_EN -sverilog
VHDLAN_OPTS = -work $(WORK_LIB_NAME) -full64 


# code coverage command
CM = -cm line+cond+fsm+branch+tgl+assert # 行\翻转\状态机\分支\条件覆盖率\断言
CM_NAME = -cm_name simv
CM_DIR = -cm_dir $(vcs_work_path)/simv.vdb
# -cm_name simv -cm_dir $dir/simv.vdb 
### 分析
# verilog:vlogan命令
# VHDL:vhdlan命令
# SystemVerilog:vlogan命令 要加-sverilog选项

ANALYSIS = vlogan $(VLOGAN_OPTS) $(vcs_all_file) $(ALL_DEFINE)  


################################# COMPILE #########################################
# 主要将硬件语言编译成库的过程
# verilog:vlogan命令
# VHDL:vhdlan命令
# SystemVerilog:vlogan命令 要加-sverilog选项
# ip核或硬核：需要通过synopsys_sim.setup指定IP库
## 1. 链接xilinx ip库（在vivado中生成的）（自定义的setup需要与makefile放一起）

COMPILE = vlogan 	+v2k -work 	$(WORK_LIB_NAME) \
					+incdir+$(macro_path) \
					-l $(log_file_path)/compile.log	\
					-sverilog \
					$(ALL_DEFINE)  \
					+define+SIMULATION_EN \
					+lint=DSFIF \
					$(vcs_all_file) 

# vlogan \ 命令
# +v2k \	verilog-2001
# -work Xilinx_Lib \ 指定编译库
# +incdir+$(macro_sim)\ 指定宏定义搜索路径
# -l $(SIM_PATH)/Temp/VCS/com.log \ 
# -sverilog	\ 支持sv
# +define+SIMULATION_EN \
# $(SIM_PATH)/Temp/glbl.v \
# -f $(rtl_ip_tb_soft_xdc_vfile_path)/vfile.v \ 编译filelist文件
# -f $(rtl_ip_tb_soft_xdc_vfile_path)/svfile.v \ $(v_tb_file)


################################# ELABORATE #########################################


# 将上面生成的库文件，以及可能用到的xilinx IP的库文件，生成仿真的可执行文件。
ELABORATE = vcs -full64 	\
			-debug_pp       \
			-t ps			\
			-licqueue		\
			-l $(log_file_path)/elaborate.log \
			$(DEBUSSY_PLI) \
			$(WORK_LIB_NAME).$(top_tbfile_name) \
			$(WORK_LIB_NAME).glbl \
			-sverilog \
			-Mupdate \
			${CM} \
			${CM_NAME} \
			${CM_DIR} \
			+lint=TFIPC-L \
			-o $(vcs_work_path)/simv 
			 

# -debug_pp \
# -t ps \
# -licqueue \

# vcs \
# -full64 -cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,-on-as-needed \
# -Mdir=Xilinx_Lib \  # 指定默认编译库
# -sverilog \
# -lca \ # 使用用户限制功能
# -debug_all \
# -P $(verdi_home)/novas.tab \
# $(verdi_home)/pli.a \ 配置verdi的PLI
# -l $(SIM_PATH)/Temp/VCS/elb.log \
# Xilinx_Lib.glbl \
# Xilinx_Lib.$(Bench_Name) \ 指定编译库中的bench和glbl
# -file $(f_c) 指定需要编译的filelist文件
# -o $(SIM_PATH)/Temp/VCS/simv 生成可执行文件
################################# SIMULATE #########################################
# 执行上面生成的simv.o可执行文件，进行仿真。
# 由于需要生成适用于verdi的fsdb文件，所以在bench中还需要添加任务语句。

SIMULATE = $(vcs_work_path)/simv \
			-l $(log_file_path)/simulate.log \
			-k $(vcs_work_path)/ucli.key \
			$(ALL_DEFINE)  \
			${CM} \
			${CM_NAME} \
			${CM_DIR} \
			$(hex_file)

# simulate在verilog中的部分脚本:
# initial begin
# 	$fsdbAutoSwitchDumpfile(200, "Wavefile/FsdbFile/top.fsdb", 100);
# 	$fsdbDumpvars;
# 	$display("******************* wave dump start ***********************");
# end

################################# VCS #########################################
#Comppile command 

VCS = vcs -R -full64											\
	+v2k														\
	-debug_access												\
	$(ALL_DEFINE)												\
	-sverilog													\
    $(vcs_all_file)												\
	-l $(log_file_path)/vcs_compile.log							\
	-Mupdate
#VCS = vcs -sverilog  +v2k      \
	-debug_all				 \
	+notimingcheck				 \
	+nospecify				 \
	+vcs+flush+all				 \
	$(ALL_DEFINE)				 \
   	$(VPD_NAME)				 \
	-o  $(OUTPUT)				 \
	-l  compile.log                \
        -f file_list		  

################################# VERDI  #########################################
VERDI=verdi \
	$(vcs_all_file) \
	-2001					\
	-sveriolg 				\
	-ssf simv.fsdb
# 覆盖率检查
COVER = dve -covdir *.vdb 

################################# CLEAN #########################################
CLEAN= \
	rm -rf ./64 ./csrc ./verdiLog ./*.log ./simv.fsdb ./ucli.key ./inter.vpd ./novas* ./DVEfiles ./simv ./simv.daidir
#start clean 
VCLEAN= \
	rm -rf ./csrc ./log_file/*.log  ./verdiLog  ./file_list ./*.log ./vcs_lib ./novas.conf ./simv* ./ucli.key 
################################# ERROR #########################################
VERROR= \
	grep error  $(log_file_path)/*.log



vcleanlist = echo "\# file list clean" > vcs_all_file.list 
vfind_tb = find $(tb_path) -type f -name "*.v" -printf "%p\n" >> vcs_all_file.list 
vfind_rtl = find $(rtl_path) -type f -name "*.v" -printf "%p\n" >> vcs_all_file.list
vfind_gl = find $(glbl_path) -type f -name "*.v" -printf "%p\n" >> vcs_all_file.list  
vfind_ip = find $(ipcore_path) -type f -name "*.v" -printf "%p\n" >> vcs_all_file.list 
vupdata_flash = cp /mnt/hgfs/linux_share_file/M0Prj/code.hex  /home/ICer/my_ic/wild_fire/src/flash/

vcle:
	$(vcleanlist)
vtb: 
	$(vfind_tb)
vrtl: 
	$(vfind_rtl)
vgl: 
	$(vfind_gl)
vip: 
	$(vfind_ip)
vf:
	$(vupdata_flash)

# 仿真存在ipcore时
ipVCSFILE= $(vcleanlist) &&  $(vfind_gl) &&  $(vfind_tb) && $(vfind_rtl) &&  $(vfind_ip) 

# 仿真不存在ipcore时
VCSFILE=  $(vcleanlist) &&  $(vfind_gl)  && $(vfind_tb) && $(vfind_rtl)  


##伪目标com 、cov、 clean debug sim dve
.PHONY: vana  vcom vela  vsim vclean com verdi clean err
help: 
	@echo "there are some cmd to note:"
	@echo "make vall: to get filelist ana vom ela sim and verdi "
	@echo "make vrcom: to  ana vom ela and sim  but needed to make sure filelist"
	@echo "make help"
	@echo "make vana to ANALYSIS command"
	@echo "make vcom to COMPILE command"
	@echo "make vela to ELABORATE command"
	@echo "make vsim to SIMULATE command"
	@echo "make vclean to CLEAN command"
	@echo "make com to compile command"
	@echo "make verdi to start verdi and load wavefile"
	@echo "make clean to remove simfile"
	@echo "make error to find error in log_file"	
#start simulation 
################################# VCS ########################################################
### 有ip或没有ip都可以
vfile:
	@echo "check for vcs_all_file.list"
	$(ipVCSFILE) 
vana:
	$(ANALYSIS)
vcom:
	$(COMPILE)	
vela:
	$(ELABORATE)	
vsim:
	$(SIMULATE)	

vrcom:
	$(vupdata_flash) && \
	$(ANALYSIS) && $(COMPILE) && $(ELABORATE) && $(SIMULATE) 
vcover:
	$(COVER)
vall:
	$(ANALYSIS) && $(COMPILE) && $(ELABORATE) && $(SIMULATE) && $(VERDI)

### 无ip
vcs:
	$(VCS)
cover:
	$(COVER)

verdi:
	$(VERDI)
## 
verr:
	$(ERROR)
vclean:
	$(VCLEAN)	

#######################################################################################################

allclean:
	$(CLEAN)
err:
	$(ERROR)

################################################################################
#---------------------------------- DC ---------------------------------------##
################################################################################

.PHONY: dc

DC = dc_shell | tee dc_start.log


dfind_rtl = find /home/ICer/my_ic/wild_fire/src/rtl/000.my_m0_2nvic/ -type f -name "*.v" -printf "read_verilog %p\n" > dc_all_file.tcl  
dfind_ip = find /home/ICer/my_ic/wild_fire/src/ipcore/ -type f -name "*.v" -printf "read_verilog %p\n" >> dc_all_file.tcl 
drtl: 
	$(dfind_rtl)
dip: 
	$(dfind_ip)
DCFILE = $(dfind_rtl) &&  $(dfind_ip) 

dcfile = find  -name "*.v" |awk '{print "read_verilog "$0}' > dc_all_file.tcl

dc:
	$(DC)
dfile:
	$(DCFILE)

################################## DC #############################################

################################################################################
#---------------------------------- vivado ---------------------------------------##
################################################################################

vivado_file = $(vcleanlist) &&  $(vfind_tb) && $(vfind_rtl) &&  $(vfind_ip)  

vifile:
	$(vivado_file)

#---------------------------------- vivado ---------------------------------------##




################################################################################
#---------------------------------- SV ---------------------------------------##
################################################################################
svcleanlist = echo "\# file list clean" > svsim.list 
svfind_tb = find $(tb_path) -type f -name "*.v" -printf "%p\n" >> svsim.list 
svfind_rtl = find $(rtl_path) -type f -name "*.v" -printf "%p\n" >> svsim.list
svfind_gl = find $(glbl_path) -type f -name "*.v" -printf "%p\n" >> svsim.list  
svfind_ip = find $(ipcore_path) -type f -name "*.v" -printf "%p\n" >> svsim.list 
svupdata_flash = cp /mnt/hgfs/linux_share_file/M0Prj/code.hex  /home/ICer/my_ic/wild_fire/src/flash/
svcle:
	$(svcleanlist)
svtb: 
	$(svfind_tb)
svrtl: 
	$(svfind_rtl)
svgl: 
	$(svfind_gl)
svip: 
	$(svfind_ip)
svuf:
	$(svupdata_flash)

svfile = 	echo "+incdir+$(UVM_HOME)/src" > svsim.list && \
			echo "$(UVM_HOME)/src/uvm_pkg.sv" >> svsim.list && \
			$(svfind_tb)  && $(svfind_rtl)

svfile:
	$(svfile)


SVCS = vcs -R -full64											\
	+v2k														\
	-debug_access												\
	-sverilog													\
	$(ALL_DEFINE)												\
	$(DEBUSSY_PLI)												\
	$(UVM_HOME)/src/dpi/uvm_dpi.cc 								\
	-CFLAGS -DVCS 												\
    -f svsim.list												\
	-l $(log_file_path)/vcs_compile.log							\
	-timescale=1ns/1ps											\
	-Mupdate

svcs:
	$(SVCS)

SVERDI=verdi \
	-f svsim.list 			\
	-2001					\
	-sveriolg 				\
	-ssf simv.fsdb
 
sverdi:
	$(SVERDI)

CDWORK 		=  	cd $dir 
INCDIRS 	= 	+incdir+/home/ICer/my_ic/uvm/uvm_lib/uvm-1.1d/src 			\
				/home/ICer/my_ic/uvm/uvm_lib/uvm-1.1d/src/dpi/uvm_dpi.cc 	\
				/home/ICer/my_ic/uvm/uvm_lib/uvm-1.1d/src/uvm_pkg.sv		\
				/home/ICer/my_ic/wild_fire/src/rtl/000.my_m0_0macro/ 		
TIMESACLE 	= 	-timescale=1ns/1ns
VCS_CMD 	= 	-R -full64 +v2k -debug_acc+all -sverilog -l vcs_compile.log  Mupdate \
 				+lint=PCWM 
			

MVCS = vcs     $fileName   && verdi -2001 $fileName -sveriolg -ssf simv.fsdb  && rm -rf $dir/csrc $dir/ucli.key $dir/*.daidir $dir/novas_dump.log $dir/novas.conf $dir/verdiLog $dir/simv $dir/cm.log $dir/vdCovLog $dir/simv.vdb $dir/simv.fsdb $dir/vcs_compile.log $dir/vc_hdrs.h
