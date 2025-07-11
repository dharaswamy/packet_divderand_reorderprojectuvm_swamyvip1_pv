class register_environment extends uvm_env;

  //factory registration
  `uvm_component_utils(register_environment)
  
  //register agent class handle declaration.
  register_agent reg_agent;
  
  //register configuration agent class handle declaration.
  register_config_agent reg_cfg_agent;
  
  //scorboard class handle declaration.
  scoreboard scb;
  
  //default construnctor
  function new(string name ,uvm_component parent);
    super.new(name,parent);
  endfunction:new
  
  //build phase for agent components creation.
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //register agent creation.
    reg_cfg_agent =register_config_agent::type_id::create("reg_cfg_agent");
     uvm_config_db#(register_config_agent)::set(this,"*","reg_cfg_agent",reg_cfg_agent);
    reg_agent=register_agent::type_id::create("reg_agent",this);
    scb=scoreboard::type_id::create("scb",this);
   
  endfunction:build_phase
  
//connect phase for connecting the analysis ports between the components.
  virtual function void connect_phase(uvm_phase phase);
    //super.build_phase(phase);
    super.connect_phase(phase);
    //connecting the reg_mntr to scb for sending the transactions through analysis ports.
    //here reg_agent analysis port already connected to the reg_mntr analysis port.
    reg_agent.item_collected_port.connect(scb.reg_mntr2scb);
  endfunction:connect_phase
  
endclass:register_environment