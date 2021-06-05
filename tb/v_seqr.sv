/* ---------------------------- sequencer ---------------------------------- */
class v_seqr extends uvm_sequencer #(uvm_sequence_item);
  `uvm_component_utils(v_seqr)  // factory registration

  seqr seqr_h[];
  env_config e_cfg;
  
  // --> Methods
  extern function new(string name = "v_seqr", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
endclass : v_seqr

/* ---------------------------- new ---------------------------------- */
function v_seqr::new(string name = "v_seqr", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void v_seqr::build_phase(uvm_phase phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  seqr_h = new[e_cfg.no_of_agents];
endfunction : build_phase
