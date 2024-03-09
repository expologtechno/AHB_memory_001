////---------------------------------------------------------------------------------------//
////---------------------------wait_test------------------------------------------------//
////---------------------------------------------------------------------------------------//

class wait_test extends test;

	`uvm_component_utils(wait_test)

virt_wait_seq v_wait_seq_h;


extern function new(string name="wait_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function wait_test::new(string name="wait_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void wait_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task wait_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  v_wait_seq_h=virt_wait_seq::type_id::create("v_wait_seq_h");
  v_wait_seq_h.start(env.v_seqr);
  #100;
  phase.drop_objection(this);

endtask



