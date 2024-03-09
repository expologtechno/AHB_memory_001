/************  ENVIRONMENT ********************/


class ahb_env extends uvm_env;

	`uvm_component_utils(ahb_env)
	
	ahb_scoreboard sb_h;	
	ahb_agent age;
//	pass_agent page;  //PASSIVE
	ahb_sequencer sequencer;
	virtual_sequencer v_seqr;
	age_config age_cn;
//	page_config page_cn; //PASSIVE
	env_config env_cn;

	ahb_monitor mon;
	
extern function new(string name="ahb_env",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern function void report();	
endclass

//------------------CONSTRUCTOR---------------------

function ahb_env::new(string name="ahb_env",uvm_component parent);
	super.new(name,parent);
endfunction

//---------------------BUILD PHASE--------------------

function void ahb_env::build_phase(uvm_phase phase);
	super.build_phase(phase);

	`uvm_info("ENV",$sformatf("ENTERED ENV"),UVM_MEDIUM)

	env_cn=env_config::type_id::create("env_config",this);
	if(!uvm_config_db #(env_config)::get(this,"*","env_config",env_cn))
		begin
			`uvm_fatal("ENV_CONFIG","CANNOT GET CONGIF FROM UVM_CONFIG");

		end

	age=ahb_agent::type_id::create("age",this);
//	page=pass_agent::type_id::create("page",this); //PASSIVE
	sb_h=ahb_scoreboard::type_id::create("sb_h",this);
	age_cn=age_config::type_id::create("age_cn",this);
//	page_cn=page_config::type_id::create("page_cn",this); //PASSIVE
	v_seqr=virtual_sequencer::type_id::create("v_seqr",this);


	
//set interface to agent		
	uvm_config_db#(age_config)::set(this,"*","age_config",env_cn.age_cn);
//	uvm_config_db#(page_config)::set(this,"*","page_config",env_cn.page_cn); //PASSIVE
	
endfunction


//-----------------------------connect_phase------------------------
function void ahb_env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	v_seqr.sequencer=age.sequencer;

	
		age.monitor.analysis_port.connect(sb_h.analy_fifo.analysis_export);
//	age.monitor.analysis_port.connect(sb_h.analy_mon);
//	page.monitor.analysis_pass_port.connect(sb_h.analy_passive); //PASSIVE
endfunction


//*********************************Report for checking error************************************************
function void ahb_env::report();
uvm_report_server reportserver=uvm_report_server::get_server();
$display("***************************************************************************************************************************************************************");
$display("--------------------------------------------------------------------test_summary-------------------------------------------------------------------------------");
$display("***************************************************************************************************************************************************************");

$display("***************************************************************************************************************************************************************");
report_header();
report_summarize();
$display("****************************************************************************************************************************************************************");

$display("--------final test stauts--------");
if(reportserver.get_severity_count(UVM_FATAL)==0 && reportserver.get_severity_count(UVM_ERROR)==0)
begin
$display("============================================================================================================");
$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!!!TEST PASSED!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
$display("");
$display("");
$display("******  ******  ****** ******         ****** 	******  ******  ******              ");
$display("   *	  *       *        *            *    * 	*    *  *       *                   ");
$display("   *	  *       *        *            *    * 	*    *  *       *                   ");
$display("   *	  ******  ******   *            ****** 	******  ******  ******              ");
$display("   *	  *            *   *            *       *    *       *       *              ");
$display("   *	  *            *   *            *       *    *       *       *              ");
$display("   *	  ******  ******   *            *       *    *  ******  ******              ");
$display("");
$display("");
$display("============================================================================================================");
end
else
begin
$display("============================================================================================================");
$display("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!!!TEST FAILED!!!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
$display("");
$display("");
$display("          ******  ******  ****** ******  	****** 	******  ******  *              	");
$display("            *	    *	    *        *	       	*    	*    *    *     *               ");
$display("            *	    *	    *        *	       	*    	*    *    *     *               ");
$display("            *	    ******  ******   *	       	******	******    *     *              	");
$display("            *	    *	         *   *	       	*  	*    *    *     *              	");
$display("            *	    *	         *   *	       	*  	*    *    *     *              	");
$display("            *	    ******  ******   *	       	*  	*    *  ******  ******          ");
$display("");
$display("");
$display("============================================================================================================");
end
endfunction

