//-------------------------------------------------------------------------------------------//
//-------------------------------------- mem_full_test --------------------------------------//
//-------------------------------------------------------------------------------------------//

class mem_full_test extends test;

  `uvm_component_utils(mem_full_test)

  virt_mem_full_seq    virt_mem_full_seq_h;

  extern function new(string name="mem_full_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass  

//*********** constructor****************

function mem_full_test::new(string name="mem_full_test", uvm_component parent);
  super.new(name,parent);
endfunction	

//************** build phase*************

function void mem_full_test:: build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction 

//*********** run phase****************

task mem_full_test::run_phase(uvm_phase phase);
  //super.run_phase(phase);
  `uvm_info("TEST","RUN_PHASE",UVM_MEDIUM)

  phase.raise_objection(this);
    virt_mem_full_seq_h = virt_mem_full_seq::type_id::create("virt_mem_full_seq_h");
    virt_mem_full_seq_h.start(env.v_seqr);
    phase.phase_done.set_drain_time(this, 100);
  phase.drop_objection(this);

endtask

