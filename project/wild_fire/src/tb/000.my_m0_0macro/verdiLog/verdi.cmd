debImport "+define+FSDB" "+define+M0_MODULE" "+define+LED_MODULE" \
          "+define+SEG_MODULE" "+define+BTN_NVIC_MODULE" \
          "+define+TIMER_NVIC_MODULE" "+define+UART_MODULE" \
          "+define+SIMULATION_EN" "+define+ADC_MODULE" "-2001" "-f" \
          "/home/ICer/my_ic/wild_fire/vcs/work/vcs_all_file.list" \
          "+incdir+/home/ICer/my_ic/wild_fire/src/rtl/000.my_m0_0macro/" \
          "+incdir+/home/ICer/my_ic/wild_fire/src/tb/000.my_m0_0macro/" "-y" \
          "/home/ICer/my_ic/wild_fire/src/rtl/000.my_m0_0macro/" "-y" \
          "/home/ICer/my_ic/wild_fire/src/tb/000.my_m0_0macro/" "-y" \
          "/home/ICer/my_ic/wild_fire/src/glbl/" "+libext+.v" "-ssy" "-ssv"
debLoadSimResult /home/ICer/my_ic/wild_fire/vcs/work/simv.fsdb
wvCreateWindow
srcHBSelect "M0_tb.AHBLITE_SYS_U1" -win $_nTrace1
srcHBSelect "M0_tb.AHBLITE_SYS_U1.clk_wiz_eth_delay_200m_u" -win $_nTrace1
srcHBSelect "M0_tb.AHBLITE_SYS_U1.mdio_rw_test_u" -win $_nTrace1
srcHBSelect "M0_tb.AHBLITE_SYS_U1.mdio_rw_test_u" -win $_nTrace1
srcSetScope -win $_nTrace1 "M0_tb.AHBLITE_SYS_U1.mdio_rw_test_u" -delim "."
srcHBSelect "M0_tb.AHBLITE_SYS_U1.mdio_rw_test_u" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcHBSelect "M0_tb.AHBLITE_SYS_U1.u_cortexm0ds" -win $_nTrace1
srcSetScope -win $_nTrace1 "M0_tb.AHBLITE_SYS_U1.u_cortexm0ds" -delim "."
srcHBSelect "M0_tb.AHBLITE_SYS_U1.u_cortexm0ds" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {33 45 2 1 1 1}
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 5965.189189 -snap {("G1" 9)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSetCursor -win $_nWave2 29089.760349 -snap {("G1" 4)}
wvSetCursor -win $_nWave2 29573.856209 -snap {("G1" 4)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {30 30 1 8 1 4} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {29 30 3 8 1 4} -backward
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 13 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 12)}
wvSelectSignal -win $_nWave2 {( "G1" 12 )} 
wvSetPosition -win $_nWave2 {("G1" 11)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetPosition -win $_nWave2 {("G1" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSetCursor -win $_nWave2 10254.030501 -snap {("G1" 3)}
wvZoom -win $_nWave2 28429.629630 29705.882353
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 28077.559913 30322.004357
wvZoom -win $_nWave2 29383.151779 29583.635924
wvSetCursor -win $_nWave2 29489.727228 -snap {("G1" 2)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
srcHBSelect "M0_tb.AHBLITE_SYS_U1" -win $_nTrace1
srcSetScope -win $_nTrace1 "M0_tb.AHBLITE_SYS_U1" -delim "."
srcHBSelect "M0_tb.AHBLITE_SYS_U1" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "led" -line 52 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 1)}
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "led" -line 547 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 535 -pos 4 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -signal "HLED" -line 442 -pos 1 -win $_nTrace1
srcAddSelectedToWave -clipboard -win $_nTrace1
wvDrop -win $_nWave2
wvSetCursor -win $_nWave2 28841.145734 -snap {("G1" 3)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 29441.830065 -snap {("G1" 2)}
wvZoom -win $_nWave2 28957.734205 30013.943355
wvSetCursor -win $_nWave2 29492.051775 -snap {("G1" 3)}
wvZoom -win $_nWave2 29447.410255 29642.544321
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 12 )} 
wvSelectSignal -win $_nWave2 {( "G1" 13 )} 
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSelectSignal -win $_nWave2 {( "G1" 4 )} 
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSelectSignal -win $_nWave2 {( "G1" 2 )} 
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
srcDeselectAll -win $_nTrace1
wvSelectSignal -win $_nWave2 {( "G1" 10 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 24984.876988 25485.508525
wvZoom -win $_nWave2 25061.880445 25197.563589
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 25069.418397 -snap {("G1" 10)}
wvZoom -win $_nWave2 25052.864462 25216.511932
wvSetCursor -win $_nWave2 25090.157546 -snap {("G1" 4)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 7447.778174 7776.356623
wvSetCursor -win $_nWave2 7528.670036 -snap {("G1" 10)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 9350.741334 9561.489690
wvSetCursor -win $_nWave2 9428.796281 -snap {("G1" 11)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvZoom -win $_nWave2 396.078431 2772.549020
