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
endfunction:end_of_elaboration_phase
