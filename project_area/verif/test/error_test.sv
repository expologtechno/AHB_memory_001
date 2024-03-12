class error_test extends test;

  `uvm_component_utils(error_test)

  virt_error_seq    v_error_seq_h;

  extern function new(string name="error_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function error_test::new(string name="error_test", uvm_component parent);
  super.new(name,parent);
endfunction	

//************** build phase*************

function void error_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************

task error_test::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
			`uvm_error(get_type_name(),"------ ::ERROR DETECTION TESTING:: ------")
    v_error_seq_h = virt_error_seq::type_id::create("v_error_seq_h");
    v_error_seq_h.start(env.v_seqr);
    #500;
  phase.drop_objection(this);

endtask
