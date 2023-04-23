`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.01.2023 14:24:33
// Design Name: 
// Module Name: lab1_FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab1_FSM (input fifty, dollar, cancel, input clk, rst, 
                 output reg [1:0] st, 
                 output reg insert_coin, money_return, dispense);
                 
	parameter INIT = 0, S50c = 1, VEND = 2, RETURN = 3;
	reg [1:0] nst;
	
	always @ * begin
		nst = st;
		insert_coin = 1'b0;
        money_return = 1'b0;
        dispense = 1'b0;

		case (st)
			INIT:
				begin
				insert_coin = 1'b1;
				if (fifty) nst = S50c;
				if (dollar) nst = VEND;
				end
			S50c:
				begin
				insert_coin = 1'b1;
				if (fifty) nst = VEND;
				if (dollar) nst = RETURN;
				if (cancel) nst = RETURN;
				end
			VEND:
                dispense = 1'b1;
            RETURN:
                begin
                money_return = 1'b1;
                nst = INIT;
                end
		endcase
	end
	
	always @ (posedge clk) begin
		if (rst)
			st <= INIT;
		else 
			st <= nst;
	end
endmodule
