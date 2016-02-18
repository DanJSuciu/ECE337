// $Id: $
// File name:   controller.sv
// Created:     2/16/2016
// Author:      Dan Suciu
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: controller

module controller
(
	input wire clk,
	input wire n_reset,
	input wire dr,
	input wire lc,
	input wire overflow,
	output reg cnt_up,
	output reg clear,
	output wire modwait,
	output reg [2:0] op,
	output reg [3:0] src1,
	output reg [3:0] src2,
	output reg [3:0] dest,
	output reg err
);

reg newmodwait;
reg mymodwait;

typedef enum bit [4:0] {IDLE, STORE, ZERO, SORT1, SORT2, SORT3, SORT4, MUL1, MUL2, MUL3, MUL4, ADD1, ADD2, SUB1, SUB2, EIDLE, LOAD1, LOAD2, LOAD3, LOAD4, WAIT1, WAIT2, WAIT3, WAIT4} state_type;
state_type state, newstate;

always_ff @ (posedge clk, negedge n_reset)
begin
	if (n_reset == 0) begin
		state <= IDLE;
		mymodwait <= 0;
	end else begin
		state <= newstate;
		mymodwait <= newmodwait;
	end
end

assign modwait = mymodwait;

always_comb
begin
	cnt_up=0;
	clear=0;
	op=0;
	src1=0;
	src2=0;
	dest=0;
	err=0;
	newstate = state;
	newmodwait = mymodwait;
	case (state)
	IDLE:
	begin 
		if (lc) begin
			newmodwait=1;
			newstate = LOAD1;
		end else if (dr) begin
			newmodwait=1;
			newstate = STORE;
		end else begin
			newmodwait=0;
			newstate = IDLE;
		end
		cnt_up=0;
		clear=0;
		op=3'b000;
		err=0;
	end 
	LOAD1:
	begin
		newstate = WAIT1;
		cnt_up=0;
		clear=1;
		newmodwait=0;
		op=3'b011;
		dest=6;
		err=0;
	end
	WAIT1:
	begin
		newstate = LOAD2;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b000;
		err=0;
	end
	LOAD2:
	begin
		newstate = WAIT2;
		cnt_up=0;
		clear=0;
		newmodwait=0;
		op=3'b011;
		dest=7;
		err=0;
	end
	WAIT2:
	begin
		newstate = LOAD3;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b000;
		err=0;
	end
	LOAD3:
	begin
		newstate = WAIT3;
		cnt_up=0;
		clear=0;
		newmodwait=0;
		op=3'b011;
		dest=8;
		err=0;
	end
	WAIT3:
	begin
		newstate = LOAD4;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b000;
		err=0;
	end
	LOAD4:
	begin
		newstate = WAIT4;
		cnt_up=0;
		clear=0;
		newmodwait=0;
		op=3'b011;
		dest=9;
		err=0;
	end
	WAIT4:
	begin
		newstate = IDLE;
		cnt_up=0;
		clear=0;
		newmodwait=0;
		op=3'b000;
		err=0;
	end
	STORE:
	begin
		if (dr) begin
			newmodwait=1;
			newstate = ZERO;
		end else begin
			newmodwait=0;
			newstate = EIDLE;
		end
		cnt_up=0;
		clear=0;
		op=3'b010;
		dest=5;
		err=0;
	end
	ZERO:
	begin
		newstate = SORT1;
		cnt_up=1;
		clear=0;
		newmodwait=1;
		op=3'b101;
		dest=0;
		src1=0;
		src2=0;
		err=0;
	end
	SORT1:
	begin
		newstate = SORT2;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b001;
		dest=1;
		src1=2;
		err=0;
	end
	SORT2:
	begin
		newstate = SORT3;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b001;
		dest=2;
		src1=3;
		err=0;
	end
	SORT3:
	begin
		newstate = SORT4;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b001;
		dest=3;
		src1=4;
		err=0;
	end
	SORT4:
	begin
		newstate = MUL1;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b001;
		dest=4;
		src1=5;
		err=0;
	end
	MUL1:
	begin
		newstate = ADD1;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b110;
		dest=10;
		src1=1;
		src2=6;
		err=0;
	end
	ADD1:
	begin
		if (overflow) begin
			newmodwait=0;
			newstate = EIDLE;
		end else begin
			newmodwait=1;
			newstate = MUL2;
		end
		cnt_up=0;
		clear=0;
		op=3'b100;
		dest=0;
		src1=0;
		src2=10;
		err=0;
	end
	MUL2:
	begin
		newstate = SUB1;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b110;
		dest=10;
		src1=2;
		src2=7;
		err=0;
	end
	SUB1:
	begin
		if (overflow) begin
			newmodwait=0;
			newstate = EIDLE;
		end else begin
			newmodwait=1;
			newstate = MUL3;
		end
		cnt_up=0;
		clear=0;
		op=3'b101;
		dest=0;
		src1=0;
		src2=10;
		err=0;
	end
	MUL3:
	begin
		newstate = ADD2;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b110;
		dest=10;
		src1=3;
		src2=8;
		err=0;
	end
	ADD2:
	begin
		if (overflow) begin
			newmodwait=0;
			newstate = EIDLE;
		end else begin
			newmodwait=1;
			newstate = MUL4;
		end
		cnt_up=0;
		clear=0;
		op=3'b100;
		dest=0;
		src1=0;
		src2=10;
		err=0;
	end
	MUL4:
	begin
		newstate = SUB2;
		cnt_up=0;
		clear=0;
		newmodwait=1;
		op=3'b110;
		dest=10;
		src1=4;
		src2=9;
		err=0;
	end
	SUB2:
	begin
		if (overflow) begin
			newmodwait=0;
			newstate = EIDLE;
		end else begin
			newmodwait=0;
			newstate = IDLE;
		end
		cnt_up=0;
		clear=0;
		op=3'b101;
		dest=0;
		src1=0;
		src2=10;
		err=0;
	end
	EIDLE:
	begin
		if (dr) begin
			newmodwait=1;
			newstate = STORE;
		end else begin
			newmodwait=0;
			newstate = EIDLE;
		end
		cnt_up=0;
		clear=0;
		op=3'b000;
		err=1;
	end
	endcase
end

endmodule