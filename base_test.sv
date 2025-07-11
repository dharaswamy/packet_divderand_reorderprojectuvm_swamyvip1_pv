class base_test extends uvm_test;
  //factory registration.
  `uvm_component_utils(base_test)
  
  //environment class handle declaration
  register_environment reg_env;
  
  //factory print and topology print 
  uvm_factory factory;
  uvm_coreservice_t cs=uvm_coreservice_t::get();
  
  
  //default constructor
  function new(string name,uvm_component parent);
  super.new(name,parent);
  endfunction:new

  //build phase for the creation of environments
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //register environment class creation.
    reg_env=register_environment::type_id::create("reg_env",this);
  endfunction:build_phase
  
  //end_of_elaboration_phase for any final adjustments in components before going of start_run_phase.
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    this.print();
    factory=cs.get_factory();
    factory.print();
  endfunction:end_of_elaboration_phase
  
  //start of simulation phase
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    uvm_top.print_topology();
  endfunction:start_of_simulation_phase
  
endclass:base_test