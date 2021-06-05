/* ----------------------------- agent config class ----------------------- */
class env_config extends uvm_object;
  `uvm_object_utils(env_config) // factory registration

  bit has_functional_coverage = 0;
  bit has_scoreboard = 1;
  bit has_agt_top = 1;
  bit has_virtual_sequencer = 1;
  int no_of_agents = 2;

  agt_config m_agt_cfg[];
  //---> Method
  extern function new(string name = "env_config");
endclass : env_config

/* ----------------------------- new --------------------------------- */
function env_config::new(string name = "env_config");
  super.new(name);
endfunction : new
