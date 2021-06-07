/* ------------------------------ driver class ------------------------------- */
class drv extends uvm_driver #(xtn);
  `uvm_component_utils(drv)
  virtual uart_if.MP_DR vif;
  agt_config m_cfg;

  extern function new(string name = "drv", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task send_to_dut(xtn xtn_h);
  extern task run_phase(uvm_phase phase);

endclass : drv

function drv::new(string name = "drv", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void drv::build_phase(uvm_phase phase);
  if(!uvm_config_db #(agt_config)::get(this,"","agt_config",m_cfg))
    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void drv::connect_phase(uvm_phase phase);
  vif = m_cfg.vif;
endfunction : connect_phase

task drv::send_to_dut(xtn xtn_h);
  //`uvm_info("[drv]",$sformatf("Printing from Uart_Driver \n %s",xtn_h.sprint()),UVM_LOW)
  
  @(vif.drv_cb);
  vif.drv_cb.wb_we_i <= xtn_h.wb_we_i;
  vif.drv_cb.wb_addr_i <= xtn_h.wb_addr_i;
  vif.drv_cb.wb_dat_i <= xtn_h.wb_dat_i;
  vif.drv_cb.wb_stb_i <= 1'b1;
  vif.drv_cb.wb_cyc_i <= 1'b1;
  vif.drv_cb.wb_sel_i <= 4'b0001;
  

  wait(vif.drv_cb.wb_ack_i)
    vif.drv_cb.wb_stb_i <= 1'b0;
    vif.drv_cb.wb_cyc_i <= 1'b0;

  if(xtn_h.wb_addr_i == 2 && xtn_h.wb_we_i == 0)
  begin
    wait(vif.drv_cb.int_o)
      @(vif.drv_cb);
      xtn_h.IIR = vif.drv_cb.wb_dat_o;
      $display("DRIVER The value IIR received from dut is %b", vif.drv_cb.wb_dat_o);
      seq_item_port.put_response(xtn_h);
  end

  
endtask : send_to_dut

task drv::run_phase(uvm_phase phase);
  //super.run_phase(phase);

  @(vif.drv_cb);
  vif.drv_cb.wb_rst_i <= 1'b1;
  @(vif.drv_cb);
  vif.drv_cb.wb_rst_i <= 1'b0;

  forever
  begin
    seq_item_port.get_next_item(req);
      send_to_dut(req);
    seq_item_port.item_done;
  end

endtask : run_phase