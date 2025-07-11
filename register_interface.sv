//interface for the register agent.

//dut is a active low reset rst_n but ,the specification document not mentionted any syncgronous to clk or asychronous to clk.

interface register_interface(input logic clk,rst_n);
 
logic [2:0] addr;//address is required for both read and write operation.
  
//for writes to registers      
logic wr;
logic [7:0] wr_data;
  
//for to read the registers 
logic rd;
logic [7:0] rd_data;
       
//active low interrupt ,indicates rx packet  is available for read.
logic int_n;//interrupt signal  
  
//clocking block for the register_driver
  clocking  driver_cb@(posedge clk);
    default input#1 output#0;
    output addr;
    output wr;
    output wr_data;
    output rd;
    
    input rd_data;
    input int_n;
    
  endclocking:driver_cb
  
  //clocking block for the monitor
  clocking monitor_cb@(posedge clk);
    default input#1 output#0;
    input addr;
    input wr;
    input wr_data;
    input rd;
    input rd_data;
    input int_n;
  endclocking:monitor_cb
  
  modport driver_modp(clocking driver_cb,input clk,input rst_n);
  modport monitor_modp(clocking monitor_cb,input clk,input rst_n);
  
       
endinterface:register_interface