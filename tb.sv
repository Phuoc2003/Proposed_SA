`timescale 1ns/1ps

module mesh_tb();

  // Tham số
  parameter WIDTH_A = 8;    // Độ rộng bit của phần tử ma trận A
  parameter WIDTH_B = 8;    // Độ rộng bit của phần tử ma trận B
  parameter WIDTH_C = 20;   // Độ rộng bit của phần tử ma trận kết quả C
  parameter MESH_DIM = 4;   // Kích thước mảng systolic (4x4)
  
  // Tín hiệu clock
  logic clk;
  
  // Tín hiệu đầu vào A (hàng)
  logic [WIDTH_A-1:0] io_in_a_0_0;
  logic [WIDTH_A-1:0] io_in_a_1_0;
  logic [WIDTH_A-1:0] io_in_a_2_0;
  logic [WIDTH_A-1:0] io_in_a_3_0;
  
  // Tín hiệu đầu vào B (cột)
  logic [WIDTH_B-1:0] io_in_b_0_0;
  logic [WIDTH_B-1:0] io_in_b_1_0;
  logic [WIDTH_B-1:0] io_in_b_2_0;
  logic [WIDTH_B-1:0] io_in_b_3_0;
  
  // Tín hiệu đầu vào D (preload)
  logic [WIDTH_B-1:0] io_in_d_0_0;
  logic [WIDTH_B-1:0] io_in_d_1_0;
  logic [WIDTH_B-1:0] io_in_d_2_0;
  logic [WIDTH_B-1:0] io_in_d_3_0;
  
  // Tín hiệu điều khiển
  logic io_in_control_0_0_dataflow;
  logic io_in_control_0_0_propagate;
  logic [4:0] io_in_control_0_0_shift;
  logic io_in_control_1_0_dataflow;
  logic io_in_control_1_0_propagate;
  logic [4:0] io_in_control_1_0_shift;
  logic io_in_control_2_0_dataflow;
  logic io_in_control_2_0_propagate;
  logic [4:0] io_in_control_2_0_shift;
  logic io_in_control_3_0_dataflow;
  logic io_in_control_3_0_propagate;
  logic [4:0] io_in_control_3_0_shift;
  
  // Tín hiệu ID
  logic [2:0] io_in_id_0_0;
  logic [2:0] io_in_id_1_0;
  logic [2:0] io_in_id_2_0;
  logic [2:0] io_in_id_3_0;
  
  // Tín hiệu last
  logic io_in_last_0_0;
  logic io_in_last_1_0;
  logic io_in_last_2_0;
  logic io_in_last_3_0;
  
  // Tín hiệu valid
  logic io_in_valid_0_0;
  logic io_in_valid_1_0;
  logic io_in_valid_2_0;
  logic io_in_valid_3_0;
  
  // Tín hiệu đầu ra B
  logic [WIDTH_C-1:0] io_out_b_0_0;
  logic [WIDTH_C-1:0] io_out_b_1_0;
  logic [WIDTH_C-1:0] io_out_b_2_0;
  logic [WIDTH_C-1:0] io_out_b_3_0;
  
  // Tín hiệu đầu ra C (kết quả)
  logic [WIDTH_C-1:0] io_out_c_0_0;
  logic [WIDTH_C-1:0] io_out_c_1_0;
  logic [WIDTH_C-1:0] io_out_c_2_0;
  logic [WIDTH_C-1:0] io_out_c_3_0;
  
  // Tín hiệu đầu ra điều khiển
  logic io_out_valid_0_0;
  logic io_out_control_0_0_dataflow;
  logic [2:0] io_out_id_0_0;
  logic io_out_last_0_0;
  
  // Khai báo các ma trận đầu vào và đầu ra
  logic [WIDTH_A-1:0] matrix_A [MESH_DIM][MESH_DIM];
  logic [WIDTH_B-1:0] matrix_B [MESH_DIM][MESH_DIM];
  logic [WIDTH_B-1:0] matrix_D [MESH_DIM][MESH_DIM];
  logic [WIDTH_C-1:0] matrix_C [MESH_DIM][MESH_DIM];
  logic [WIDTH_C-1:0] expected_C [MESH_DIM][MESH_DIM];
  
  // Instantiate DUT (Design Under Test)
  Mesh dut (
    .clock(clk),
    .io_in_a_0_0(io_in_a_0_0),
    .io_in_a_1_0(io_in_a_1_0),
    .io_in_a_2_0(io_in_a_2_0),
    .io_in_a_3_0(io_in_a_3_0),
    .io_in_b_0_0(io_in_b_0_0),
    .io_in_b_1_0(io_in_b_1_0),
    .io_in_b_2_0(io_in_b_2_0),
    .io_in_b_3_0(io_in_b_3_0),
    .io_in_d_0_0(io_in_d_0_0),
    .io_in_d_1_0(io_in_d_1_0),
    .io_in_d_2_0(io_in_d_2_0),
    .io_in_d_3_0(io_in_d_3_0),
    .io_in_control_0_0_dataflow(io_in_control_0_0_dataflow),
    .io_in_control_0_0_propagate(io_in_control_0_0_propagate),
    .io_in_control_0_0_shift(io_in_control_0_0_shift),
    .io_in_control_1_0_dataflow(io_in_control_1_0_dataflow),
    .io_in_control_1_0_propagate(io_in_control_1_0_propagate),
    .io_in_control_1_0_shift(io_in_control_1_0_shift),
    .io_in_control_2_0_dataflow(io_in_control_2_0_dataflow),
    .io_in_control_2_0_propagate(io_in_control_2_0_propagate),
    .io_in_control_2_0_shift(io_in_control_2_0_shift),
    .io_in_control_3_0_dataflow(io_in_control_3_0_dataflow),
    .io_in_control_3_0_propagate(io_in_control_3_0_propagate),
    .io_in_control_3_0_shift(io_in_control_3_0_shift),
    .io_in_id_0_0(io_in_id_0_0),
    .io_in_id_1_0(io_in_id_1_0),
    .io_in_id_2_0(io_in_id_2_0),
    .io_in_id_3_0(io_in_id_3_0),
    .io_in_last_0_0(io_in_last_0_0),
    .io_in_last_1_0(io_in_last_1_0),
    .io_in_last_2_0(io_in_last_2_0),
    .io_in_last_3_0(io_in_last_3_0),
    .io_in_valid_0_0(io_in_valid_0_0),
    .io_in_valid_1_0(io_in_valid_1_0),
    .io_in_valid_2_0(io_in_valid_2_0),
    .io_in_valid_3_0(io_in_valid_3_0),
    .io_out_b_0_0(io_out_b_0_0),
    .io_out_b_1_0(io_out_b_1_0),
    .io_out_b_2_0(io_out_b_2_0),
    .io_out_b_3_0(io_out_b_3_0),
    .io_out_c_0_0(io_out_c_0_0),
    .io_out_c_1_0(io_out_c_1_0),
    .io_out_c_2_0(io_out_c_2_0),
    .io_out_c_3_0(io_out_c_3_0),
    .io_out_valid_0_0(io_out_valid_0_0),
    .io_out_control_0_0_dataflow(io_out_control_0_0_dataflow),
    .io_out_id_0_0(io_out_id_0_0),
    .io_out_last_0_0(io_out_last_0_0)
  );
  
  // Tạo xung clock
  always begin
    #5 clk = ~clk;
  end
  
  // Hàm tính toán nhân ma trận dự kiến
  function void calculate_expected_result();
    for (int i = 0; i < MESH_DIM; i++) begin
      for (int j = 0; j < MESH_DIM; j++) begin
        expected_C[i][j] = matrix_D[i][j];
        for (int k = 0; k < MESH_DIM; k++) begin
          expected_C[i][j] = expected_C[i][j] + 
                            $signed(matrix_A[i][k]) * $signed(matrix_B[k][j]);
        end
      end
    end
  endfunction
  
  // Khởi tạo và chạy testbench
  initial begin
    // Khởi tạo tín hiệu
    clk = 0;
    // Khởi tạo tín hiệu điều khiển
    io_in_control_0_0_dataflow = 1'b0;  // Chế độ output-stationary
    io_in_control_0_0_propagate = 1'b0; // Cho phép lan truyền
    io_in_control_0_0_shift = 5'd0;     // Không shift
    io_in_control_1_0_dataflow = 1'b0;
    io_in_control_1_0_propagate = 1'b0;
    io_in_control_1_0_shift = 5'd0;
    io_in_control_2_0_dataflow = 1'b0;
    io_in_control_2_0_propagate = 1'b0;
    io_in_control_2_0_shift = 5'd0;
    io_in_control_3_0_dataflow = 1'b0;
    io_in_control_3_0_propagate = 1'b0;
    io_in_control_3_0_shift = 5'd0;
    
    // Khởi tạo ID
    io_in_id_0_0 = 3'd0;
    io_in_id_1_0 = 3'd1;
    io_in_id_2_0 = 3'd2;
    io_in_id_3_0 = 3'd3;
    
    // Khởi tạo last
    io_in_last_0_0 = 1'b0;
    io_in_last_1_0 = 1'b0;
    io_in_last_2_0 = 1'b0;
    io_in_last_3_0 = 1'b0;
    
    // Khởi tạo valid
    io_in_valid_0_0 = 1'b0;
    io_in_valid_1_0 = 1'b0;
    io_in_valid_2_0 = 1'b0;
    io_in_valid_3_0 = 1'b0;
    
    // Khởi tạo ma trận A (có thể thay đổi giá trị theo nhu cầu)
    matrix_A[0][0] = 8'd1;  matrix_A[0][1] = 8'd2;  matrix_A[0][2] = 8'd3;  matrix_A[0][3] = 8'd4;
    matrix_A[1][0] = 8'd5;  matrix_A[1][1] = 8'd6;  matrix_A[1][2] = 8'd7;  matrix_A[1][3] = 8'd8;
    matrix_A[2][0] = 8'd9;  matrix_A[2][1] = 8'd10; matrix_A[2][2] = 8'd11; matrix_A[2][3] = 8'd12;
    matrix_A[3][0] = 8'd13; matrix_A[3][1] = 8'd14; matrix_A[3][2] = 8'd15; matrix_A[3][3] = 8'd16;
    
    // Khởi tạo ma trận B
    matrix_B[0][0] = 8'd1;  matrix_B[0][1] = 8'd2;  matrix_B[0][2] = 8'd3;  matrix_B[0][3] = 8'd4;
    matrix_B[1][0] = 8'd5;  matrix_B[1][1] = 8'd6;  matrix_B[1][2] = 8'd7;  matrix_B[1][3] = 8'd8;
    matrix_B[2][0] = 8'd9;  matrix_B[2][1] = 8'd10; matrix_B[2][2] = 8'd11; matrix_B[2][3] = 8'd12;
    matrix_B[3][0] = 8'd13; matrix_B[3][1] = 8'd14; matrix_B[3][2] = 8'd15; matrix_B[3][3] = 8'd16;
    
    // Khởi tạo ma trận D (preload, thường là 0 hoặc bias)
    for (int i = 0; i < MESH_DIM; i++) begin
      for (int j = 0; j < MESH_DIM; j++) begin
        matrix_D[i][j] = 0;
      end
    end



    for(int i=0;i<4;i++)
    begin
      @(posedge clk);
        io_in_valid_0_0 = 1'b1;
        io_in_valid_1_0 = 1'b1;
        io_in_valid_2_0 = 1'b1;
        io_in_valid_3_0 = 1'b1;

        io_in_control_0_0_propagate = 1'b1;
        io_in_control_1_0_propagate = 1'b1;
        io_in_control_2_0_propagate = 1'b1;
        io_in_control_3_0_propagate = 1'b1;

        io_in_d_0_0 = matrix_D[0][i];
        io_in_d_1_0 = matrix_D[1][i];
        io_in_d_2_0 = matrix_D[2][i];
        io_in_d_3_0 = matrix_D[3][i];

    end
    
    
    // Bắt đầu mô phỏng
    @(posedge clk);
    
    // Chu kỳ 1: Bắt đầu nhập dữ liệu
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b0;
    io_in_valid_2_0 = 1'b0;
    io_in_valid_3_0 = 1'b0;

    io_in_control_0_0_propagate = 1'b0;
    io_in_control_1_0_propagate = 1'b0;
    io_in_control_2_0_propagate = 1'b0;
    io_in_control_3_0_propagate = 1'b0;
    
    io_in_a_0_0 = matrix_A[0][0];
    io_in_b_0_0 = matrix_B[0][0];
    io_in_a_1_0 = 8'd0;
    io_in_b_1_0 = 8'd0;
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = 8'd0;
    io_in_b_2_0 = 8'd0;
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = 8'd0;
    io_in_b_3_0 = 8'd0;
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 2
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b0;
    io_in_valid_3_0 = 1'b0;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b0; 
    
    io_in_a_0_0 = matrix_A[0][1];
    io_in_b_0_0 = matrix_B[1][0];
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = matrix_A[1][0];
    io_in_b_1_0 = matrix_B[0][1];
    // io_in_d_1_0 = matrix_D[0][1];
    io_in_a_2_0 = 8'd0;
    io_in_b_2_0 = 8'd0;
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = 8'd0;
    io_in_b_3_0 = 8'd0;
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 3
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b0;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b0; 
    
    io_in_a_0_0 = matrix_A[0][2];
    io_in_b_0_0 = matrix_B[2][0];
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = matrix_A[1][1];
    io_in_b_1_0 = matrix_B[1][1];
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = matrix_A[2][0];
    io_in_b_2_0 = matrix_B[0][2];
    // io_in_d_2_0 = matrix_D[0][2];
    io_in_a_3_0 = 8'd0;
    io_in_b_3_0 = 8'd0;
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 4
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0;
    io_in_control_1_0_propagate = 1'b0;
    io_in_control_2_0_propagate = 1'b0;
    io_in_control_3_0_propagate = 1'b0;
    
    io_in_a_0_0 = matrix_A[0][3];
    io_in_b_0_0 = matrix_B[3][0];
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = matrix_A[1][2];
    io_in_b_1_0 = matrix_B[2][1];
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = matrix_A[2][1];
    io_in_b_2_0 = matrix_B[1][2];
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = matrix_A[3][0];
    io_in_b_3_0 = matrix_B[0][3];
    // io_in_d_3_0 = matrix_D[0][3];
    @(posedge clk);
    
    // Chu kỳ 5

    for (int i = 0; i < MESH_DIM; i++) begin
      for (int j = 0; j < MESH_DIM; j++) begin
        matrix_D[i][j] = 100;
      end
    end
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b0; 

    
    io_in_a_0_0 = 8'd0;
    io_in_b_0_0 = 8'd0;
    io_in_d_0_0 = matrix_D[0][0];
    io_in_a_1_0 = matrix_A[1][3];
    io_in_b_1_0 = matrix_B[3][1];
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = matrix_A[2][2];
    io_in_b_2_0 = matrix_B[2][2];
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = matrix_A[3][1];
    io_in_b_3_0 = matrix_B[1][3];
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 6
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1;
    io_in_control_1_0_propagate = 1'b1;
    io_in_control_2_0_propagate = 1'b0;
    io_in_control_3_0_propagate = 1'b0;
    
    io_in_a_0_0 = 8'd0;
    io_in_b_0_0 = 8'd0;
    // io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = 8'd0;
    io_in_b_1_0 = 8'd0;
    io_in_d_1_0 = matrix_D[0][1];
    io_in_a_2_0 = matrix_A[2][3];
    io_in_b_2_0 = matrix_B[3][2];
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = matrix_A[3][2];
    io_in_b_3_0 = matrix_B[2][3];
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 7
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1; 
    io_in_control_1_0_propagate = 1'b1; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b0; 
    
    io_in_a_0_0 = 8'd0;
    io_in_b_0_0 = 8'd0;
    // io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = 8'd0;
    io_in_b_1_0 = 8'd0;
    // io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = 8'd0;
    io_in_b_2_0 = 8'd0;
    io_in_d_2_0 = matrix_D[0][2];
    io_in_a_3_0 = matrix_A[3][3];
    io_in_b_3_0 = matrix_B[3][3];
    io_in_d_3_0 = 8'd0;
    
    // Đánh dấu phần tử cuối cùng
    io_in_last_3_0 = 1'b1;
    @(posedge clk);
    
    // Chu kỳ 8 - Kết thúc nhập dữ liệu
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1; 
    io_in_control_1_0_propagate = 1'b1; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b1; 

    io_in_a_3_0 = 0;
    io_in_b_3_0 = 0;
    io_in_last_3_0 = 1'b0;
    io_in_d_3_0 = matrix_D[0][3];

    @(posedge clk);
    
    // Khởi tạo ma trận A với giá trị mới
    // matrix_A[0][0] = 8'd2;   matrix_A[0][1] = 8'd3;  matrix_A[0][2] = 8'd4;   matrix_A[0][3] = 8'd5;
    // matrix_A[1][0] = 8'd6;  matrix_A[1][1] = 8'd7;   matrix_A[1][2] = 8'd8;  matrix_A[1][3] = 8'd9;
    // matrix_A[2][0] = 8'd10;  matrix_A[2][1] = 8'd11; matrix_A[2][2] = 8'd12;  matrix_A[2][3] = 8'd13;
    // matrix_A[3][0] = 8'd14; matrix_A[3][1] = 8'd15;  matrix_A[3][2] = 8'd16; matrix_A[3][3] = 8'd17;

    // // Khởi tạo ma trận B với giá trị mới
    // matrix_B[0][0] = 8'd3;   matrix_B[0][1] = 8'd4;  matrix_B[0][2] = 8'd5;   matrix_B[0][3] = 8'd6;
    // matrix_B[1][0] = 8'd7;  matrix_B[1][1] = 8'd8;   matrix_B[1][2] = 8'd9;  matrix_B[1][3] = 8'd10;
    // matrix_B[2][0] = 8'd11;  matrix_B[2][1] = 8'd12; matrix_B[2][2] = 8'd13;  matrix_B[2][3] = 8'd14;
    // matrix_B[3][0] = 8'd15; matrix_B[3][1] = 8'd16;  matrix_B[3][2] = 8'd17; matrix_B[3][3] = 8'd18;
    
    // Chu kỳ 9 
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b1; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b1;


    io_in_a_0_0 = matrix_A[0][0];
    io_in_b_0_0 = matrix_B[0][0];
    io_in_d_0_0 = 0;
    io_in_a_1_0 = 8'd0;
    io_in_b_1_0 = 8'd0;
    // io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = 8'd0;
    io_in_b_2_0 = 8'd0;
    // io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = 8'd0;
    io_in_b_3_0 = 8'd0;
    // io_in_d_3_0 = 8'd0;
    

    @(posedge clk);
    
    // Chu kỳ 10
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b1;

    io_in_a_0_0 = matrix_A[0][1];
    io_in_b_0_0 = matrix_B[1][0];
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = matrix_A[1][0];
    io_in_b_1_0 = matrix_B[0][1];
    io_in_d_1_0 = 0;
    io_in_a_2_0 = 8'd0;
    io_in_b_2_0 = 8'd0;
    // io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = 8'd0;
    io_in_b_3_0 = 8'd0;
    // io_in_d_3_0 = 8'd0;

    @(posedge clk);
    
    // Chu kỳ 11
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b1;

    io_in_a_0_0 = matrix_A[0][2];
    io_in_b_0_0 = matrix_B[2][0];
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = matrix_A[1][1];
    io_in_b_1_0 = matrix_B[1][1];
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = matrix_A[2][0];
    io_in_b_2_0 = matrix_B[0][2];
    io_in_d_2_0 = 0;
    io_in_a_3_0 = 8'd0;
    io_in_b_3_0 = 8'd0;
    // io_in_d_3_0 = 8'd0;
    
    @(posedge clk);
    
    // Chu kỳ 12
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b0;

    io_in_a_0_0 = matrix_A[0][3];
    io_in_b_0_0 = matrix_B[3][0];
    io_in_d_0_0 = 8'd0;

    io_in_a_1_0 = matrix_A[1][2];
    io_in_b_1_0 = matrix_B[2][1];
    io_in_d_1_0 = 8'd0;

    io_in_a_2_0 = matrix_A[2][1];
    io_in_b_2_0 = matrix_B[1][2];
    io_in_d_2_0 = 8'd0;

    io_in_a_3_0 = matrix_A[3][0];
    io_in_b_3_0 = matrix_B[0][3];
    io_in_d_3_0 = 0;


        @(posedge clk);
    
    // Chu kỳ 5
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b0; 
    
    io_in_a_0_0 = 8'd0;
    io_in_b_0_0 = 8'd0;
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = matrix_A[1][3];
    io_in_b_1_0 = matrix_B[3][1];
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = matrix_A[2][2];
    io_in_b_2_0 = matrix_B[2][2];
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = matrix_A[3][1];
    io_in_b_3_0 = matrix_B[1][3];
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 6
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1;
    io_in_control_1_0_propagate = 1'b1;
    io_in_control_2_0_propagate = 1'b0;
    io_in_control_3_0_propagate = 1'b0;
    
    io_in_a_0_0 = 8'd0;
    io_in_b_0_0 = 8'd0;
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = 8'd0;
    io_in_b_1_0 = 8'd0;
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = matrix_A[2][3];
    io_in_b_2_0 = matrix_B[3][2];
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = matrix_A[3][2];
    io_in_b_3_0 = matrix_B[2][3];
    io_in_d_3_0 = 8'd0;
    @(posedge clk);
    
    // Chu kỳ 7
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1; 
    io_in_control_1_0_propagate = 1'b1; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b0; 
    
    io_in_a_0_0 = 8'd0;
    io_in_b_0_0 = 8'd0;
    io_in_d_0_0 = 8'd0;
    io_in_a_1_0 = 8'd0;
    io_in_b_1_0 = 8'd0;
    io_in_d_1_0 = 8'd0;
    io_in_a_2_0 = 8'd0;
    io_in_b_2_0 = 8'd0;
    io_in_d_2_0 = 8'd0;
    io_in_a_3_0 = matrix_A[3][3];
    io_in_b_3_0 = matrix_B[3][3];
    io_in_d_3_0 = 8'd0;
    
    // Đánh dấu phần tử cuối cùng
    io_in_last_3_0 = 1'b1;

    @(posedge clk);
    
    // Chu kỳ 8 - Kết thúc nhập dữ liệu
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b1; 
    io_in_control_1_0_propagate = 1'b1; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b1; 


    @(posedge clk);
    
    // Chu kỳ 8 - Kết thúc nhập dữ liệu
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b1; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b1; 

    @(posedge clk);
    
    // Chu kỳ 8 - Kết thúc nhập dữ liệu
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b1; 
    io_in_control_3_0_propagate = 1'b1; 

    @(posedge clk);
    
    // Chu kỳ 8 - Kết thúc nhập dữ liệu
    io_in_valid_0_0 = 1'b1;
    io_in_valid_1_0 = 1'b1;
    io_in_valid_2_0 = 1'b1;
    io_in_valid_3_0 = 1'b1;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b1;

    @(posedge clk);
    
    // Chu kỳ 8 - Kết thúc nhập dữ liệu
    io_in_valid_0_0 = 1'b0;
    io_in_valid_1_0 = 1'b0;
    io_in_valid_2_0 = 1'b0;
    io_in_valid_3_0 = 1'b0;

    io_in_control_0_0_propagate = 1'b0; 
    io_in_control_1_0_propagate = 1'b0; 
    io_in_control_2_0_propagate = 1'b0; 
    io_in_control_3_0_propagate = 1'b0;  

    // Đợi kết quả
    repeat(10) @(posedge clk);
    
    // Thu thập và hiển thị kết quả

    // $finish;
  end
  
  // Theo dõi tín hiệu
  initial begin
    $dumpfile("mesh_tb.vcd");
    $dumpvars(0, mesh_tb);
  end

endmodule
