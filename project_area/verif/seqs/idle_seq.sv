//---------------------------------------------------------------------------------------//
/*------------------------------incr4_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class idle_seq extends ahb_sequence;

	`uvm_object_utils(idle_seq)
extern function new(string name ="idle_seq");
extern task body();

endclass
//--------------constructor--------------------------
function idle_seq:: new(string name="idle_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task idle_seq::body();

	begin
		trans=ahb_transaction::type_id::create("trans");

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h00; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b00; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);	

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h14; 
							trans.size    == 3'h3; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h08; 
							trans.size    == 3'h4; 
							trans.trans   == 2'b11; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);


		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h00; 
							trans.size    == 3'h2; 
							trans.trans   == 2'b00; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);	

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h14; 
							trans.size    == 3'h3; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == 16'h08; 
							trans.size    == 3'h4; 
							trans.trans   == 2'b11; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
		end

endtask


