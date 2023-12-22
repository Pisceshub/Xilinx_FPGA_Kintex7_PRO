debImport "-f" "../../vcs/work/vcs_all_file.list" "-2001" "-sveriolg"
debLoadSimResult /home/ICer/my_ic/uart_demo_prj/vcs/work/simv.fsdb
wvCreateWindow
srcHBSelect "uart_top_tb.uart_top_inst" -win $_nTrace1
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBSelect "uart_top_tb.uart_top_inst.clk_wiz_inst" -win $_nTrace1
srcHBSelect "uart_top_tb.uart_top_inst.clk_wiz_inst" -win $_nTrace1
srcHBSelect "uart_top_tb.uart_top_inst" -win $_nTrace1
srcSetScope -win $_nTrace1 "uart_top_tb.uart_top_inst" -delim "."
srcHBSelect "uart_top_tb.uart_top_inst" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk_out1" -line 38 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 581899.529042 -snap {("uart_top_inst" 3)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
debExit
