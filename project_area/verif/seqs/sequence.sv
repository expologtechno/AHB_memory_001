/*****************SEQUENCE***********************/

class ahb_sequence extends uvm_sequence#(ahb_transaction);
	`uvm_object_utils(ahb_sequence)
	
	ahb_transaction trans;
	age_config age_cn;

//----------------------constructor-------------------------------
function new(string name ="ahb_sequence");
	super.new(name);
endfunction


task pre_body();
    if(starting_phase != null) starting_phase.raise_objection(this);
  endtask

  task post_body();
    if(starting_phase != null) starting_phase.drop_objection(this);
  endtask
endclass



