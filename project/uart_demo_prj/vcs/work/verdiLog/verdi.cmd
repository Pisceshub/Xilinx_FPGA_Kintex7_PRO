debImport "-f" "../../vcs/work/vcs_all_file.list" "-2001" "-sveriolg"
debLoadSimResult /home/ICer/my_ic/project/uart_demo_prj/vcs/work/simv.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 -10 "20" "903" "701"
srcDeselectAll -win $_nTrace1
srcSelect -signal "uart_rx_reg" -line 33 -pos 1 -win $_nTrace1
srcSelect -win $_nTrace1 -range {26 33 2 8 3 4} -backward
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
debExit
