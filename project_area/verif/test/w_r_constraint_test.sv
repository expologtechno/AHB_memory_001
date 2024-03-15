//---------------------------------------------------------------------------------------//
//---------------------------single_transfer------------------------
//---------------------------------------------------------------------------------------//

class w_r_constraint_test extends test;

	`uvm_component_utils(w_r_constraint_test)
virt_wr_con_sequence virt_wr_con_sequence_h;
extern function new(string name="w_r_constraint_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function w_r_constraint_test::new(string name="w_r_constraint_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void w_r_constraint_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task w_r_constraint_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  virt_wr_con_sequence_h=virt_wr_con_sequence::type_id::create("virt_wr_con_sequence_h");
  virt_wr_con_sequence_h.start(env.v_seqr);
  #100;
  phase.drop_objection(this);

endtask
