//---------------------------------------------------------------------------------------//
//--------------------------------- multiple write_test ---------------------------------//
//---------------------------------------------------------------------------------------//

class mul_w_test extends test;

  `uvm_component_utils(mul_w_test)

  virt_mul_w_seq    v_mul_w_seq_h;

  extern function new(string name="mul_w_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function mul_w_test::new(string name="mul_w_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void mul_w_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************

task mul_w_test::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
    v_mul_w_seq_h=virt_mul_w_seq::type_id::create("v_mul_w_seq_h");
    v_mul_w_seq_h.start(env.v_seqr);
    //#100;
    phase.phase_done.set_drain_time(this, 100);
  phase.drop_objection(this);

endtask
