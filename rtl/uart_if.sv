
/* ---------------------------- UART Interface ---------------------------------- */
interface uart_if(input bit clock);

    /* here
            i ------> input
            o ------> output
    */

/* ---------------------------- WishBone Interface ---------------------------------- */
    logic                wb_rst_i;       // Asynchronous Reset
    logic [2:0]    wb_addr_i;      // Used for register selection
    logic [3:0]     wb_sel_i;       // Select signal
    logic [7:0]     wb_dat_i;       // Data input
    logic [7:0]     wb_dat_o;       // Data output
    logic                wb_we_i;        // Write or read cycle clection
    logic                wb_stb_i;       // Specifies transfer cycle
    logic                wb_cyc_i;       // A bus cycle is in progress
    logic                wb_ack_i;       // Acknowledge of a transfer
    bit                  wb_clk_i;       // clock

/* ---------------------------- other Interface ---------------------------------- */
    logic           int_o;          // Interrupt output
    logic           baud_o;         // baud rate output signal

/* ---------------------------- External (off-chip) connections Interface ---------------------------------- */
    logic           stx_pad_o;      // The serial output signal
    logic           srx_pad_i;      // The serial input signal
    logic           rts_pad_o;      // Request to Send
    logic           dtr_pad_o;      // Data Terminal Ready
    logic           cts_pad_i;      // Clear To Send
    logic           dsr_pad_i;      // Data To Ready
    logic           ri_pad_i;       // Ring Indicator
    logic           dcd_pad_i;      // Data Carrier Detect

/* ---------------------------- clocking blocks ---------------------------------- */
    clocking drv_cb @(posedge clock);   // driver clocking block
        default input #1 output #1;
        output wb_addr_i;
        output wb_dat_i;
        output wb_we_i;
        output wb_sel_i;
        output wb_rst_i;
        output wb_cyc_i;
        output wb_stb_i;
        input wb_ack_i;
        input wb_dat_o;
        input int_o;
    endclocking : drv_cb

    clocking mon_cb @(posedge clock);   // monitor clocking block
        default input #1 output #1;
        input wb_addr_i;
        input wb_dat_i;
        input wb_we_i;
        input wb_sel_i;
        input wb_rst_i;
        input wb_cyc_i;
        input wb_stb_i;
        input wb_ack_i;
        input wb_dat_o;
        input int_o;
    endclocking : mon_cb

/* ---------------------------- modport ---------------------------------- */
    modport MP_DR(clocking drv_cb);    // driver modport
    modport MP_MON(clocking mon_cb);    // moitor modport

endinterface : uart_if
