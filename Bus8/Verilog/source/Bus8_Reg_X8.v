//////////////////////////////////////////////////////////////////////////////
// FPGA Bus Registers, 8 bits wide
// Contains 8 Readable/Writable Registers.
//
// Parameters:
// INIT_XX - Used to initalize registers to non-zero values.
//////////////////////////////////////////////////////////////////////////////
module Bus8_Reg_X8 #(parameter INIT_00  = 0,
                     parameter INIT_01  = 0,
                     parameter INIT_02  = 0,
                     parameter INIT_03  = 0,
                     parameter INIT_04  = 0,
                     parameter INIT_05  = 0,
                     parameter INIT_06  = 0,
                     parameter INIT_07  = 0)
 (input            i_Bus_Rst_L,
  input            i_Bus_Clk,
  input            i_Bus_CS,
  input            i_Bus_Wr_Rd_n,
  input [2:0]      i_Bus_Addr8,
  input [7:0]      i_Bus_Wr_Data,
  output reg [7:0] o_Bus_Rd_Data,
  output reg       o_Bus_Rd_DV,
  input [7:0]      i_Reg_00,
  input [7:0]      i_Reg_01,
  input [7:0]      i_Reg_02,
  input [7:0]      i_Reg_03,
  input [7:0]      i_Reg_04,
  input [7:0]      i_Reg_05,
  input [7:0]      i_Reg_06,
  input [7:0]      i_Reg_07,
  output reg [7:0] o_Reg_00,
  output reg [7:0] o_Reg_01,
  output reg [7:0] o_Reg_02,
  output reg [7:0] o_Reg_03,
  output reg [7:0] o_Reg_04,
  output reg [7:0] o_Reg_05,
  output reg [7:0] o_Reg_06,
  output reg [7:0] o_Reg_07);

  always @(posedge i_Bus_Clk or negedge i_Bus_Rst_L)
  begin
    if (~i_Bus_Rst_L)
    begin
      o_Bus_Rd_DV <= 1'b0;
      o_Reg_00    <= INIT_00;
      o_Reg_01    <= INIT_01;
      o_Reg_02    <= INIT_02;
      o_Reg_03    <= INIT_03;
      o_Reg_04    <= INIT_04;
      o_Reg_05    <= INIT_05;
      o_Reg_06    <= INIT_06;
      o_Reg_07    <= INIT_07;
    end
    else
    begin
      o_Bus_Rd_DV <= 1'b0;

      if (i_Bus_CS == 1'b1)
      begin
        if (i_Bus_Wr_Rd_n == 1'b1) // Write Command
        begin
          case (i_Bus_Addr8[2:0])
          3'b000 : o_Reg_00 <= i_Bus_Wr_Data;
          3'b001 : o_Reg_01 <= i_Bus_Wr_Data;
          3'b010 : o_Reg_02 <= i_Bus_Wr_Data;
          3'b011 : o_Reg_03 <= i_Bus_Wr_Data;
          3'b100 : o_Reg_04 <= i_Bus_Wr_Data;
          3'b101 : o_Reg_05 <= i_Bus_Wr_Data;
          3'b110 : o_Reg_06 <= i_Bus_Wr_Data;
          3'b111 : o_Reg_07 <= i_Bus_Wr_Data;
          endcase
        end
        else // Read Command
        begin
          o_Bus_Rd_DV   <= 1'b1;
          
          case (i_Bus_Addr8[2:0])
          3'b000 : o_Bus_Rd_Data <= i_Reg_00;
          3'b001 : o_Bus_Rd_Data <= i_Reg_01;
          3'b010 : o_Bus_Rd_Data <= i_Reg_02;
          3'b011 : o_Bus_Rd_Data <= i_Reg_03;
          3'b100 : o_Bus_Rd_Data <= i_Reg_04;
          3'b101 : o_Bus_Rd_Data <= i_Reg_05;
          3'b110 : o_Bus_Rd_Data <= i_Reg_06;
          3'b111 : o_Bus_Rd_Data <= i_Reg_07;
          endcase 
        end // else: !if(i_Bus_Wr_Rd_n == 1'b1)
      end // if (i_Bus_CS == 1'b1)
    end // else: !if(!i_Bus_Rst_L)
  end // always @ (posedge i_Bus_Clk or negedge i_Bus_Rst_L)

endmodule // Bus8_Reg_X8

