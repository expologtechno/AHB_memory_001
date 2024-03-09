//---------------------------------------------------------------------------------------//
//-------------------------------------- idle_test --------------------------------------//
//---------------------------------------------------------------------------------------//

class idle_test extends test;

  `uvm_component_utils(idle_test)

  virt_idle_seq    v_idle_seq_h;

  extern function new(string name="idle_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function idle_test::new(string name="idle_test", uvm_component parent);
  super.new(name,parent);
endfunction	

//************** build phase*************

function void idle_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************

task idle_test::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
    v_idle_seq_h = virt_idle_seq::type_id::create("v_idle_seq_h");
    v_idle_seq_h.start(env.v_seqr);
    #100;
  phase.drop_objection(this);

endtask

