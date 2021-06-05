/* ---------------------------- sequences ---------------------------------- */
// --> base sequence
class base_seq extends uvm_sequence #(xtn);
  `uvm_object_utils(base_seq) // factory registration
  // --> Methods
  extern function new(string name = "base_seq");
endclass : base_seq
/* ---------------------------- new ---------------------------------- */
function base_seq::new(string name = "base_seq");
  super.new(name);
endfunction : new
