class mon extends uvm_monitor;
  `uvm_component_utils(mon)
  virtual uart_if.MP_MON vif;
  agt_config m_cfg;
  xtn xtn_h;

  uvm_analysis_port #(xtn) monitor_port;

  extern function new(string name = "mon", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task collect_data();
endclass : mon

function mon::new(string name = "mon", uvm_component parent);
  super.new(name,parent);
  monitor_port = new("monitor_port",this);
endfunction : new

function void mon::build_phase(uvm_phase phase);
  if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void mon::connect_phase(uvm_phase phase);
  vif = m_cfg.vif;
endfunction : connect_phase

task mon::run_phase(uvm_phase phase);
  
  xtn_h = xtn::type_id::create("xtn_h");

  forever
    collect_data();
endtask : run_phase

task mon::collect_data();
  @(vif.mon_cb);
  wait(vif.mon_cb.wb_ack_i)
    xtn_h.wb_we_i = vif.mon_cb.wb_we_i;
    xtn_h.wb_addr_i = vif.mon_cb.wb_addr_i;
    xtn_h.wb_dat_i = vif.mon_cb.wb_dat_i;

    if(xtn_h.wb_addr_i == 3 && xtn_h.wb_we_i == 1)
        xtn_h.LCR = vif.mon_cb.wb_dat_i;

    if(xtn_h.wb_addr_i == 2 && xtn_h.wb_we_i == 1)
        xtn_h.FCR = vif.mon_cb.wb_dat_i;

    if(xtn_h.wb_addr_i == 1 && xtn_h.wb_we_i == 1 && xtn_h.LCR[7] == 0)
        xtn_h.IER = vif.mon_cb.wb_dat_i;

    //if(xtn_h.wb_addr_i == 4 && xtn_h.wb_we_i == 1)
      //  xtn_h.MSR = vif.mon_cb.wb_dat_i;

    if(xtn_h.wb_addr_i == 0 && xtn_h.wb_we_i == 1 && xtn_h.LCR[7] == 0)
        begin
          xtn_h.THR.push_back(vif.mon_cb.wb_dat_i);
          //$display("THR[0]");  
          //$display(xtn_h.THR[0]);
        end
        

    if(xtn_h.wb_addr_i == 0 && xtn_h.wb_we_i == 0 && xtn_h.LCR[7] == 0)
        begin
          xtn_h.RB.push_back(vif.mon_cb.wb_dat_o);
          //$display("RB[0]");  
          //$display(xtn_h.RB[0]);
        end

    if(xtn_h.wb_addr_i == 2 && xtn_h.wb_we_i == 0)
        begin
          wait(vif.mon_cb.int_o)
          @(vif.mon_cb);
          xtn_h.IIR = vif.mon_cb.wb_dat_o;
        end
    
    if(xtn_h.wb_addr_i == 5 && xtn_h.wb_we_i == 0)
        xtn_h.LSR = vif.mon_cb.wb_dat_o;
    
    `uvm_info("mon", $sformatf("received data \n %s", xtn_h.sprint()), UVM_LOW)
    monitor_port.write(xtn_h);    
endtask : collect_data