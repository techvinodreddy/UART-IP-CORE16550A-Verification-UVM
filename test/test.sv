class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  env env_h;
  env_config e_cfg;
  agt_config m_agt_cfg[];

  bit has_functional_coverage = 0;
  bit has_scoreboard = 1;
  bit has_agt_top = 1;
  bit has_virtual_sequencer = 1;
  int no_of_agents = 2;

  extern function new(string name = "base_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void config_uart();
  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : base_test

function base_test::new(string name = "base_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void base_test::config_uart;
  if(has_agt_top)
  begin
    m_agt_cfg = new[no_of_agents];
    foreach(m_agt_cfg[i])
    begin
      m_agt_cfg[i] = agt_config::type_id::create($sformatf("m_agt_cfg[%0d]",i));

      if(!uvm_config_db #(virtual uart_if)::get(this,"",$sformatf("vif_%0d",i),m_agt_cfg[i].vif))
        `uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db. Have you set() it?")

      e_cfg.m_agt_cfg[i] = m_agt_cfg[i];
    end
  end
  e_cfg.has_agt_top = has_agt_top;
  e_cfg.has_functional_coverage = has_functional_coverage;
  e_cfg.has_scoreboard = has_scoreboard;
  e_cfg.has_virtual_sequencer = has_virtual_sequencer;
endfunction : config_uart


function void base_test::build_phase(uvm_phase phase);

  e_cfg=env_config::type_id::create("e_cfg");

  if(has_agt_top)
    e_cfg.m_agt_cfg = new[no_of_agents];

    config_uart();

    uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);

    //super.build();
    super.build_phase(phase);
    env_h = env::type_id::create("env_h",this);

endfunction : build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology;
endfunction : end_of_elaboration_phase

// ful duplex sequence test
class fd_test extends base_test;
  `uvm_component_utils(fd_test)

  v_fd_seq v_fd_seq_h;

  extern function new(string name = "fd_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : fd_test

function fd_test::new(string name = "fd_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void fd_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task fd_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_fd_seq_h = v_fd_seq::type_id::create("v_fd_seq_h");
  v_fd_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase

// half duplex sequence test
class hd_test extends base_test;
  `uvm_component_utils(hd_test)

  v_hd_seq v_hd_seq_h;

  extern function new(string name = "hd_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : hd_test

function hd_test::new(string name = "hd_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void hd_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task hd_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_hd_seq_h = v_hd_seq::type_id::create("v_hd_seq_h");
  v_hd_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase

// loop back sequence test
class lb_test extends base_test;
  `uvm_component_utils(lb_test)

  v_lb_seq v_lb_seq_h;

  extern function new(string name = "lb_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : lb_test

function lb_test::new(string name = "lb_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void lb_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task lb_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_lb_seq_h = v_lb_seq::type_id::create("v_lb_seq_h");
  v_lb_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase

// parity sequence test
class parity_test extends base_test;
  `uvm_component_utils(parity_test)

  v_pr_seq v_pr_seq_h;

  extern function new(string name = "parity_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : parity_test

function parity_test::new(string name = "parity_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void parity_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task parity_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_pr_seq_h = v_pr_seq::type_id::create("v_pr_seq_h");
  v_pr_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase

// parity sequence test
class framing_test extends base_test;
  `uvm_component_utils(framing_test)

  v_fr_seq v_fr_seq_h;

  extern function new(string name = "framing_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : framing_test

function framing_test::new(string name = "framing_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void framing_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task framing_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_fr_seq_h = v_fr_seq::type_id::create("v_fr_seq_h");
  v_fr_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase

// thr empty test
class thr_empty_test extends base_test;
  `uvm_component_utils(thr_empty_test)

  v_thr_em v_fr_seq_h;

  extern function new(string name = "thr_empty_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : thr_empty_test

function thr_empty_test::new(string name = "thr_empty_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void thr_empty_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task thr_empty_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_fr_seq_h = v_thr_em::type_id::create("v_fr_seq_h");
  v_fr_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase

// thr empty test
class orr_test extends base_test;
  `uvm_component_utils(orr_test)

  v_orr v_fr_seq_h;

  extern function new(string name = "orr_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : orr_test

function orr_test::new(string name = "orr_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void orr_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task orr_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_fr_seq_h = v_orr::type_id::create("v_fr_seq_h");
  v_fr_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase


// thr empty test
class timeout_test extends base_test;
  `uvm_component_utils(timeout_test)

  v_ti v_fr_seq_h;

  extern function new(string name = "timeout_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass : timeout_test

function timeout_test::new(string name = "timeout_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void timeout_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

task timeout_test::run_phase(uvm_phase phase);
  $display("before objection raised");
  phase.raise_objection(this);
  v_fr_seq_h = v_ti::type_id::create("v_fr_seq_h");
  v_fr_seq_h.start(env_h.v_seqr_h);
  phase.drop_objection(this);
  $display("objection drouped");
endtask : run_phase