class env extends uvm_env;
  `uvm_component_utils(env)

  env_config e_cfg;
  agt_top agt_top_h;
  v_seqr v_seqr_h;
  scoreboard sb;

  extern function new(string name = "env", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : env

function env::new(string name = "env", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void env::build_phase(uvm_phase phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  if(e_cfg.has_agt_top)
    agt_top_h = agt_top::type_id::create("agt_top_h",this);

  if(e_cfg.has_virtual_sequencer)
    v_seqr_h = v_seqr::type_id::create("v_seqr_h",this);

  if(e_cfg.has_scoreboard)
    sb = scoreboard::type_id::create("sb",this);

endfunction : build_phase

function void env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(e_cfg.has_virtual_sequencer)
  begin
    if(e_cfg.has_agt_top)
    begin
      for(int i=0; i<e_cfg.no_of_agents; i++)
	v_seqr_h.seqr_h[i] = agt_top_h.agt_h[i].seqrh;
    end
  end

  if(e_cfg.has_scoreboard)
  begin
    if(e_cfg.has_agt_top)
    begin
      for(int i=0; i<e_cfg.no_of_agents; i++)
        agt_top_h.agt_h[i].mon_h.monitor_port.connect(sb.fifo_h[i].analysis_export);
    end
  end

endfunction : connect_phase
