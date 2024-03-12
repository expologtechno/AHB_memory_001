
class trans_seq extends ahb_sequence;

	`uvm_object_utils(trans_seq)
extern function new(string name ="trans_seq");
extern task body();

endclass
//--------------constructor--------------------------
function trans_seq:: new(string name="trans_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task trans_seq::body();
begin
		trans=ahb_transaction::type_id::create("trans");


	       
		for(int i=0, j=0; i<30; i=i+4, j=j+1)begin
			//for(int j=0; j<4; j++)begin
			j=j%4;
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == i; 
							trans.size    == 3'h2; 
							trans.trans   == j; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == i; 
							trans.size    == 3'h2; 
							trans.trans   == j; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
			//end
		end




end	
	
endtask
