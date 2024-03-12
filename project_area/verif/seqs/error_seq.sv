class error_seq extends ahb_sequence;

	`uvm_object_utils(error_seq)
extern function new(string name ="error_seq");
extern task body();

endclass
//--------------constructor--------------------------
function error_seq:: new(string name="error_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task error_seq::body();

	begin
		trans=ahb_transaction::type_id::create("trans");
	

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h8; 
							trans.size    == 3'h3; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

	


			start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h08; 
							trans.size    == 3'h3; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

	



				end

endtask


