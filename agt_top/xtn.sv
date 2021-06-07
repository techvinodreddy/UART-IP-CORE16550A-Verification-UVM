
/* ---------------------------- xtn [Transaction] ---------------------------------- */
class xtn extends uvm_sequence_item;
    `uvm_object_utils(xtn)  // factory registration

  // --> Members
    rand logic [7:0]  wb_dat_i;    // 1  8 --> data bus select
    rand logic [2:0] wb_addr_i;   // 2
    rand logic             wb_we_i;     // 3
    

  // --> Internal Registers
    bit [7:0]IER;   // Interrupt Enable Register (IER)            1
    bit [7:0]IIR;   // Interrupt Identification Register (IIR)    2
    bit [7:0]FCR;   // FIFO Control Register (FCR)                3
    bit [7:0]LCR;   // Line Control Register (LCR)                4
    bit [7:0]LSR;   // Line Status Register (LSR)                 5
    bit [7:0]MCR;   // Modem Control Register (MCR)               6
    bit [7:0]MSR;   // Modem Status Register (MSR)                8
    bit [7:0]DL;    // Divisor Latches (DL)                       8
    bit [7:0]DL1;   // Divisor Latches (DL) [MSB]                 9
    bit [7:0]DL2;   // Divisor Latches (DL) [LSB]                 10
    bit [7:0]THR[$];// Transmittier Holding Register              11
    bit [7:0]RB[$]; // Readable Buffer                            12

  // --> Methods
    extern function new(string name = "xtn");
    extern function void do_print(uvm_printer printer);
endclass : xtn

/* ---------------------------- new ---------------------------------- */
function xtn::new(string name = "xtn");
    super.new(name);
endfunction : new

/* ---------------------------- do_print ---------------------------------- */
function void xtn::do_print(uvm_printer printer);
  super.do_print(printer);

  // --> printing transaction data
    printer.print_field("wb_dat_i",   this.wb_dat_i,   8, UVM_DEC);
    printer.print_field("wb_addr_i",  this.wb_addr_i,  3, UVM_DEC);
    printer.print_field("wb_we_i",    this.wb_we_i,    1, UVM_DEC);

    foreach(THR[i])
      printer.print_field($sformatf("THR[%0d]",i),  this.THR[i],  8, UVM_DEC);

    foreach(RB[i])
      printer.print_field($sformatf("RB[%0d]",i),   this.RB[i],   8, UVM_DEC);

    printer.print_field("LCR",        this.LCR,        8, UVM_DEC);
    printer.print_field("MCR",        this.MCR,        8, UVM_DEC);
    printer.print_field("MSR",        this.MSR,        8, UVM_DEC);
    printer.print_field("LSR",        this.LSR,        8, UVM_DEC);
    printer.print_field("FCR",        this.FCR,        8, UVM_DEC);
    printer.print_field("IIR",        this.IIR,        8, UVM_DEC);
    printer.print_field("IER",        this.IER,        8, UVM_DEC);
    printer.print_field("DL1",        this.DL1,        8, UVM_DEC);
    printer.print_field("DL2",        this.DL2,        8, UVM_DEC);

endfunction : do_print

/* ---------------------------- Registers Theory [START]----------------------------------

        Interrupt Enable Register (IER)
            This register allows enabling and disabling interrupt generation by the UART.

        Interrupt Identification Register (IIR)
            The IIR enables the programmer to retrieve what is the current highest priority pending interrupt

        FIFO Control Register (FCR)
            The FCR allows selection of the FIFO trigger level (the number of bytes in FIFO required to enable the Received Data Available interrupt).
            In addition, the FIFOs can be cleared using this register.

        Line Control Register (LCR)
            The line control register allows the specification of the format of the asynchronous data communication used.
            A bit in the register also allows access to the Divisor Latches, which define the baud rate.
            Reading from the register is allowed to check the current settings of the communication.

        Line Status Register (LSR)

        Modem Control Register (MCR)
            The modem control register allows transferring control signals to a modem connected to the UART.

        Modem Status Register (MSR)
            The register displays the current state of the modem control lines.
            Also, four bits also provide an indication in the state of one of the modem status lines.
            These bits are set to ‘1’ when a change in corresponding line has been detected and they are reset when the register is being read.

        Divisor Latches (DL)
            The divisor latches can be accessed by setting the 7th bit of LCR to ‘1’.
            You should restore this bit to ‘0’ after setting the divisor latches in order to restore access to the other registers, that occupy the same 3esses.
            The 2 bytes form one 16-bit register, which is internally accessed as a single number.
            You should therefore set all 2 bytes of the register to ensure normal operation.
            The register is set to the default value of 0 on reset, which disables all serial I/O operations in order to ensure explicit setup of the register in the software.
            The value set should be equal to (system clock speed) / (16 x desired baud rate).
            The internal counter starts to work when the LSB of DL is written, so when setting the divisor, write the MSB first and the LSB last.

        Debug 1 & Debug 2
            This register is only available when the core has 32-bit data bus and 5-bit 3ess bus.
            It is read only and is provided for debugging purposes of chip testing as it is not part of the original UART16550 device specifications.
            Reading from the does not influence core’s bahaviour.

 ---------------------------- Registers Theory [END]---------------------------------- */
