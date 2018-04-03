`timescale 1ns / 1ps

`define nx 16
`define ny 16
`define super_scalarity 8

`define N_size `nx*`ny
`define N `N_size/`super_scalarity
`define size $clog2(`N_size)
`define n_size $clog2(`N)
`define i_size $clog2(`nx)
`define j_size $clog2(`ny)
`define i $clog2(`N)



`define s_x_count `nx/(`super_scalarity/2)
`define s_y_count `ny/2
`define x_size $clog2(`super_scalarity/2)
