# UART-IP-CORE16550A-Verification-UVM
The UART (Universal Asynchronous Receiver/Transmitter) core provides serial  communication capabilities, 
  which allow communication with modem or other external  devices, like another computer using a serial cable and RS232 protocol. 
This core is  designed to be maximally compatible with the industry standard National  Semiconductors’ 16550A device. 

***

This project contains UVM with RTL of UART IP CORE 16550A.

Files are commited into github as sections select different branches for clear understanding how I developed Verification in UVM.

List of avaliable Test Cases, & the Features 
---
   - 1 --> Topology Print 
   - 2 --> Half Duplex
   - 3 --> Full Duplex
   - 4 --> Loop Back
   - 5 --> Parity Error
   - 6 --> Framming Error
   - 7 --> Over Run Error
   - 8 --> Time Out Error
   - 9 --> THR Empty  (Transmitting Holding Register)
   - 10 --> Functional Coverage
   
***
Register's avaliable in UART 1655A
---
```systemverilog
Interrupt Enable Register (IER)
  This register allows enabling and disabling interrupt generation by the UART.

Interrupt Identification Register (IIR)
  The IIR enables the programmer to retrieve what is the current highest priority pending interrupt

FIFO Control Register (FCR)
  The FCR allows selection of the FIFO trigger level (the number of bytes in FIFO required to enable the Received Data Available interrupt).
  In addition, the FIFOs can be cleared using this register.

Line Control Register (LCR)
  The line control register allows the specification of the format of the asynchronous data communication used.
  A bit in the register also allows access to the Divisor Latches, which define the baud rate.
  Reading from the register is allowed to check the current settings of the communication.

Line Status Register (LSR)

Modem Control Register (MCR)
  The modem control register allows transferring control signals to a modem connected to the UART.

Modem Status Register (MSR)
  The register displays the current state of the modem control lines.
  Also, four bits also provide an indication in the state of one of the modem status lines.
  These bits are set to ‘1’ when a change in corresponding line has been detected and they are reset when the register is being read.

Divisor Latches (DL)
  The divisor latches can be accessed by setting the 7th bit of LCR to ‘1’.
  You should restore this bit to ‘0’ after setting the divisor latches in order to restore access to the other registers, that occupy the same 3esses.
  The 2 bytes form one 16-bit register, which is internally accessed as a single number.
  You should therefore set all 2 bytes of the register to ensure normal operation.
  The register is set to the default value of 0 on reset, which disables all serial I/O operations in order to ensure explicit setup of the register in the software.
  The value set should be equal to (system clock speed) / (16 x desired baud rate).
  The internal counter starts to work when the LSB of DL is written, so when setting the divisor, write the MSB first and the LSB last.

Debug 1 & Debug 2
  This register is only available when the core has 32-bit data bus and 5-bit 3ess bus.
  It is read only and is provided for debugging purposes of chip testing as it is not part of the original UART16550 device specifications.
  Reading from the does not influence core’s bahaviour.
```
***


1 --> Topology
---

#### It has 2 agents(agt_h[0], agt_h[1]) every agent is active-agent(monitor, driver, sequencer).

```systemverilog
# UVM_INFO @ 0: reporter [UVMTOP] UVM testbench topology:
# --------------------------------------------------------------------
# Name                         Type                        Size  Value
# --------------------------------------------------------------------
# uvm_test_top                 base_test                   -     @475 
#   env_h                      env                         -     @491 
#     agt_top_h                agt_top                     -     @499 
#       agt_h[0]               agt                         -     @628 
#         drv_h                drv                         -     @660 
#           rsp_port           uvm_analysis_port           -     @675 
#           seq_item_port      uvm_seq_item_pull_port      -     @667 
#         mon_h                mon                         -     @645 
#           monitor_port       uvm_analysis_port           -     @652 
#         seqrh                seqr                        -     @683 
#           rsp_export         uvm_analysis_export         -     @690 
#           seq_item_export    uvm_seq_item_pull_imp       -     @784 
#           arbitration_queue  array                       0     -    
#           lock_queue         array                       0     -    
#           num_last_reqs      integral                    32    'd1  
#           num_last_rsps      integral                    32    'd1  
#       agt_h[1]               agt                         -     @636 
#         drv_h                drv                         -     @816 
#           rsp_port           uvm_analysis_port           -     @831 
#           seq_item_port      uvm_seq_item_pull_port      -     @823 
#         mon_h                mon                         -     @801 
#           monitor_port       uvm_analysis_port           -     @808 
#         seqrh                seqr                        -     @839 
#           rsp_export         uvm_analysis_export         -     @846 
#           seq_item_export    uvm_seq_item_pull_imp       -     @940 
#           arbitration_queue  array                       0     -    
#           lock_queue         array                       0     -    
#           num_last_reqs      integral                    32    'd1  
#           num_last_rsps      integral                    32    'd1  
#     sb                       scoreboard                  -     @615 
#       fifo_h[0]*             uvm_tlm_analysis_fifo #(T)  -     @956 
#         analysis_export      uvm_analysis_imp            -     @995 
#         get_ap               uvm_analysis_port           -     @987 
#         get_peek_export      uvm_get_peek_imp            -     @971 
#         put_ap               uvm_analysis_port           -     @979 
#         put_export           uvm_put_imp                 -     @963 
#       fifo_h[1]*             uvm_tlm_analysis_fifo #(T)  -     @1003
#         analysis_export      uvm_analysis_imp            -     @1042
#         get_ap               uvm_analysis_port           -     @1034
#         get_peek_export      uvm_get_peek_imp            -     @1018
#         put_ap               uvm_analysis_port           -     @1026
#         put_export           uvm_put_imp                 -     @1010
#     v_seqr_h                 v_seqr                      -     @506 
#       rsp_export             uvm_analysis_export         -     @513 
#       seq_item_export        uvm_seq_item_pull_imp       -     @607 
#       arbitration_queue      array                       0     -    
#       lock_queue             array                       0     -    
#       num_last_reqs          integral                    32    'd1  
#       num_last_rsps          integral                    32    'd1  
# --------------------------------------------------------------------

```

***

2 --> Half Duplex
---


    
    
