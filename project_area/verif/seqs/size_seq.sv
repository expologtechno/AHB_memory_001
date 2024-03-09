//---------------------------------------------------------------------------------------//
/*------------------------------size_sequence-------------------------------------------*/
//---------------------------------------------------------------------------------------//
class size_seq extends ahb_sequence;

	`uvm_object_utils(size_seq)
extern function new(string name ="size_seq");
extern task body();
reg [31:0] temp[7];

endclass
//--------------constructor--------------------------
function size_seq:: new(string name="size_seq");
	super.new(name);
endfunction

//-----------------------task body------------------------------
task size_seq::body();
begin
		trans=ahb_transaction::type_id::create("trans");
	


	for(int i=0; i<4; i = i+4)begin
		for(int j=2; j<7; j++)begin
		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b1;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == i; 
							trans.size    == j; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);

		start_item(trans);
			assert(trans.randomize() with {  trans.write == 1'b0;
							trans.datalen == 3'h1;  
		       					trans.addr[0] == i; 
							trans.size    == j; 
							trans.trans   == 2'b10; 
							trans.ready   == 1'b1;});
		finish_item(trans);
		get_response(rsp);
		end
	end



end	
	
endtask
