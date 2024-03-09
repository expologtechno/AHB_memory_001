
class test extends uvm_test;
  `uvm_component_utils(test)

  virtual ahb_intf   intf_h;
  ahb_env            env;
  env_config         env_cn;
  //ahb_agent        age;
  age_config         age_cn;
  virtual_sequence   v_seq;
  //page_config      page_cn;   //PASSIVE
	 
  extern function new(string name="test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass

//------------------CONSTRUCTOR----------------------

function test:: new(string name="test",uvm_component parent);
  super.new(name,parent);
endfunction

//------------BUILD PHASE------------
function void test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("TEST",$sformatf("ENTERED TEST"),UVM_MEDIUM)
  
  env    = ahb_env::type_id::create("env",this);
  env_cn = env_config::type_id::create("env_config",this);
  age_cn = age_config::type_id::create("age_cn",this);
  //page_cn=page_config::type_id::create("page_cn",this);  //PASSIVE
  v_seq  = virtual_sequence::type_id::create("v_seq",this);
  
  if (!uvm_config_db #(virtual ahb_intf)::get(this,"*","ahb_intf",age_cn.intf_h))
     `uvm_fatal("VIRTUAL_INTF","in ahb_test");
  
  //if (!uvm_config_db #(virtual ahb_intf)::get(this,"*","ahb_intf",page_cn.intf_h))  //PASSIVE
  //   `uvm_fatal("VIRTUAL_INTF","in ahb_test");
  
  env_cn.age_cn = age_cn;
  //env_cn.page_cn = page_cn;                       //PASSIVE

  uvm_config_db #(env_config)::set(null,"*","env_config",env_cn);

endfunction


//-------------------end_of_elaboration---------------------------
function void test::end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction




