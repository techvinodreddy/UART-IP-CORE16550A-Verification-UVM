class v_base_seq extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(v_base_seq)

  seqr seqr_h[];
  v_seqr v_seqr_h;
  env_config e_cfg;

  extern function new(string name = "v_base_seq");
  extern task body();
endclass : v_base_seq

function v_base_seq::new(string name = "v_base_seq");
  super.new(name);
endfunction : new

task v_base_seq::body();
  if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set it?")

  seqr_h = new[e_cfg.no_of_agents];

  assert($cast(v_seqr_h, m_sequencer))

  else
    `uvm_error("BODY", "Erroe in $cast of virtual sequencer")

  foreach(seqr_h[i])
    seqr_h[i] = v_seqr_h.seqr_h[i];

endtask : body
