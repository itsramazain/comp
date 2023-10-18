module RegisterFile (
    input wire clock,
    input wire Reset,
    input wire [4:0] read_register_1,
    input wire [4:0] read_register_2,
    input wire reg_write_enable,
    input wire [31:0] write_data,
    input wire [4:0] reg_write_address, // Control signal from ControlUnit for write address
    output  [31:0] read_data_1,     // read data rs
    output  [31:0] read_data_2      // read data rt
);
	

	wire [31:0]rin;
	wire [31:0] r0_out,r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out,r10_out,r11_out,r12_out,r13_out,r14_out,r15_out,r16_out,r17_out,r18_out,r19_out,r20_out,r21_out,r22_out,r23_out,r24_out,r25_out,r26_out,r27_out,r28_out,r29_out,r30_out,r31_out;

	dec dee(reg_write_enable, reg_write_address, rin);
	
	register r0(32'b0,clock,1,r0_out,rin[31]);
	register r1(write_data,clock,Reset,r1_out,rin[30]);
	register r2(write_data,clock,Reset,r2_out,rin[29]);
	register r3(write_data,clock,Reset,r3_out,rin[28]);
	register r4(write_data,clock,Reset,r4_out,rin[27]);
	register r5(write_data,clock,Reset,r5_out,rin[26]);
	register r6(write_data,clock,Reset,r6_out,rin[25]);
	register r7(write_data,clock,Reset,r7_out,rin[24]);
	register r8(write_data,clock,Reset,r8_out,rin[23]);
	register r9(write_data,clock,Reset,r9_out,rin[22]);
	register r10(write_data,clock,Reset,r10_out,rin[21]);
	register r11(write_data,clock,Reset,r11_out,rin[20]);
	register r12(write_data,clock,Reset,r12_out,rin[19]);
	register r13(write_data,clock,Reset,r13_out,rin[18]);
	register r14(write_data,clock,Reset,r14_out,rin[17]);
	register r15(write_data,clock,Reset,r15_out,rin[16]);
	register r16(write_data,clock,Reset,r16_out,rin[15]);
	register r17(write_data,clock,Reset,r17_out,rin[14]);
	register r18(write_data,clock,Reset,r18_out,rin[13]);
	register r19(write_data,clock,Reset,r19_out,rin[12]);
	register r20(write_data,clock,Reset,r20_out,rin[11]);
	register r21(write_data,clock,Reset,r21_out,rin[10]);
	register r22(write_data,clock,Reset,r22_out,rin[9]);
	register r23(write_data,clock,Reset,r23_out,rin[8]);
	register r24(write_data,clock,Reset,r24_out,rin[7]);
	register r25(write_data,clock,Reset,r25_out,rin[6]);
	register r26(write_data,clock,Reset,r26_out,rin[5]);
	register r27(write_data,clock,Reset,r27_out,rin[4]);
	register r28(write_data,clock,Reset,r28_out,rin[3]);
	register r29(write_data,clock,Reset,r29_out,rin[2]);
	register r30(write_data,clock,Reset,r30_out,rin[1]);
	register r31(write_data,clock,Reset,r31_out,rin[0]);
	
	
	
	
	d d1(1'b1,read_register_1,r0_out,r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out,r10_out,r11_out,r12_out,r13_out,r14_out,r15_out,r16_out,r17_out,r18_out,r19_out,r20_out,r21_out,r22_out,r23_out,r24_out,r25_out,r26_out,r27_out,r28_out,r29_out,r30_out,r31_out,read_data_1);
	d d2(1'b1,read_register_2,r0_out,r1_out,r2_out,r3_out,r4_out,r5_out,r6_out,r7_out,r8_out,r9_out,r10_out,r11_out,r12_out,r13_out,r14_out,r15_out,r16_out,r17_out,r18_out,r19_out,r20_out,r21_out,r22_out,r23_out,r24_out,r25_out,r26_out,r27_out,r28_out,r29_out,r30_out,r31_out,read_data_2);
	
	
	


endmodule






module dec(E, W, Y);
    input E; // enable
    input [4:0] W;
    output [31:0] Y;
    reg [31:0] Y;
   
    always @(*)
        if (E == 0)
            Y <= 32'b00000000000000000000000000000000;
        else
            case (W)
                5'd0:   Y <= 32'b10000000000000000000000000000000;
                 5'd1:  Y <= 32'b01000000000000000000000000000000;
                 5'd2:  Y <= 32'b00100000000000000000000000000000;
                 5'd3:  Y <= 32'b00010000000000000000000000000000;
                 5'd4:  Y <= 32'b00001000000000000000000000000000;
                 5'd5:  Y <= 32'b00000100000000000000000000000000;
                 5'd6:  Y <= 32'b00000010000000000000000000000000;
                 5'd7:  Y <= 32'b00000001000000000000000000000000;
					  5'd8:  Y <= 32'b00000000100000000000000000000000;
					  5'd9:  Y <= 32'b00000000010000000000000000000000;
					  5'd10: Y<=  32'b00000000001000000000000000000000;
					  5'd11: Y<=  32'b00000000000100000000000000000000;
					  5'd12: Y<=  32'b00000000000010000000000000000000;
					  5'd13: Y<=  32'b00000000000001000000000000000000;
					  5'd14: Y<=  32'b00000000000000100000000000000000;
					  5'd15: Y<=  32'b00000000000000010000000000000000;
					  5'd16: Y<=  32'b00000000000000001000000000000000;
					  5'd17: Y <= 32'b00000000000000000100000000000000;
					  5'd18: Y <= 32'b00000000000000000010000000000000;
					  5'd19: Y <= 32'b00000000000000000001000000000000;
					  5'd20: Y <= 32'b00000000000000000000100000000000;
					  5'd21: Y <= 32'b00000000000000000000010000000000;
					  5'd22: Y <= 32'b00000000000000000000001000000000;
					  5'd23: Y <= 32'b00000000000000000000000100000000;
					  5'd24: Y <= 32'b00000000000000000000000010000000;
					  5'd25: Y <= 32'b00000000000000000000000001000000;
					  5'd26: Y <= 32'b00000000000000000000000000100000;
					  5'd27: Y <= 32'b00000000000000000000000000010000;
					  5'd28: Y <= 32'b00000000000000000000000000001000;
					  5'd29: Y <= 32'b00000000000000000000000000000100;
					  5'd30: Y <= 32'b00000000000000000000000000000010;
					  5'd31: Y <= 32'b00000000000000000000000000000001;
					  
            endcase
endmodule


module d(E,add,i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,out);
	input [4:0]add;
	input [31:0]i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31;
	output reg [31:0]out;
	input E;
	always @(*)
	begin
	if (!E)
		out<=32'bx;
	else
	begin
	case(add)
	
	5'd0:out<=i0;
	5'd1:out<=i1;
	5'd2:out<=i2;
	5'd3:out<=i3;
	5'd4:out<=i4;
	5'd5:out<=i5;
	5'd6:out<=i6;
	5'd7:out<=i7;
	5'd8:out<=i8;
	5'd9:out<=i9;
	5'd10:out<=i10;
	5'd11:out<=i11;
	5'd12:out<=i12;
	5'd13:out<=i13;
	5'd14:out<=i14;
	5'd15:out<=i15;
	5'd16:out<=i16;
	5'd17:out<=i17;
	5'd18:out<=i18;
	5'd19:out<=i19;
	5'd20:out<=i20;
	5'd21:out<=i21;
	5'd22:out<=i22;
	5'd23:out<=i23;
	5'd24:out<=i24;
	5'd25:out<=i25;
	5'd26:out<=i26;
	5'd27:out<=i27;
	5'd28:out<=i28;
	5'd29:out<=i29;
	5'd30:out<=i30;
	5'd31:out<=i31;
	
	endcase
	end
	end
	
endmodule
