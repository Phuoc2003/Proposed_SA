module top_wrapper(
            input clk,
            input resetn
);

    wire [7:0] a_buf_0_0, a_buf_1_0, a_buf_2_0, a_buf_3_0;
    wire [7:0] b_buf_0_0, b_buf_1_0, b_buf_2_0, b_buf_3_0;
    wire [7:0] d_buf_0_0, d_buf_1_0, d_buf_2_0, d_buf_3_0;
    wire [19:0] mesh_io_out_c_0_0, mesh_io_out_c_1_0, mesh_io_out_c_2_0, mesh_io_out_c_3_0;
    wire in_0_prop, in_1_prop, in_2_prop, in_3_prop;
    wire io_in_valid_0_0, io_in_valid_1_0, io_in_valid_2_0, io_in_valid_3_0;

    Mesh mesh (	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:167:20]
    .clock                       (clk),
    .io_in_a_0_0                 (a_buf_0_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:100:24, :152:33, :155:26, :170:34]
    .io_in_a_1_0                 (a_buf_1_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_a_2_0                 (a_buf_2_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_a_3_0                 (a_buf_3_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    
    .io_in_b_0_0                 (b_buf_0_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:101:24, :153:80, :155:26, :171:34]
    .io_in_b_1_0                 (b_buf_1_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_b_2_0                 (b_buf_2_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_b_3_0                 (b_buf_3_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    
    .io_in_d_0_0                 (d_buf_0_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:102:24, :154:80, :155:26, :172:34]
    .io_in_d_1_0                 (d_buf_1_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_d_2_0                 (d_buf_2_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_d_3_0                 (d_buf_3_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    
    .io_in_control_0_0_dataflow  (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:93:16]
    .io_in_control_0_0_propagate (in_0_prop),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:108:24]
    .io_in_control_0_0_shift     (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:183:29]
    
    .io_in_control_1_0_dataflow  (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:180:43]
    .io_in_control_1_0_propagate (in_1_prop),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:181:44]
    .io_in_control_1_0_shift     (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:185:42]
    
    .io_in_control_2_0_dataflow  (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:180:43]
    .io_in_control_2_0_propagate (in_2_prop),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:181:44]
    .io_in_control_2_0_shift     (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:185:42]
    
    .io_in_control_3_0_dataflow  (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:180:43]
    .io_in_control_3_0_propagate (in_3_prop),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:181:44]
    .io_in_control_3_0_shift     (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:185:42]
    
    .io_in_id_0_0                (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:95:26]
    .io_in_id_1_0                (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_id_2_0                (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_id_3_0                (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]

    .io_in_last_0_0              (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:112:54]
    .io_in_last_1_0              (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_last_2_0              (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_last_3_0              (),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]

    .io_out_b_0_0                (),
    .io_out_b_1_0                (),
    .io_out_b_2_0                (),
    .io_out_b_3_0                (),

    .io_out_c_0_0                (mesh_io_out_c_0_0),
    .io_out_c_1_0                (mesh_io_out_c_1_0),
    .io_out_c_2_0                (mesh_io_out_c_2_0),
    .io_out_c_3_0                (mesh_io_out_c_3_0),

    .io_in_valid_0_0             (io_in_valid_0_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:149:26, :157:32]
    .io_in_valid_1_0             (io_in_valid_1_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_valid_2_0             (io_in_valid_2_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]
    .io_in_valid_3_0             (io_in_valid_3_0),	// @[generators/gemmini/src/main/scala/gemmini/MeshWithDelays.scala:86:22]

    .io_out_valid_0_0            (),
    .io_out_control_0_0_dataflow (),
    .io_out_id_0_0               (),
    .io_out_last_0_0             ()
	 );
endmodule