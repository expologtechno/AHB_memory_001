//=====================================SCOREBOARD========================================/

class ahb_scoreboard extends uvm_scoreboard;
  	`uvm_component_utils(ahb_scoreboard)



ahb_transaction trans;



//sc_mem
reg [7:0] sc_mem [bit [15:0]] ;


uvm_tlm_analysis_fifo#(ahb_transaction) analy_fifo;

//---------------------------------constructor---------------------------------------------
function new(string name="ahb_scoreboard", uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------------------------build_phase-------------------------------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	analy_fifo = new("analy_fifo",this);

	`uvm_info("SCOREBOARD","BUILD_PHASE" ,UVM_LOW )
endfunction




//--------------------------------------run_phase---------------------------------------------
/*virtual task run_phase(uvm_phase phase);

forever begin

analy_fifo.get(trans);

	if(trans.write) begin
		sc_mem[trans.addr[0]] = trans.wdata[0];
		`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_WRITE_DATA       :: ------"),UVM_LOW)
        	`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0],sc_mem[trans.addr[0]]),UVM_LOW)
	end
	else if(!trans.write)begin
		if(sc_mem.exists(trans.addr[0]))begin
			if(sc_mem[trans.addr[0]] == trans.rdata[0]) begin
			`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_READ_DATA_MATCH:: ------"),UVM_LOW)
          	     	`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0]),UVM_LOW)
			end
		else begin
			`uvm_error(get_type_name(),"------ ::SCOREBOARD_READ_DATA_MISMATCH :: ------")
          	    	`uvm_error(get_type_name(),$sformatf("Addr:%0h Expected Data: %0h Actual Data: %0h",trans.addr[0],sc_mem[trans.addr[0]],trans.rdata[0]))
 		 end
		end
	end
end
endtask


endclass*/


//--------------------------------------run_phase---------------------------------------------
/*virtual task run_phase(uvm_phase phase);

forever begin

analy_fifo.get(trans);

	if(trans.write) begin
		if(trans.size == 0) begin
			if(trans.addr[0][1:0] == 00) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][7:0];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE0_DATA       :: ------"),UVM_LOW) //byte 0
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h  trans.hsize:=%0h ",trans.addr[0],trans.wdata[0][7:0],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
			else if(trans.addr[0][1:0] == 01) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][15:8];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE1_DATA       :: ------"),UVM_LOW) //byte 1
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.hsize:=%0h   ",trans.addr[0],trans.wdata[0][15:8],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
			else if(trans.addr[0][1:0] == 10) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][23:16];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE2_DATA       :: ------"),UVM_LOW) //byte 2
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.hsize:=%0h   ",trans.addr[0],trans.wdata[0][23:16],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
			else if(trans.addr[0][1:0] == 11) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][31:24];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE3_DATA       :: ------"),UVM_LOW) //byte 3
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.hsize:=%0h   ",trans.addr[0],trans.wdata[0][31:24],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
		end
		else if(trans.size == 1)begin
			if(trans.addr[0][1])begin
        			`uvm_info(get_type_name()," UPPERHALF_WORD  ",UVM_LOW)
				sc_mem[trans.addr[0]] = trans.wdata[0][31:16];// upper half word

				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_UPPERWORD_DATA       :: ------"),UVM_LOW) 
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.size=%0h   ",trans.addr[0],trans.wdata[0][31:16],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
			else begin
				sc_mem[trans.addr[0]] = trans.wdata[0][15:0]; // lower half word
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_LOWERWORD_DATA     :: ------"),UVM_LOW) 
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.size=%0h  ",trans.addr[0],trans.wdata[0][15:0],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
		end	
		else begin
			
			sc_mem[trans.addr[0]] = trans.wdata[0]; //whole word
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_WHOLE_DATA     :: ------"),UVM_LOW) 
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.hsize:=%0h   ",trans.addr[0],trans.wdata[0],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
			end
	end


	else if(!trans.write)begin
		if(sc_mem.exists(trans.addr[0]))begin
			if(trans.size == 0) begin
				if(trans.addr[0][1:0] == 00) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][7:0]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE0_DATAMATCH       :: ------"),UVM_LOW) //byte 0
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0][7:0]),UVM_LOW)
					end
				end
			else if(trans.addr[0][1:0] == 01) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][15:8]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE1_DATAMATCH       :: ------"),UVM_LOW) //byte 1
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0][15:8]),UVM_LOW)
					end
				end

			else if(trans.addr[0][1:0] == 10) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][23:16]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE2_DATAMATCH       :: ------"),UVM_LOW) //byte 2
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h   Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0][23:16]),UVM_LOW)
					end
				end
			else if(trans.addr[0][1:0] == 11) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][31:24]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE3_DATAMATCH       :: ------"),UVM_LOW) //byte 3
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0][31:24]),UVM_LOW)
					end
				end
			end
			else if(trans.size == 1)begin
					if(trans.addr[1])begin
						if(sc_mem[trans.addr[0]] == trans.rdata[0][31:16]) begin
						`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_UPPERWORD_DATAMATCH       :: ------"),UVM_LOW) //byte 3
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0][31:16]),UVM_LOW)
						end
					end
					else begin
						if(sc_mem[trans.addr[0]] == trans.rdata[0][31:16]) begin
						`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_LOWERWORD_DATAMATCH     :: ------"),UVM_LOW) //byte 3
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0][15:0]),UVM_LOW)
						end
					end
			end	
			else if(trans.size == 2 || trans.size ==3 || trans.size == 4 || trans.size ==5 || trans.size == 6 || trans.size ==7  )begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0] ) begin
						`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD__WHOLE_DATAMATCH     :: ------"),UVM_LOW) //byte 3
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h trans.hsize:=%0h   Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size, sc_mem[trans.addr[0]],trans.rdata[0]),UVM_LOW)
					end
			end
			else begin
			`uvm_error(get_type_name(),"------ ::SCOREBOARD_READ_DATA_MISMATCH :: ------")
          	    	`uvm_error(get_type_name(),$sformatf("Addr:%0h trans.hsize:=%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0],trans.size,sc_mem[trans.addr[0]],trans.rdata[0]))
 		 	end
		end
	end
end
endtask


endclass*/

//--------------------------------------run_phase---------------------------------------------
virtual task run_phase(uvm_phase phase);

forever begin

analy_fifo.get(trans);
`uvm_info("SCOREBOARD---------------",$sformatf("Addr: %0h Data: %0h     ",trans.addr[0],trans.wdata[0]),UVM_LOW)

	if(trans.write) begin
		if(trans.size == 0) begin
			if(trans.addr[0][1:0] == 2'b00) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][7:0];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE0_DATA       :: ------"),UVM_LOW) //byte 0
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][7:0],sc_mem[trans.addr[0]]),UVM_LOW)
			end
			else if(trans.addr[0][1:0] == 2'b01) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][15:8];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE1_DATA       :: ------"),UVM_LOW) //byte 1
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][15:8],sc_mem[trans.addr[0]]),UVM_LOW)
			end
			else if(trans.addr[0][1:0] == 2'b10) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][23:16];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE2_DATA       :: ------"),UVM_LOW) //byte 2
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][23:16],sc_mem[trans.addr[0]]),UVM_LOW)
			end
			else if(trans.addr[0][1:0] == 2'b11) begin
				sc_mem[trans.addr[0]] = trans.wdata[0][31:24];
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_BYTE3_DATA       :: ------"),UVM_LOW) //byte 3
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][31:24],sc_mem[trans.addr[0]]),UVM_LOW)
			end
		end
		else if(trans.size == 1)begin
			if(trans.addr[0][1])begin
        			`uvm_info(get_type_name()," UPPERHALF_WORD  ",UVM_LOW)
				sc_mem[trans.addr[0]] = trans.wdata[0][23:16];// upper half word
				sc_mem[trans.addr[0] +1]=trans.wdata[0][31:24] ; 

				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_UPPERWORD_DATA       :: ------"),UVM_LOW) 
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.size=%0h  ",trans.addr[0],trans.wdata[0][23:16],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.size=%0h  ",trans.addr[0],trans.wdata[0][31:24],sc_mem[trans.addr[0]+1],trans.size),UVM_LOW)
			end
			else begin
				sc_mem[trans.addr[0]] = trans.wdata[0][7:0]; // lower half word
				sc_mem[trans.addr[0] +1]=trans.wdata[0][15:8] ; 
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_LOWERWORD_DATA     :: ------"),UVM_LOW) 
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.size=%0h  ",trans.addr[0],trans.wdata[0][7:0],sc_mem[trans.addr[0]],trans.size),UVM_LOW)
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h trans.size=%0h  ",trans.addr[0],trans.wdata[0][15:8],sc_mem[trans.addr[0]+1],trans.size),UVM_LOW)
			end
		end	
		else begin
			
			sc_mem[trans.addr[0]] = trans.wdata[0][7:0]; //whole word
			sc_mem[trans.addr[0]+1] = trans.wdata[0][15:8]; //whole word
			sc_mem[trans.addr[0]+2] = trans.wdata[0][23:16]; //whole word
			sc_mem[trans.addr[0]+3] = trans.wdata[0][31:24]; //whole word
				`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_STORING_WHOLE_DATA     :: ------"),UVM_LOW) 
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][7:0],sc_mem[trans.addr[0]]),UVM_LOW)
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][15:8],sc_mem[trans.addr[0]+1]),UVM_LOW)
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][23:16],sc_mem[trans.addr[0]+2]),UVM_LOW)
        			`uvm_info(get_type_name(),$sformatf("Addr: %0h Data: %0h  sc_data:=%0h   ",trans.addr[0],trans.wdata[0][31:24],sc_mem[trans.addr[0]+3]),UVM_LOW)
			end
	end


	else if(!trans.write)begin
		if(sc_mem.exists(trans.addr[0]))begin
			if(trans.size == 0) begin
				if(trans.addr[0][1:0] == 2'b00) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][7:0]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE0_DATAMATCH       :: ------"),UVM_LOW) //byte 0
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][7:0]),UVM_LOW)
					end
				end
			else if(trans.addr[0][1:0] == 2'b01) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][15:8]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE1_DATAMATCH       :: ------"),UVM_LOW) //byte 1
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][15:8]),UVM_LOW)
					end
				end

			else if(trans.addr[0][1:0] == 2'b10) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][23:16]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE2_DATAMATCH       :: ------"),UVM_LOW) //byte 2
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][23:16]),UVM_LOW)
					end
				end
			else if(trans.addr[0][1:0] == 2'b11) begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][31:24]) begin
					`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_BYTE3_DATAMATCH       :: ------"),UVM_LOW) //byte 3
          	     			`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][31:24]),UVM_LOW)
					end
				end
			end
			else if(trans.size == 1)begin
					if(trans.addr[0][1])begin
						if(sc_mem[trans.addr[0]] == trans.rdata[0][23:16] && sc_mem[trans.addr[0]+1] == trans.rdata[0][31:24]) begin
						`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_UPPERWORD_DATAMATCH       :: ------"),UVM_LOW) //upper word
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][23:16]),UVM_LOW)
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]+1],trans.rdata[0][31:24]),UVM_LOW)
						end
					end
					else begin
						if(sc_mem[trans.addr[0]] == trans.rdata[0][7:0] && sc_mem[trans.addr[0]+1] == trans.rdata[0][15:8]) begin
						`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD_LOWERWORD_DATAMATCH     :: ------"),UVM_LOW) //lower word
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][7:0]),UVM_LOW)
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]+1],trans.rdata[0][15:8]),UVM_LOW)
						end
					end
			end	
			else if(trans.size == 2 || trans.size ==3 || trans.size == 4 || trans.size ==5 || trans.size == 6 || trans.size ==7  )begin
					if(sc_mem[trans.addr[0]] == trans.rdata[0][7:0] && sc_mem[trans.addr[0]+1] == trans.rdata[0][15:8] && sc_mem[trans.addr[0]+2] == trans.rdata[0][23:16] && sc_mem[trans.addr[0]+3] == trans.rdata[0][31:24] ) begin
						`uvm_info(get_type_name(),$sformatf("------ :: SCOREBOARD__WHOLE_DATAMATCH     :: ------"),UVM_LOW) //word
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]],trans.rdata[0][7:0]),UVM_LOW)
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]+1],trans.rdata[0][15:8]),UVM_LOW)
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]+2],trans.rdata[0][23:16]),UVM_LOW)
          	     				`uvm_info(get_type_name(),$sformatf(" Addr :%0h  Expected Data: %0h Actual Data: %0h",trans.addr[0], sc_mem[trans.addr[0]+3],trans.rdata[0][31:24]),UVM_LOW)
					end
			end
			else begin
			`uvm_error(get_type_name(),"------ ::SCOREBOARD_READ_DATA_MISMATCH :: ------")
          	    	`uvm_error(get_type_name(),$sformatf("Addr:%0h Expected Data: %0h Actual Data: %0h",trans.addr[0],sc_mem[trans.addr[0]],trans.rdata[0]))
 		 	end
		end
	end
end
endtask


endclass



















































//=====================================SCOREBOARD========================================/

/*class ahb_scoreboard extends uvm_scoreboard;
  	`uvm_component_utils(ahb_scoreboard)

	ahb_transaction trans;
	pass_transaction pass_trans;

`uvm_analysis_imp_decl(_analy_mon)
`uvm_analysis_imp_decl(_analy_passive)

	pass_transaction ptrans_qu[$];
	ahb_transaction trans_qu[$];


reg [31:0] sc_mem [bit [15:0]] ;
uvm_analysis_imp_analy_mon#(ahb_transaction,ahb_scoreboard) analy_mon;
uvm_analysis_imp_analy_passive#(pass_transaction,ahb_scoreboard) analy_passive;

//---------------------------------constructor---------------------------------------------
function new(string name="ahb_scoreboard", uvm_component parent);
	super.new(name,parent);
endfunction

//-----------------------------------build_phase-------------------------------------------
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	analy_mon = new("analy_mon",this);
	analy_passive = new("analy_passive",this);

	`uvm_info("SCOREBOARD","BUILD_PHASE" ,UVM_LOW )
endfunction

//-----------------------implementing_write_method-----------------------------------
virtual function void write_analy_passive(pass_transaction pass_trans);
ptrans_qu.push_back(pass_trans);
endfunction

//-----------------------implementing_write_method-----------------------------------
virtual function void write_analy_mon(ahb_transaction trans);
trans_qu.push_back(trans);
endfunction

//--------------------------------------run_phase---------------------------------------------
virtual task run_phase(uvm_phase phase);

	`uvm_info("SCOREBOARD","RUN_PHASE" ,UVM_LOW )
forever begin

	wait(ptrans_qu.size()>0 && trans_qu.size()>0);
	trans = trans_qu.pop_front();
	pass_trans = ptrans_qu.pop_front();
	



if(trans.write) 
		begin
			sc_mem[trans.addr[0]] = trans.wdata[0];
		`uvm_info(get_type_name(),$sformatf("------ :: WRITE_DATA       :: ------"),UVM_LOW)
        	`uvm_info(get_type_name(),$sformatf("Addr: %0h",trans.addr[0]),UVM_LOW)
       	 	`uvm_info(get_type_name(),$sformatf("Data: %0h",trans.wdata[0]),UVM_LOW)
       	 	`uvm_info(get_type_name(),$sformatf("mem_data: %0h",sc_mem[trans.addr[0]]),UVM_LOW)
		end

	else if(!trans.write)
		begin

			 if(sc_mem[trans.addr[0]] == pass_trans.prdata[0])
			 begin
			`uvm_info(get_type_name(),$sformatf("------ :: READ_DATA_Match :: ------"),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Addr: %0h",trans.addr[0]),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[trans.addr[0]],pass_trans.prdata[0]),UVM_LOW)
			end
	else
	       		begin
			`uvm_info(get_type_name(),"------ :: READ_DATA_MisMatch :: ------",UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Addr: %0h",trans.addr[0]),UVM_LOW)
          		`uvm_info(get_type_name(),$sformatf("Expected Data: %0h Actual Data: %0h",sc_mem[trans.addr[0]],pass_trans.prdata[0]),UVM_LOW)
 		 	end
		end

	
	
end
endtask


endclass*/
