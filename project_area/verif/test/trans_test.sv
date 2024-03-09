class trans_test extends test;

	`uvm_component_utils(trans_test)

virt_trans_seq v_trans_seq_h;


extern function new(string name="trans_test", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function trans_test::new(string name="trans_test", uvm_component parent);
  super.new(name,parent);
endfunction	


//************** build phase*************

function void trans_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************


task trans_test::run_phase(uvm_phase phase);
	super.run_phase(phase);
`uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
  v_trans_seq_h=virt_trans_seq::type_id::create("v_trans_seq_h");
  v_trans_seq_h.start(env.v_seqr);
  #100;
  phase.drop_objection(this);

endtask


