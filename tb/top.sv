`timescale 1ns/10ps
module top;
  import test_pkg::*;
  import uvm_pkg::*;

  bit clock,clock1;
  always #10 clock = !clock;
  always #20 clock1 = !clock1;

  wire a,b;

  uart_if in1(clock);
  uart_if in2(clock1);

  uart_top DUT1(.wb_clk_i(clock),
                .wb_rst_i(in1.wb_rst_i),
                .wb_adr_i(in1.wb_addr_i),
                .wb_dat_i(in1.wb_dat_i),
                .wb_dat_o(in1.wb_dat_o),
                .wb_we_i(in1.wb_we_i),
                .wb_stb_i(in1.wb_stb_i),
                .wb_cyc_i(in1.wb_cyc_i),
                .wb_ack_o(in1.wb_ack_i),
                .wb_sel_i(in1.wb_sel_i),
                .int_o(in1.int_o),
                .stx_pad_o(a),
                .srx_pad_i(b),
                .rts_pad_o(in1.rts_pad_o),
                .cts_pad_i(in1.cts_pad_i),
                .dtr_pad_o(in1.dtr_pad_o),
                .dsr_pad_i(in1.dsr_pad_i),
                .ri_pad_i(in1.ri_pad_i),
                .dcd_pad_i(in1.dcd_pad_i),
                .baud_o(in1.baud_o));

  uart_top DUT2(.wb_clk_i(clock1),
                .wb_rst_i(in2.wb_rst_i),
                .wb_adr_i(in2.wb_addr_i),
                .wb_dat_i(in2.wb_dat_i),
                .wb_dat_o(in2.wb_dat_o),
                .wb_we_i(in2.wb_we_i),
                .wb_stb_i(in2.wb_stb_i),
                .wb_cyc_i(in2.wb_cyc_i),
                .wb_ack_o(in2.wb_ack_i),
                .wb_sel_i(in2.wb_sel_i),
                .int_o(in2.int_o),
                .stx_pad_o(b),.srx_pad_i(a),
                .rts_pad_o(in2.rts_pad_o),
                .cts_pad_i(in2.cts_pad_i),
                .dtr_pad_o(in2.dtr_pad_o),
                .dsr_pad_i(in2.dsr_pad_i),
                .ri_pad_i(in2.ri_pad_i),
                .dcd_pad_i(in2.dcd_pad_i),
                .baud_o(in2.baud_o));

  initial
  begin
          uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",in1);
          uvm_config_db #(virtual uart_if)::set(null,"*","vif_1",in2);

          run_test();
  end

endmodule
