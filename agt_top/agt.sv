class agt extends uvm_agent;
  `uvm_component_utils(agt)

  agt_config m_cfg;
  drv drv_h;
  mon mon_h;
  seqr seqrh;

  extern function new(string name = "agt", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : agt

function agt::new(string name = "agt", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void agt::build_phase(uvm_phase phase);
  if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);
  mon_h = mon::type_id::create("mon_h",this);

  if(m_cfg.is_active==UVM_ACTIVE)
  begin
    drv_h = drv::type_id::create("drv_h",this);
    seqrh = seqr::type_id::create("seqrh",this);
  end
endfunction : build_phase

function void agt::connect_phase(uvm_phase phase);
  if(m_cfg.is_active==UVM_ACTIVE)
    drv_h.seq_item_port.connect(seqrh.seq_item_export);
endfunction : connect_phase
