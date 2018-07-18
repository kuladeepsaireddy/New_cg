`timescale 1ns / 1ps

`define nx 4
`define ny 4
`define super_sc_x 1
`define super_sc_y 1
//`define super_scalarity `super_sc_x * `super_sc_y
`define super_scalarity 1
`define N_size `nx*`ny
`define N `N_size/`super_scalarity
`define size $clog2(`N_size)
`define n_size $clog2(`N)
`define i_size $clog2(`nx)
`define j_size $clog2(`ny)
`define i $clog2(`N)



`define s_x_count `nx/`super_sc_x
`define s_y_count `ny/`super_sc_y
`define x_size $clog2(`super_sc_x)
`define y_size $clog2(`super_sc_y)

`define n_x_count  $clog2(`s_x_count)
`define ss_count $clog2(`super_scalarity)