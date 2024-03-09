//---------------------------------------------------------------------------------------//
//---------------------------single_transfer------------------------
//---------------------------------------------------------------------------------------//

class w_r_test extends test;

	`uvm_component_utils(w_r_test)
virt_wr_sequence v_wr_seq;
extern function new(string name="w_r_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function w_r_test::new(string name="w_r_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void w_r_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task w_r_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  v_wr_seq=virt_wr_sequence::type_id::create("v_wr_seq");
  v_wr_seq.start(env.v_seqr);
  #100;
  phase.drop_objection(this);

endtask


