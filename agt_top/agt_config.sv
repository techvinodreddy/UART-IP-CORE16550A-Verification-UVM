/* ----------------------------- agent config class ----------------------- */
class agt_config extends uvm_object;
  `uvm_object_utils(agt_config) // factory registration

  virtual uart_if vif;  // interface as virtual
  // seting that to agent that it has active or passive agent
  uvm_active_passive_enum is_active = UVM_ACTIVE; 
  // for measureing tx and rx data cnt
  static int mon_rcvd_xtn_cnt = 0;  
  static int drv_data_sent_cnt = 0;
  //---> Method
  extern function new(string name = "agt_config");
endclass : agt_config

/* ----------------------------- new --------------------------------- */
function agt_config::new(string name = "agt_config");
  super.new(name);
endfunction : new
