/* ------------------------------ driver class ------------------------------- */
class drv extends uvm_driver #(xtn);
  `uvm_component_utils(drv)
  virtual uart_if.MP_DR vif;
  agt_config m_cfg;

  extern function new(string name = "drv", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);


endclass : drv

function drv::new(string name = "drv", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void drv::build_phase(uvm_phase phase);
  if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void drv::connect_phase(uvm_phase phase);
  vif = m_cfg.vif;
endfunction : connect_phase
