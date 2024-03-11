//---------------------------------------------------------------------------------------//
/*------------------------------size1_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class size1_seq extends ahb_sequence;

	`uvm_object_utils(size1_seq)
extern function new(string name ="size1_seq");
extern task body();

endclass
//--------------constructor--------------------------
function size1_seq:: new(string name="size1_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task size1_seq::body();
begin
		trans=ahb_transaction::type_id::create("trans");
	


		for(int i=0; i<4; i = i+2)begin
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h1;  
		       					trans.addr[0] == i; 
							trans.size    == 3'h1; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 16'h1;  
		       					trans.addr[0] == i; 
							trans.size    == 3'h1; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
	end
end	
	
endtask
