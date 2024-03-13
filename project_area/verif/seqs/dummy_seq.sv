//---------------------------------------------------------------------------------------//
/*------------------------------dummy_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class dummy_seq extends ahb_sequence;

	`uvm_object_utils(dummy_seq)
extern function new(string name ="dummy_seq");
extern task body();

endclass
//--------------constructor--------------------------
function dummy_seq:: new(string name="dummy_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task dummy_seq::body();
	//int i=0;	
begin
		trans=ahb_transaction::type_id::create("trans");
while(1)begin
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 16'h3;  
		       					trans.addr[0] == 16'h01; 
							trans.addr[1] == 16'h12; 
							trans.addr[2] == 16'h17;
							trans.size    == 3'h2; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0; 
							trans.datalen == 16'h3;
							trans.addr[0] == 16'h01;
							trans.addr[1] == 16'h12; 
							trans.addr[2] == 16'h17;
							trans.size    == 3'h2;  
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
	end


end	
	
endtask
