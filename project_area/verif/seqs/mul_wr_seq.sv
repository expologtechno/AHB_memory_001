//---------------------------------------------------------------------------------------//
//---------------------------------- MULTIPLR_WRITE-------------------------------------/
//---------------------------------------------------------------------------------------//
class mul_w_seq extends ahb_sequence;

	`uvm_object_utils(mul_w_seq)


extern function new(string name ="mul_w_seq");
extern task body();

endclass
//--------------constructor--------------------------
function mul_w_seq:: new(string name="mul_w_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task mul_w_seq::body();
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
	end
	for(int i=0; i<4; i++)begin
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
endtask
