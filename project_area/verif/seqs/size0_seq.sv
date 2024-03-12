//---------------------------------------------------------------------------------------//
/*------------------------------size0_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class size0_seq extends ahb_sequence;

	`uvm_object_utils(size0_seq)
extern function new(string name ="size0_seq");
extern task body();

endclass
//--------------constructor--------------------------
function size0_seq:: new(string name="size0_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task size0_seq::body();
	`uvm_info(get_name(),$sformatf("SIZE0_STARTED"),UVM_LOW)
begin
		trans=ahb_transaction::type_id::create("trans");
	

	for(int i=0; i<4; i++)begin
			start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h1;  
		       					trans.addr[0] == i; 
							trans.size    == 3'h0; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 16'h1;  
		       					trans.addr[0] == i; 
							trans.size    == 3'h0; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
	end



		end	
	`uvm_info(get_name(),$sformatf("SIZE0_ENDED"),UVM_LOW)
endtask
