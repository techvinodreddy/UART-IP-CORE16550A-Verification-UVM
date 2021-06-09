class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(xtn) fifo_h[];
  xtn data1,data2;

  env_config e_cfg;

  extern function new(string name = "scoreboard", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void check_phase(uvm_phase phase);


endclass : scoreboard

function scoreboard::new(string name = "scoreboard", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void scoreboard::build_phase(uvm_phase phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  fifo_h = new[e_cfg.no_of_agents];

  foreach(fifo_h[i])
    fifo_h[i] = new($sformatf("fifo_h[%0d]*",i),this);

  data1 = xtn::type_id::create("data1");
  data2 = xtn::type_id::create("data2");

endfunction : build_phase

task scoreboard::run_phase(uvm_phase phase);
  fork
    begin 
      forever 
      begin
        fifo_h[0].get(data1);
        //`uvm_info(get_type_name(), "data1", UVM_LOW)
        data1.print();
      end
    end

    begin 
      fifo_h[1].get(data2);
        //`uvm_info(get_type_name(), "data2", UVM_LOW)
        data2.print();
    end
  join
endtask : run_phase

function void scoreboard::check_phase(uvm_phase phase);
  $display("The Value In The Tx FIFO in DUT1 is : %0p \n", data1.THR[0]);
  $display("The Value In The Tx FIFO in DUT2 is : %0p \n", data2.THR[0]);
  $display("\n");
  $display("\n");
  $display("The Value In The Rx FIFO in DUT1 is : %0p \n", data1.RB[0]);
  $display("The Value In The Rx FIFO in DUT2 is : %0p \n", data2.RB[0]);

  $display(data1.MSR);
  $display(data2.MSR);


  if(data1.MSR[4] == 1 || data2.MSR[4] == 1)
    begin
      if(data1.THR[0] == data1.RB[0])
    `uvm_info("UART 1", "Data Match in UART 1 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 1 UnSuccessfull", UVM_LOW)

      if(data2.THR[0] == data2.RB[0])
        `uvm_info("UART 2", "Data Match in UART 2 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 2 UnSuccessfull", UVM_LOW)
    end

  else
    begin
      if(data1.THR[0] == data1.RB[0])
    `uvm_info("UART 1", "Data Match in UART 1 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 1 UnSuccessfull", UVM_LOW)

      if(data2.THR[0] == data2.RB[0])
        `uvm_info("UART 2", "Data Match in UART 2 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 2 UnSuccessfull", UVM_LOW)    
    end
endfunction : check_phase