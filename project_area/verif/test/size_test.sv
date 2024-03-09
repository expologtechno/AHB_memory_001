//---------------------------------------------------------------------------------------//
//---------------------------single_transfer------------------------
//---------------------------------------------------------------------------------------//

class size_test extends test;

	`uvm_component_utils(size_test)
virt_size_seq virt_size_seq_h;
extern function new(string name="size_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function size_test::new(string name="size_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void size_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task size_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  virt_size_seq_h=virt_size_seq::type_id::create("virt_size_seq_h");
  virt_size_seq_h.start(env.v_seqr);
  #100;
  phase.drop_objection(this);

endtask
