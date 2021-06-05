class mon extends uvm_monitor;
  `uvm_component_utils(mon)
  virtual uart_if.MP_MON vif;
  agt_config m_cfg;
  xtn xtn_h;

  uvm_analysis_port #(xtn) monitor_port;

  extern function new(string name = "mon", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
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
