
// Eda link : https://www.edaplayground.com/x/pjcZ 

// ( swamy ) please copy the code but don't change/modify the code here.

//====================================================================================================================

// project name: packet_divider_and reorder logic 
// Description : this project have 3 agents ,1.register agent,2.transmit_agent,3.recieve_agent.
// but this one vip1(register_agent) for the register configuration(one agent for the register configuration,this is the register_agent. ) in this project.
// IN this environment have scoreboard ,just for the samples sending from monitor to the scoreboard.
// and this is noted in my eda link list.

//====================================================================================================================


`include "uvm_macros.svh"
import uvm_pkg::*;
`include "register_interface.sv"
`include "register_seq_item.sv"
`include "register_sequencer.sv"
`include "register_base_sequence.sv"
`include "register_driver.sv"
`include "register_monitor.sv"
`include "register_config_agent.sv"
`include "register_agent.sv"
`include "scoreboard.sv"
`include "register_environment.sv"
`include "base_test.sv"
`include "ctrl_test.sv"


module  tb_top_packet_divider;


  
bit clk;
bit rst_n;//active low reset.
int freq;
real h_time_p;
  

  
//clock generation with specified freq(in spec is mentioned operating frequency between the "10 to 20 mhz " 
task  clk_gen(input int freq,output real h_time_p);  
real time_p;
real freq_mhz;
freq_mhz=(1000_000)*(freq);//or freq_mhz=((10**6)*(freq));given freq hz into freq in mhz conversion.
time_p =(1.0/freq_mhz)*(1000_000_000);//or time_p=(1.0/freq_mhz)*(10**9);//time_p comes in nane seconds.
h_time_p=(time_p/2);
`uvm_info("clock_gen",$sformatf(" freq_mhz=%0g time_p=%0g  h_time_p=%0g ",freq_mhz,time_p,h_time_p),UVM_NONE); 
endtask:clk_gen

initial begin
freq=$urandom_range(10,20);
`uvm_info("clk_gen_freq",$sformatf("value of freq=%0d ",freq),UVM_NONE);
clk_gen(freq,h_time_p);
   
end
  
initial begin
forever #h_time_p clk=~clk;
end

  
//reset signal generation
initial begin 
rst_n =1'b1;//because the dut is a active low reset.
#60;
rst_n = 1'b0;//active low reset 
#290;
rst_n = 1'b1;
  
end
  

  

//register interface instantiation
  register_interface reg_vintf(clk,rst_n);
  

  
  initial begin
    uvm_config_db#(virtual register_interface)::set(null,"*","reg_vintf",reg_vintf);
    run_test("base_test");
  end
  
initial begin
reg_vintf.rd_data =8'h4f;
#50;
reg_vintf.rd_data =8'hff;
#500;
reg_vintf.rd_data =8'h78;  
end
  
  
initial begin
static  int delay =300;
  forever begin
if(reg_vintf.addr == 0) begin
  if(reg_vintf.wr_data == 1) begin
    #10;
   reg_vintf.rd_data = 8'h5f;
  #delay;
  reg_vintf.rd_data = 8'h34;
  delay=(delay)+50;
  end
end
#10;
end
end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule:tb_top_packet_divider