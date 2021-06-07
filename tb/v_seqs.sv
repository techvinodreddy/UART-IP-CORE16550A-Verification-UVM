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

class v_fd_seq extends v_base_seq;
  `uvm_object_utils(v_fd_seq)

  fd_seq_1 fd_seq_1_h;
  fd_seq_2 fd_seq_2_h;

  extern function new(string name = "v_fd_seq");
  extern task body();
endclass : v_fd_seq

function v_fd_seq::new(string name = "v_fd_seq");
  super.new(name);
endfunction : new

task v_fd_seq::body();
  super.body();
  fd_seq_1_h = fd_seq_1::type_id::create("fd_seq_1_h");
  fd_seq_2_h = fd_seq_2::type_id::create("fd_seq_2_h");

  if(e_cfg.has_agt_top)
  fork
    fd_seq_1_h.start(seqr_h[0]);
    fd_seq_2_h.start(seqr_h[1]);
  join
endtask : body
