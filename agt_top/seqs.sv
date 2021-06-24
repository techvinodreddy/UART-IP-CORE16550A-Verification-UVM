/* ---------------------------- sequences ---------------------------------- */
// --> base sequence
class base_seq extends uvm_sequence #(xtn);
  `uvm_object_utils(base_seq) // factory registration
  // --> Methods
  extern function new(string name = "base_seq");
endclass : base_seq

/* ---------------------------- new ---------------------------------- */
function base_seq::new(string name = "base_seq");
  super.new(name);
endfunction : new

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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
endtask : body

// half duplex seqs 1
class hd_seq_1 extends base_seq;
  `uvm_object_utils(hd_seq_1)
  extern function new(string name = "hd_seq_1");
  extern task body();
endclass : hd_seq_1

function hd_seq_1::new(string name = "hd_seq_1");
  super.new(name);
endfunction : new

task hd_seq_1::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0011_0110;});
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0001;});
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
  finish_item(req);

  // 7 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_0111;});
  finish_item(req);
endtask : body

// half duplex seqs 2
class hd_seq_2 extends base_seq;
  `uvm_object_utils(hd_seq_2)
  extern function new(string name = "hd_seq_2");
  extern task body();
endclass : hd_seq_2

function hd_seq_2::new(string name = "hd_seq_2");
  super.new(name);
endfunction : new

task hd_seq_2::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0001_1010;});
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0001;});
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
  finish_item(req);

  // 8 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
  finish_item(req);

  get_response(req);
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
    finish_item(req);
  end
endtask : body

//loop back seqs 2
class lb_seq_1 extends base_seq;
  `uvm_object_utils(lb_seq_1)
  extern function new(string name = "lb_seq_1");
  extern task body();
endclass : lb_seq_1

function lb_seq_1::new(string name = "lb_seq_1");
  super.new(name);
endfunction : new

task lb_seq_1::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0001_1010;});
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0001;});
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
  finish_item(req);

  // 7 MSR for loop back
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 4; wb_we_i == 1; wb_dat_i == 8'b0001_0000;});
  finish_item(req);

  // 8 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_0111;});
  finish_item(req);

  // 9 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
  finish_item(req);

  get_response(req);
  
  // 10 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
    finish_item(req);
  end

  // 11 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
    finish_item(req);
  end
endtask : body


//loop back seqs 2
class lb_seq_2 extends base_seq;
  `uvm_object_utils(lb_seq_2)
  extern function new(string name = "lb_seq_2");
  extern task body();
endclass : lb_seq_2

function lb_seq_2::new(string name = "lb_seq_2");
  super.new(name);
endfunction : new

task lb_seq_2::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0001_1010;});
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0001;});
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
  finish_item(req);

  // 7 MSR for loop back
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 4; wb_we_i == 1; wb_dat_i == 8'b0001_0000;});
  finish_item(req);

  // 8 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_1010;});
  finish_item(req);

  // 9 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
  finish_item(req);

  get_response(req);
  
  // 10 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
    finish_item(req);
  end

  // 11 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
    finish_item(req);
  end
endtask : body


//parity seqs 2
class parity_1 extends base_seq;
  `uvm_object_utils(parity_1)
  extern function new(string name = "parity_1");
  extern task body();
endclass : parity_1

function parity_1::new(string name = "parity_1");
  super.new(name);
endfunction : new

task parity_1::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0001_1010;});
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0001_1011;});
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0100;});
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
  finish_item(req);

  // 7 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_0111;});
  finish_item(req);

  // 8 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
  finish_item(req);

  get_response(req);
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
    finish_item(req);
  end
endtask : body



//parity seqs 2
class parity_2 extends base_seq;
  `uvm_object_utils(parity_2)
  extern function new(string name = "parity_2");
  extern task body();
endclass : parity_2

function parity_2::new(string name = "parity_2");
  super.new(name);
endfunction : new

task parity_2::body();
  req = xtn::type_id::create("req");

  // 1 LCR[7] = 1 so, the selecting of special register DL[MSB or LSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b1000_0000;});
  finish_item(req);

  // 2 DL MSB = 0 so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0000;});
  finish_item(req);

  // 3 DL LSB = 54[0011_0110] so, the selecting of special register DL[MSB]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0001_1010;});
  finish_item(req);

  // 4 LCR[7] = 0 so, the selecting of general register and [1,0] = 11 --> 8 data bits
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_1011;});
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0100;});
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b0000_0110;});
  finish_item(req);

  // 7 THR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; wb_dat_i == 8'b0000_1011;});
  finish_item(req);

  // 8 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
  finish_item(req);

  get_response(req);
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
    finish_item(req);
  end
endtask : body

// framing error seqs 1
class fr_seq_1 extends base_seq;
  `uvm_object_utils(fr_seq_1)
  extern function new(string name = "fr_seq_1");
  extern task body();
endclass : fr_seq_1

function fr_seq_1::new(string name = "fr_seq_1");
  super.new(name);
endfunction : new

task fr_seq_1::body();
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
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0100;});
    //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0100;});
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
    
  end
endtask : body

// framing error seqs 2
class fr_seq_2 extends base_seq;
  `uvm_object_utils(fr_seq_2)
  extern function new(string name = "fr_seq_2");
  extern task body();
endclass : fr_seq_2

function fr_seq_2::new(string name = "fr_seq_2");
  super.new(name);
endfunction : new

task fr_seq_2::body();
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
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0111;});
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
endtask : body

// THR Empty seqs 1
class thr_em_1 extends base_seq;
  `uvm_object_utils(thr_em_1)
  extern function new(string name = "thr_em_1");
  extern task body();
endclass : thr_em_1

function thr_em_1::new(string name = "thr_em_1");
  super.new(name);
endfunction : new

task thr_em_1::body();
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
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0010;});
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
    
  end
endtask : body

// THR Empty seqs 2
class thr_em_2 extends base_seq;
  `uvm_object_utils(thr_em_2)
  extern function new(string name = "thr_em_2");
  extern task body();
endclass : thr_em_2

function thr_em_2::new(string name = "thr_em_2");
  super.new(name);
endfunction : new

task thr_em_2::body();
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
  assert(req.randomize() with {wb_addr_i == 3; wb_we_i == 1; wb_dat_i == 8'b0000_0010;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 5 IER [Received Data available interrupt] 0 bit = 1 enabled
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0011;});
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  // 6 FCR [Received Data available interrupt] [10] bit = 11 [Tx,Rx]
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b1000_0110;});
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
endtask : body

// over run seqs 1
class orr_seq_1 extends base_seq;
  `uvm_object_utils(orr_seq_1)
  extern function new(string name = "orr_seq_1");
  extern task body();
endclass : orr_seq_1

function orr_seq_1::new(string name = "orr_seq_1");
  super.new(name);
endfunction : new

task orr_seq_1::body();
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
  assert(req.randomize() with {wb_addr_i == 1; wb_we_i == 1; wb_dat_i == 8'b0000_0100;});
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
    
  end
endtask : body

// over run seqs 2
class orr_seq_2 extends base_seq;
  `uvm_object_utils(orr_seq_2)
  extern function new(string name = "orr_seq_2");
  extern task body();
endclass : orr_seq_2

function orr_seq_2::new(string name = "orr_seq_2");
  super.new(name);
endfunction : new

task orr_seq_2::body();
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
  repeat(14)
  begin
    start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; });
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);
  end

  // 7 THR 
  repeat(3)
  begin
    start_item(req);
  assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 1; });
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);
  end

  // 8 IIR 
  start_item(req);
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 0; });
    //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
  finish_item(req);

  get_response(req);
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
endtask : body

// time out seqs 1
class ti_seq_1 extends base_seq;
  `uvm_object_utils(ti_seq_1)
  extern function new(string name = "ti_seq_1");
  extern task body();
endclass : ti_seq_1

function ti_seq_1::new(string name = "ti_seq_1");
  super.new(name);
endfunction : new

task ti_seq_1::body();
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
    
  end
endtask : body

// time out seqs 2
class ti_seq_2 extends base_seq;
  `uvm_object_utils(ti_seq_2)
  extern function new(string name = "ti_seq_2");
  extern task body();
endclass : ti_seq_2

function ti_seq_2::new(string name = "ti_seq_2");
  super.new(name);
endfunction : new

task ti_seq_2::body();
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
  assert(req.randomize() with {wb_addr_i == 2; wb_we_i == 1; wb_dat_i == 8'b1100_0110;});
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
  
  // 9 RB
  if(req.IIR[3:1] == 3'b010)
  begin
    //$display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 0; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_2",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end

  // 10 LSR
  if(req.IIR[3:1] == 3'b011)
  begin
   // $display("The Value Stored In IIR is %b", req.IIR);
    start_item(req);
    assert(req.randomize() with {wb_addr_i == 5; wb_we_i == 0; });
      //`uvm_info("full_duplex_seqs_1",$sformatf("Printing from uart_sequence \n %s",req.sprint()),UVM_LOW)
    finish_item(req);
  end
endtask : body