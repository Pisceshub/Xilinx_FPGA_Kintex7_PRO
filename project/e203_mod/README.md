### 1. 摘要
================

- 该开源RISC-V处理器是蜂鸟E203修改版本，主要修改仿真工具，使用vcs+verdi进行仿真；为了低成本学习RISC-V，也修改FPGA综合环境，将其移植到自己的FPGA板卡上，非芯来淘宝指定的板卡，目前成功运行hello word程序.

- 但是如果需要蜂鸟E200最新的版本，请到芯来官方Github上获取：[RISCV-MCU/e203_hbirdv2](https://github.com/riscv-mcu/e203_hbirdv2).


================
### 2.我的低成本硬件
如图，从左到右依次为：
 1. Xilinx FPGA HS3 Cable（下载器）；
 2. K325t FPGA板卡，闲鱼淘的，花了750大洋，目前使用没有遇到任何问题；
 3. PCB拓展板，将FPGA板卡2.0mm接口转成常用2.54mm，顺便增加一些常用的外设和接口：LED、按键、Flash、Uart、IIC、SPI、GPIO等，另外还有软件程序调试接口；这个画的第一版，有些小瑕疵，第二版还在排队生产中。**注意：这个PCB不是一定要做**；
 4. Sipeed 40大洋的RV-link调试器，与芯来淘宝店199的下载器一样，目前使用正常；
 与芯来淘宝点3、4千的FPGA板卡+199调试器相比，我使用现有的FPGA板卡和Cable，额外只需要制作PCB和购买Sipeed调试器，这两个的费用加起来不到100，比购买一个芯来的调试器还便宜，这应该是很低成本了吧，当然这样比较折腾人，但这也很值得。
![我的硬件](https://img-blog.csdnimg.cn/20210217111703286.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDM3NzE5NQ==,size_16,color_FFFFFF,t_70#pic_center"在这里输入图片标题")

===============
### 3.详细内容
- 这里是列表文本详细内容和步骤请看我的博客：[传送门](https://blog.csdn.net/weixin_40377195)

- 或者我的公众号：

![我的公众号](https://img-blog.csdnimg.cn/20210112234044890.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDM3NzE5NQ==,size_16,color_FFFFFF,t_70 "我的公众号")

===============
### 4.成功的喜悦
![串口助手截图](https://img-blog.csdnimg.cn/20210218212904504.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDM3NzE5NQ==,size_16,color_FFFFFF,t_70 "hello word")
