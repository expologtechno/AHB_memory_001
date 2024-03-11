//---------------------------------------------------------------------------------------//
/*------------------------------wait_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class wait_seq extends ahb_sequence;

	///ahb_transaction rsp;
	`uvm_object_utils(wait_seq)
extern function new(string name ="wait_seq");
extern task body();

endclass
//--------------constructor--------------------------
function wait_seq:: new(string name="wait_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task wait_seq::body();
	begin
		trans=ahb_transaction::type_id::create("trans");

		
		start_item(trans);
			assert(trans.randomize() with {  
				trans.write == 1'b1; 
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h14; 
				trans.size  == 3'h2; 
				trans.trans == 2'b10; 
				trans.ready == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  
				trans.write == 1'b0; 
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h14; 
				trans.size  == 3'h2; 
				trans.trans == 2'b10; 
				trans.ready == 1'b1;});
		finish_item(trans);
		get_response(rsp);
		
		start_item(trans);
			assert(trans.randomize() with { 
			       	trans.write == 1'b1;  
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h18; 
				trans.size  == 3'h2; 
				trans.trans == 2'b10; 
				trans.ready == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with { 
			       	trans.write == 1'b0;  
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h18; 
				trans.size  == 3'h2; 
				trans.trans == 2'b10; 
				trans.ready == 1'b0;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with { 
			       	trans.write == 1'b0;  
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h18; 
				trans.size  == 3'h2; 
				trans.trans == 2'b10; 
				trans.ready == 1'b1;});
		finish_item(trans);
		get_response(rsp);



		start_item(trans);
			assert(trans.randomize() with {  
				trans.write == 1'b1; 
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h1C; 
				trans.size  == 3'h2; 
				trans.trans == 2'b11; 
				trans.ready == 1'b0;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with {  
				trans.write == 1'b1; 
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h1C; 
				trans.size  == 3'h2; 
				trans.trans == 2'b11; 
				trans.ready == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  
				trans.write == 1'b0; 
				trans.datalen == 3'h1;  
		       		trans.addr[0] == 16'h1C; 
				trans.size  == 3'h2; 
				trans.trans == 2'b11; 
				trans.ready == 1'b1;});
		finish_item(trans);
		get_response(rsp);





			
		end
	


endtask
