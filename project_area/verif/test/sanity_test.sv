////---------------------------------------------------------------------------------------//
////---------------------------sanity_test------------------------------------------------//
////---------------------------------------------------------------------------------------//

class sanity_test extends test;

	`uvm_component_utils(sanity_test)

virt_sanity_seq v_sanity_seq_h;
  //virt_reset_seq    v_reset_seq_h;


extern function new(string name="sanity_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function sanity_test::new(string name="sanity_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void sanity_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task sanity_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  v_sanity_seq_h=virt_sanity_seq::type_id::create("v_sanity_seq_h");
   // v_reset_seq_h=virt_reset_seq::type_id::create("v_reset_seq_h");
    //fork
   // v_reset_seq_h.start(env.v_seqr);
  v_sanity_seq_h.start(env.v_seqr);
  #500;
  //join
  phase.drop_objection(this);

endtask


