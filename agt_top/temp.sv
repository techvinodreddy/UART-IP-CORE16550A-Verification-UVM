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
