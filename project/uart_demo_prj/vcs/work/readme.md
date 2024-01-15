VCS文件目录：
├── datafile                --> datafile
├── macro                   --> 宏定义
├── model                   --> model
├── syssim                  --> 系统仿真
├── wavefile                --> 波形文件
└── work                    --> 工作目录
    ├── log_file            --> log日志文件
    ├── Makefile            --> makefile
    ├── readme.md           --> README.md
    ├── synopsys_sim.setup  --> synopsys_sim.setup sim仿真启动的链接库
    └── vcs_all_file.list   --> vcs仿真使用的文件
总体步骤：
1. 用vivado compile出../../../K7_vcs_libs 放总工程下
2. 用vivado 生成ipcore  放rtl下
3. 添加glbl.v 放glbl下
4. 添加synopsys_sim.setup 修改为：
    WORK > xilinx_defaultlib
    xilinx_defaultlib:./vcs_lib/xilinx_defaultlib
	OTHERS=/home/ICer/my_ic/k7_vcs_libs/synopsys_sim.setup //1. 生成的
VCS步骤：
- 没有涉及到ip时：
    一步法 make vcs 或三步法 make vall 都可以
- 涉及到ip时：
    三步法 make vall 可以

################################# VCS ################################################
### 有ip或没有ip都可以
vfile:
	$(iVCSFILE)
vana:
	$(ANALYSIS)
vcom:
	$(COMPILE)	
vela:
	$(ELABORATE)	
vsim:
	$(SIMULATE)	
vrcom:
	$(ANALYSIS) && $(COMPILE) && $(ELABORATE) && $(SIMULATE)
vall:
	$(iVCSFILE) && $(ANALYSIS) && $(COMPILE) &&	$(ELABORATE) && $(SIMULATE) && $(VERDI)

### 无ip
vcs:
	$(VCSFILE) &&  $(VCS)
verdi:
	$(VERDI)
## 
verr:
	$(ERROR)
vclean:
	$(VCLEAN)	