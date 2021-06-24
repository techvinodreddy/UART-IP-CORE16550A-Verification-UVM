class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(xtn) fifo_h[];
  xtn data1,data2;

  xtn data1_f,data2_f;

  env_config e_cfg;

  extern function new(string name = "scoreboard", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern function void check_phase(uvm_phase phase);

  covergroup data1_fcov;
    option.per_instance = 1;

    NO_OF_BITS : coverpoint data1_f.LCR[1:0]{
                                              bins bit_5 = {2'b00};
                                              bins bit_6 = {2'b01};
                                              bins bit_7 = {2'b10};
                                              bins bit_8 = {2'b11};
                                            }

    PARITY    : coverpoint data1_f.LCR[3:2]{
                                              bins no_parity = {2'b10,2'b00};
                                              bins even_parity = {2'b11};
                                              bins odd_parity = {2'b01};
                                            }

    BREAK_INTR: coverpoint data1_f.LCR[6]{ bins brk_int = {1}; }

    THR_EMPTY: coverpoint data1_f.IER[0]{ bins thr_empty = {1}; }

    //RECEIVED_DATA_AVAILABLE
		RECEIVED_DATA_AVAILABLE : coverpoint data1_f.IER[1] { bins rcvd_avl = {1};}
		
		//LINE_STATUS_INT
		LINE_STATUS_INT : coverpoint data1_f.IER[2] { bins lsr_int = {1};}
		
		//IIR_INT
		IIR_INT : coverpoint data1_f.IIR[3:1] { 
														bins rcv_line_status = {3'b011};
														bins rcv_data_avl = {3'b010};
														bins timeout_ind = {3'b110};
														bins thr_emty = {3'b001};
																					}
		
		//FCR_FIELD
		NO_OF_BYTES : coverpoint data1_f.FCR[7:6]{
														bins byt1 = {2'b00};
														bins byt4 = {2'b01};
														bins byt8 = {2'b10};
														bins byt14 = {2'b11};
																				}
																				
		//OVERRUN
		OVERRUN :  coverpoint data1_f.LSR[1] { bins overrun_err = {1};}
		
		//PARITY_ERR
		PARITY_ERR : coverpoint data1_f.LSR[2] { bins parity_err = {1};}
		
		//FRAMING_ERR
		FRAMING_ERR : coverpoint data1_f.LSR[3] { bins framing_err = {1};}

  endgroup : data1_fcov

  covergroup data2_fcov;
    option.per_instance = 1;

    NO_OF_BITS : coverpoint data2_f.LCR[1:0]{
                                              bins bit_5 = {2'b00};
                                              bins bit_6 = {2'b01};
                                              bins bit_7 = {2'b10};
                                              bins bit_8 = {2'b11};
                                            }

    PARITY    : coverpoint data2_f.LCR[3:2]{
                                              bins no_parity = {2'b10,2'b00};
                                              bins even_parity = {2'b11};
                                              bins odd_parity = {2'b01};
                                            }

    BREAK_INTR: coverpoint data2_f.LCR[6]{ bins brk_int = {1}; }

    THR_EMPTY: coverpoint data2_f.IER[0]{ bins thr_empty = {1}; }

    //RECEIVED_DATA_AVAILABLE
		RECEIVED_DATA_AVAILABLE : coverpoint data2_f.IER[1] { bins rcvd_avl = {1};}
		
		//LINE_STATUS_INT
		LINE_STATUS_INT : coverpoint data2_f.IER[2] { bins lsr_int = {1};}
		
		//IIR_INT
		IIR_INT : coverpoint data2_f.IIR[3:1] { 
														bins rcv_line_status = {3'b011};
														bins rcv_data_avl = {3'b010};
														bins timeout_ind = {3'b110};
														bins thr_emty = {3'b001};
																					}
		
		//FCR_FIELD
		NO_OF_BYTES : coverpoint data2_f.FCR[7:6]{
														bins byt1 = {2'b00};
														bins byt4 = {2'b01};
														bins byt8 = {2'b10};
														bins byt14 = {2'b11};
																				}
																				
		//OVERRUN
		OVERRUN :  coverpoint data2_f.LSR[1] { bins overrun_err = {1};}
		
		//PARITY_ERR
		PARITY_ERR : coverpoint data2_f.LSR[2] { bins parity_err = {1};}
		
		//FRAMING_ERR
		FRAMING_ERR : coverpoint data2_f.LSR[3] { bins framing_err = {1};}

  endgroup : data2_fcov
    
endclass : scoreboard

function scoreboard::new(string name = "scoreboard", uvm_component parent);
  super.new(name,parent);
  data1_fcov = new();
  data2_fcov = new();
endfunction : new

function void scoreboard::build_phase(uvm_phase phase);
  if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  fifo_h = new[e_cfg.no_of_agents];

  foreach(fifo_h[i])
    fifo_h[i] = new($sformatf("fifo_h[%0d]*",i),this);

  data1 = xtn::type_id::create("data1");
  data2 = xtn::type_id::create("data2");

endfunction : build_phase

task scoreboard::run_phase(uvm_phase phase);
  fork
    begin 
      forever 
      begin
        fifo_h[0].get(data1);
        //`uvm_info(get_type_name(), "data1", UVM_LOW)
        data1.print();
        data1_f = data1;
        data1_fcov.sample();
        
      end
    end

    begin 
      fifo_h[1].get(data2);
        //`uvm_info(get_type_name(), "data2", UVM_LOW)
        data2.print();
        data2_f = data2;
        data2_fcov.sample();
    end
  join
endtask : run_phase

function void scoreboard::check_phase(uvm_phase phase);
  $display("The Value In The Tx FIFO in DUT1 is : %0p ", data1.THR);
  $display("The Value In The Tx FIFO in DUT2 is : %0p ", data2.THR);
  $display("The Value In The Rx FIFO in DUT1 is : %0p ", data1.RB);
  $display("The Value In The Rx FIFO in DUT2 is : %0p ", data2.RB);

  $display("The Value in DUT1 IIR is : %b ", data1.IIR);
  $display("The Value in DUT2 IIR is : %b ", data2.IIR);
  
      if(data1.THR[0] == data1.RB[0])
    `uvm_info("UART 1", "Data Match in UART 1 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 1 UnSuccessfull", UVM_LOW)

      if(data2.THR[0] == data2.RB[0])
        `uvm_info("UART 2", "Data Match in UART 2 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 2 UnSuccessfull", UVM_LOW)
  


      if(data1.THR[0] == data2.RB[0])
    `uvm_info("UART 1", "Data Match in UART 1 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 1 UnSuccessfull", UVM_LOW)

      if(data2.THR[0] == data1.RB[0])
        `uvm_info("UART 2", "Data Match in UART 2 Successfull", UVM_LOW)
      else 
        `uvm_info(get_type_name(), "Data Match in UART 2 UnSuccessfull", UVM_LOW)    

endfunction : check_phase