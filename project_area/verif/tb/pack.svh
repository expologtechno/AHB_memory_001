

        `include "interface.sv"	

	`include "../agent/ahb_agent/seq_item.sv"

       // `include "../agent/passive_agent/passive_tx.sv"         //PASSIVE
//	`include "../agent/passive_agent/pass_agent_config.sv"  //PASSIVE
	`include "../agent/ahb_agent/age_config.sv"
	`include "env_config.sv"

	`include "../agent/ahb_agent/driver.sv"
	`include "../agent/ahb_agent/monitor.sv"
        `include "../agent/ahb_agent/sequencer.sv"
	`include "../agent/ahb_agent/agent.sv"

//	`include "../agent/passive_agent/passive_monitor.sv" //PASSIVE
//	`include "../agent/passive_agent/passive_agent.sv"   //PASSIVE
	`include "virtual_sequencer.sv"
	`include "../seqs/seq_list.svh"

	`include "virtual_sequence.sv"
	`include "scoreboard.sv"
	`include "env.sv"


	
	`include "../test/test_list.svh"



