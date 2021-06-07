# UART-IP-CORE16550A-Verification-UVM
The UART (Universal Asynchronous Receiver/Transmitter) core provides serial  communication capabilities, which allow communication with modem or other external  devices, like another computer using a serial cable and RS232 protocol. This core is  designed to be maximally compatible with the industry standard National  Semiconductors’ 16550A device. 

This is Half Duplex 

Output
---

```systemverilog
# The Value In The Tx FIFO in DUT1 is : 7
#
# The Value In The Tx FIFO in DUT2 is : 0
#
#
#
#
#
# The Value In The Rx FIFO in DUT1 is : 0
#
# The Value In The Rx FIFO in DUT2 is : 7
#
# UVM_INFO ../tb/scoreboard.sv(64) @ 16318000: uvm_test_top.env_h.sb [UART 1] Data Match in UART 1 Successfull
# UVM_INFO ../tb/scoreboard.sv(69) @ 16318000: uvm_test_top.env_h.sb [UART 2] Data Match in UART 2 Successfull

```
