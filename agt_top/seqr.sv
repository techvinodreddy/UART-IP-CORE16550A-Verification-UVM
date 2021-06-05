/* ---------------------------- sequencer ---------------------------------- */
class seqr extends uvm_sequencer #(xtn);
  `uvm_component_utils(seqr)  // factory registration
  
  // --> Methods
  extern function new(string name = "seqr", uvm_component parent);
endclass : seqr

/* ---------------------------- new ---------------------------------- */
function seqr::new(string name = "seqr", uvm_component parent);
  super.new(name,parent);
endfunction : new
