# UART-IP-CORE16550A-Verification-UVM
The UART (Universal Asynchronous Receiver/Transmitter) core provides serial  communication capabilities, 
  which allow communication with modem or other external  devices, like another computer using a serial cable and RS232 protocol. 
This core is  designed to be maximally compatible with the industry standard National  Semiconductors’ 16550A device. 

This project contains UVM with RTL of UART IP CORE 16550A.

Files are commited into github as sections select different branches for clear understanding how I developed Verification in UVM.
I put forward as stages, 
   - #### stage 1 --> Topology Print [select Topology branch]
   - #### stage 2 --> Full Duplex Sequence [select Full Duplex branch]
   - #### stage 3 --> Half Duplex Sequence [select Half Duplex branch]
***

## stage 1 --> Topology

#### It has 2 agents(agt_h[0], agt_h[1]) every agent is active-agent(monitor, driver, sequencer).

```
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



    
    
