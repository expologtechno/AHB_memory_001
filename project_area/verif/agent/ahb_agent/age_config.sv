/*********************AGENT_CONFIG********************/
class age_config extends uvm_object;
	`uvm_object_utils(age_config)
	virtual ahb_intf intf_h;

//----------CONSTRUCTOR----------------------	
 function new(string name="age_config");
	super.new(name);
endfunction

endclass	
