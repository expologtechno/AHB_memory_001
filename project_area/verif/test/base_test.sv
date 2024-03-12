
class base_test extends uvm_test;

`uvm_component_utils(base_test)

//ahb_sequence m_seq[5];


size_seq seq;
size0_seq seq0;
size1_seq seq1;


 ahb_env env;
  env_config         env_cn;
  age_config         age_cn;

  virtual ahb_intf   intf_h;

//*********** constructor****************

function new(string name="base_test", uvm_component parent);
  super.new(name,parent);
endfunction	

//************** build phase*************

function void  build_phase(uvm_phase phase);
  super.build_phase(phase);
  env    = ahb_env::type_id::create("env",this);
  env_cn = env_config::type_id::create("env_config",this);
  age_cn = age_config::type_id::create("age_cn",this);

  if (!uvm_config_db #(virtual ahb_intf)::get(this,"*","ahb_intf",age_cn.intf_h))
     `uvm_fatal("VIRTUAL_INTF","in ahb_test");
  env_cn.age_cn = age_cn;
  uvm_config_db #(env_config)::set(null,"*","env_config",env_cn);
endfunction 

virtual task cfg_arb_mode;
endtask





//*********** run phase****************

/*task run_phase(uvm_phase phase);
 string s_name;
    super.run_phase(phase);
    phase.raise_objection(this);
    cfg_arb_mode();
    `uvm_info(get_name, $sformatf("Arbitration mode = %s", env.age.sequencer.get_arbitration()), UVM_LOW);
    foreach(m_seq[i]) begin
      automatic int j = i;
      fork
      begin
        s_name = $sformatf("seq[%0d]", j);
        m_seq[j] = ahb_sequence::type_id::create(s_name);    
        m_seq[j].start(env.age.sequencer, .this_priority((j+1)*100)); // priority is mentioned as 100, 200, 300, 400, 500 for j = 0,1,2,3,4
      end
      join_none
    end
    wait fork;
    
    phase.drop_objection(this);
endtask*/


task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    cfg_arb_mode();
    `uvm_info(get_name, $sformatf("Arbitration mode = %s", env.age.sequencer.get_arbitration()), UVM_LOW);
	seq=size_seq::type_id::create("seq");
	seq0=size0_seq::type_id::create("seq0");
	seq1=size1_seq::type_id::create("seq1");

fork
//begin

        //seq.start(env.age.sequencer);
       //seq0.start(env.age.sequencer); 
       //seq1.start(env.age.sequencer); 
//if ($test$plusargs("WITH_PRI")) begin
        seq.start(env.age.sequencer, .this_priority(400)); 
	seq0.start(env.age.sequencer, .this_priority(800)); 
	seq1.start(env.age.sequencer, .this_priority(600)); 
//end
//end
join
//wait fork;
    phase.drop_objection(this);
endtask




//-------------------end_of_elaboration---------------------------
function void end_of_elaboration_phase(uvm_phase phase);
  uvm_top.print_topology();
endfunction
endclass


