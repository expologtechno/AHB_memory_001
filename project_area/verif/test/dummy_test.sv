////---------------------------------------------------------------------------------------//
////---------------------------dummy_test------------------------------------------------//
////---------------------------------------------------------------------------------------//

class dummy_test extends test;

	`uvm_component_utils(dummy_test)

virt_dummy_seq v_dummy_seq_h;


extern function new(string name="dummy_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function dummy_test::new(string name="dummy_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void dummy_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task dummy_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  v_dummy_seq_h=virt_dummy_seq::type_id::create("v_dummy_seq_h");
  v_dummy_seq_h.start(env.v_seqr);
  #500;
  phase.drop_objection(this);

endtask

