`uvm_analysis_imp_decl(_reg_mntr)
class scoreboard extends uvm_scoreboard;
  
//factory registration
  `uvm_component_utils(scoreboard)
//uvm analysis imp port declaration.
uvm_analysis_imp_reg_mntr#(register_seq_item,scoreboard) reg_mntr2scb;
  
//register transaction class handle declaration
  register_seq_item  reg_pkt_qu[$];  

  function new(string name,uvm_component parent);
    super.new(name,parent);
    reg_mntr2scb=new("reg_mntr2scb",this);
  endfunction:new

virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
// reg_mntr2scb=new("reg_mntr2scb",this);
endfunction:build_phase

  virtual function void write_reg_mntr(register_seq_item reg_pkt);
  `uvm_info(get_full_name(),{" SCOREBORAD GOT PKT FROM THE REGISTER_AGENT \n",reg_pkt.sprint()},UVM_NONE);
  endfunction:write_reg_mntr
  
endclass:scoreboard