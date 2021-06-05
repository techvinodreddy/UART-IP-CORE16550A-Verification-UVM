class agt_top extends uvm_agent;
  `uvm_component_utils(agt_top)

  env_config e_cfg;
  agt agt_h[];

  extern function new(string name = "agt_top", uvm_component parent);
  extern function void build_phase(uvm_phase phase);

endclass : agt_top

function agt_top::new(string name = "agt_top", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void agt_top::build_phase(uvm_phase phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  if(e_cfg.has_agt_top)
  begin
    agt_h = new[e_cfg.no_of_agents];	// agt_h[0]; agt_h[1];
    foreach(agt_h[i])
    begin
      uvm_config_db #(agt_config)::set(this,$sformatf("agt_h[%0d]*",i),"agt_config",e_cfg.m_agt_cfg[i]);
      agt_h[i] = agt::type_id::create($sformatf("agt_h[%0d]",i),this);
    end
  end
endfunction : build_phase
