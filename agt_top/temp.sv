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