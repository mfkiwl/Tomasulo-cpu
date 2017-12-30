`timescale 1ns / 1ps
`include "head.v"
module RegFile(
    input clk,
    input nRST,
    input [4:0] ReadAddr1,
    input [4:0] ReadAddr2,
    input RegWr,
    input [4:0] WriteAddr,
    input [31:0] WriteLabel,
    output [31:0] DataOut1,
    output [31:0] DataOut2,
    output [4:0] LabelOut1,
    output [4:0] LabelOut2,
    input BCEN,
    input [4:0] BClabel,
    input [31:0] BCdata
    );
    reg [31:0] regData[1:31];
    reg [4:0] regLabel[1:31];
    assign DataOut1 = (ReadAddr1 == 0) ? 0 : regData[ReadAddr1];
    assign DataOut2 = (ReadAddr2 == 0) ? 0 : regData[ReadAddr2];
    assign LabelOut1 = (ReadAddr1 == 0) ? 0 : regLabel[ReadAddr1];
    assign LabelOut2 = (ReadAddr2 == 0) ? 0 : regLabel[ReadAddr2];
    generate
        genvar i;
        for (i = 1; i < 32; i = i + 1) begin: regfile
            always @(negedge clk or negedge nRST) begin
                if (!nRST) begin
                    regFile[i] <= 32'b0;
                    regLabel[i] <= 5'b0;
                end else begin
                    if (BCEN && regLabel[i] == BClabel) begin
                        regLabel[i] <= 5'b0;
                        regData[i] <= BCdata;
                    end
                    if (RegWr && WriteAddr == i) begin
                        regLabel[i] <= WriteLabel;
                    end
                end
            end
        end
    endgenerate
endmodule