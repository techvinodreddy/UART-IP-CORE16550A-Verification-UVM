class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(xtn) fifo_h[];
  xtn data1,data2;

  env_config e_cfg;

  extern function new(string name = "scoreboard", uvm_component parent);
  extern function void build_phase(uvm_phase phase);


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
