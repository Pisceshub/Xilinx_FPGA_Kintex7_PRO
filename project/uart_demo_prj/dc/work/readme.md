清空命令行：
    ctrl + L
DC命令：
1. 读入文件：
    read_verilog xxx.v
    #或者
    read_file -format verilog xxx.v
    #或者
    read_file file_list 
    #这个filelist必须是tcl语法的list
    #或者
    analyze -format sverilog -vcs "-f ./dc_all_file.list"

    # 查看设计：
        list_designs
2. elaborate
    elaborate uart_top
3. 设置顶层current_design
    current_design uart_top

    # 查看导入module、 调式sdc等 
        # 单元
        get_cells  
        # 端口
        get_ports
        all_inputs
        all_outputs
        ## 注意去检查tcl中的端口

        # reg
        all_registers
        # clock
        all_clocks
        # 顶层
        current_design
        # hier结构
        report_hierarchy
        # mem
        report mem
        # 报出例化的mem的instance full name 和 ref_name (module name)
        get_reference
        get_attr

    注意，此时无法看到reg的端口，需要link之后才行
4. link库
    link

    # 查看库\检查设计，报timing等：
        check_design
        reset_design # 去除一切约束
        report_timing
        list_libs
        report_lib <库名称>
5. 添加约束：
    create_clock -period 20 [get_ports sys_clk]
    set_input_delay 6 -clock sys_clk [all_inputs ]
    remove_input_delay [get_ports sys_clk]
    set_output_delay 6 -clock sys_clk [all_outputs ]

    # 检查时序约束完整性：
        check_timing


6.  compile 
    compile -map_effort high -area_effort high -scan     
    compile -map_effort high -area_effort high

    # 检查时序违规：
        report_constraint -all_violators
    # 检查时序报告建立时间：
        report_timing -delay_type max
    # 检查功耗：
        report_power
    # 检查面积：
        report_area
    # 将设计全部移除：
        remove_design -hierarchy
    

    
7. 编写tcl 
    # tcl文件错误检查
        dcprocheck xxx.tcl
    # 执行tcl
        source ../script/xxx.tcl

8. 文件分析：
    SDF文件：
        包含单元延迟信息
    SDC：
        包含该设计所有约束
    report：

