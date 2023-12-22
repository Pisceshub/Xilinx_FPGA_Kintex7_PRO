debImport "-2001" "tb.sv" "-sveriolg"
debLoadSimResult /home/ICer/my_ic/uart_demo_prj/src/rtl/baixue/simv.fsdb
wvCreateWindow
srcDeselectAll -win $_nTrace1
srcSelect -signal "clk" -line 4 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvZoom -win $_nWave2 3012558.869702 21405023.547881
wvZoom -win $_nWave2 3445662.433551 6390766.667734
wvZoom -win $_nWave2 3602857.949975 4162289.052544
debExit
