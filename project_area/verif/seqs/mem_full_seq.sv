//---------------------------------------------------------------------------------------//
//---------------------------------- memory_full_test--------------------------------------/
//---------------------------------------------------------------------------------------//
	
class mem_full_seq extends ahb_sequence;

  `uvm_object_utils(mem_full_seq)

  extern function new(string name ="mem_full_seq");
  extern task body();

endclass

//---------------------------------------------constructor-----------------------------------
function mem_full_seq:: new(string name="mem_full_seq");
  super.new(name);
endfunction

//-----------------------------------------------task body------------------------------------
task mem_full_seq::body();
  begin
    trans=ahb_transaction::type_id::create("trans");
    //for(int j=0; j<65535;j++) begin
    //for(int j=0; j<16;j++) begin //16
      //`uvm_info("MEMORY_FULL_SEQ",$sformatf("[%0t] j= %0d",$time,j),UVM_LOW)
      	start_item(trans);
     		assert(trans.randomize() with  {  trans.write     == 1'b1;
                               trans.datalen   == 16'd1;//1;//65536'd65536; //4096 
                               trans.addr[0]   == 16'h0000; 
                               trans.size      == 3'h00; 
                               trans.trans     == 2'b10; 
                               trans.ready     == 1'b1;});
	finish_item(trans);
	get_response(rsp);

      	start_item(trans);
     		assert(trans.randomize() with  {  
				trans.write    == 1'b0;
                               trans.datalen   == 16'd1;
                               trans.addr[0]   == 16'h0000; 
                               trans.size      == 3'h00; 
                               trans.trans     == 2'b10; 
                               trans.ready     == 1'b1;});
	finish_item(trans);
	get_response(rsp);

      	start_item(trans);
     		assert(trans.randomize() with  {  
				trans.write   == 1'b1;
                               trans.datalen   == 16'h1;
                               trans.addr[1]   == 16'hffff; 
                               trans.size      == 3'h00; 
                               trans.trans     == 2'b10; 
                               trans.ready     == 1'b1;});
	finish_item(trans);
	get_response(rsp);

      	start_item(trans);
     		assert(trans.randomize() with  {  
				trans.write    == 1'b0;
                               trans.datalen   == 16'h1;
                               trans.addr[1]   == 16'hffff; 
                               trans.size      == 3'h00; 
                               trans.trans     == 2'b10; 
                               trans.ready     == 1'b1;});
	finish_item(trans);
	get_response(rsp);

	start_item(trans);
     		assert(trans.randomize() with  {  
				trans.write    == 1'b1;
                               trans.datalen   == 16'd30;
                               trans.size      == 3'h00; 
                               trans.trans     == 2'b10; 
                               trans.ready     == 1'b1;});
	finish_item(trans);
	get_response(rsp);




		start_item(trans);
     		assert(trans.randomize() with  {  
				trans.write    == 1'b0;
                               trans.datalen   == 16'd30;
                               trans.size      == 3'h00; 
                               trans.trans     == 2'b10; 
                               trans.ready     == 1'b1;});
	finish_item(trans);
	get_response(rsp);
  end



endtask
