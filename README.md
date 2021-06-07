# UART-IP-CORE16550A-Verification-UVM
The UART (Universal Asynchronous Receiver/Transmitter) core provides serial  communication capabilities, which allow communication with modem or other external  devices, like another computer using a serial cable and RS232 protocol. This core is  designed to be maximally compatible with the industry standard National  Semiconductors’ 16550A device. 

## This is Full Duplex Test Case
In here the UART-1 and UART-2 both are sending and receive the data at same time.

Output
---
```systemverilog
# The Value In The Tx FIFO in DUT1 is : 7
#
# The Value In The Tx FIFO in DUT2 is : 10
#
#
#
#
#
# The Value In The Rx FIFO in DUT1 is : 10
#
# The Value In The Rx FIFO in DUT2 is : 7
#
# UVM_INFO ../tb/scoreboard.sv(64) @ 17003000: uvm_test_top.env_h.sb [UART 1] Data Match in UART 1 Successfull
# UVM_INFO ../tb/scoreboard.sv(69) @ 17003000: uvm_test_top.env_h.sb [UART 2] Data Match in UART 2 Successfull
```

To work this we want to write sequence that can write/read data to/from register's.

First send the DL value to both UART's.

To access DL[Divisor Latch] register this address is 0, and another registers has the same address so inorder to select this register make LCR 7'th bit as 1;

clear info is menctioned in seqs code

```systemverilog
// full duplex seqs 1
class fd_seq_1 extends base_seq;
  `uvm_object_utils(fd_seq_1)
  extern function new(string name = "fd_seq_1");
  extern task body();
endclass : fd_seq_1

function fd_seq_1::new(string name = "fd_seq_1");
  super.new(name);
endfunction : new

task fd_seq_1::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0011_0110;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0001;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 7 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_0111;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 8 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  get_response(req);
  
  // 9 LSR
  if(req.IIR[3:1] == 3'b010)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
  
endtask : body

// full duplex seqs 2
class fd_seq_2 extends base_seq;
  `uvm_object_utils(fd_seq_2)
  extern function new(string name = "fd_seq_2");
  extern task body();
endclass : fd_seq_2

function fd_seq_2::new(string name = "fd_seq_2");
  super.new(name);
endfunction : new

task fd_seq_2::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0001_1010;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0001;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 7 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_1010;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 8 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  get_response(req);
  
  // 9 LSR
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
endtask : body

```
