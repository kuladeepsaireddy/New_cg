`timescale 1ns / 1ps

`define nx 8

`define ny 8
`define N `nx*`ny

`define size $clog2(`N)
`define n_size $clog2(`N)
`define i_size $clog2(`nx)
`define j_size $clog2(`ny)
`define i $clog2(`N)