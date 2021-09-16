module attributes {llvm.data_layout = ""}  {
  llvm.mlir.global external  constant @longn("%ld \00")
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @printf(!llvm.ptr<i8>, ...) -> i64
  llvm.func @putchar(i32) -> i32
  llvm.func @init(%arg0: vector<5xi64>, %arg1: i64) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>> {
    %0 = llvm.mlir.null : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i64) : i64
    %3 = llvm.mlir.constant(8 : i64) : i64
    %4 = llvm.mlir.constant(0 : index) : i64
    %5 = llvm.mlir.constant(1 : index) : i64
    llvm.br ^bb1(%4, %0 : i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb1(%6: i64, %7: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // 2 preds: ^bb0, ^bb2
    %8 = llvm.icmp "slt" %6, %arg1 : i64
    llvm.cond_br %8, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %9 = llvm.sub %arg1, %6  : i64
    %10 = llvm.sub %9, %1  : i64
    %11 = llvm.call @malloc(%2) : (i64) -> !llvm.ptr<i8>
    %12 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %13 = llvm.extractelement %arg0[%10 : i64] : vector<5xi64>
    %14 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<i64>
    llvm.store %13, %14 : !llvm.ptr<i64>
    %15 = llvm.getelementptr %11[%3] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %16 = llvm.bitcast %15 : !llvm.ptr<i8> to !llvm.ptr<ptr<struct<"a", (i64, ptr<struct<"a">>)>>>
    llvm.store %7, %16 : !llvm.ptr<ptr<struct<"a", (i64, ptr<struct<"a">>)>>>
    %17 = llvm.add %6, %5  : i64
    llvm.br ^bb1(%17, %12 : i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb3:  // pred: ^bb1
    llvm.return %7 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
  }
  llvm.func @cons(%arg0: i64, %arg1: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>> {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr<i8>
    %3 = llvm.bitcast %2 : !llvm.ptr<i8> to !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %4 = llvm.bitcast %2 : !llvm.ptr<i8> to !llvm.ptr<i64>
    llvm.store %arg0, %4 : !llvm.ptr<i64>
    %5 = llvm.getelementptr %2[%1] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %6 = llvm.bitcast %5 : !llvm.ptr<i8> to !llvm.ptr<ptr<struct<"a", (i64, ptr<struct<"a">>)>>>
    llvm.store %arg1, %6 : !llvm.ptr<ptr<struct<"a", (i64, ptr<struct<"a">>)>>>
    llvm.return %3 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
  }
  llvm.func @printli(%arg0: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.null : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.br ^bb1(%arg0 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb1(%3: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // 2 preds: ^bb0, ^bb2
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.cond_br %4, ^bb2(%3 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>), ^bb3
  ^bb2(%5: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // pred: ^bb1
    %6 = llvm.load %5 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %7 = llvm.extractvalue %6[0 : i32] : !llvm.struct<"a", (i64, ptr<struct<"a">>)>
    %8 = llvm.mlir.addressof @longn : !llvm.ptr<array<5 x i8>>
    %9 = llvm.getelementptr %8[%0, %0] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = llvm.call @printf(%9, %7) : (!llvm.ptr<i8>, i64) -> i64
    %11 = llvm.load %5 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %12 = llvm.extractvalue %11[1 : i32] : !llvm.struct<"a", (i64, ptr<struct<"a">>)>
    llvm.br ^bb1(%12 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb3:  // pred: ^bb1
    %13 = llvm.mlir.constant(10 : i32) : i32
    %14 = llvm.call @putchar(%13) : (i32) -> i32
    llvm.return %1 : i64
  }
  llvm.func @queue(%arg0: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, %1] : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<ptr<struct<"a", (i64, ptr<struct<"a">>)>>>
    %3 = llvm.load %2 : !llvm.ptr<ptr<struct<"a", (i64, ptr<struct<"a">>)>>>
    llvm.return %3 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
  }
  llvm.func @tete(%arg0: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, %1] : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<i64>
    %3 = llvm.load %2 : !llvm.ptr<i64>
    llvm.return %3 : i64
  }
  llvm.func @estvide(%arg0: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i1 {
    %0 = llvm.mlir.null : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.return %1 : i1
  }
  llvm.func @conc(%arg0: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, %arg1: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>> {
    %0 = llvm.call @estvide(%arg0) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.call @tete(%arg0) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %2 = llvm.call @queue(%arg0) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %3 = llvm.call @conc(%2, %arg1) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %4 = llvm.call @cons(%1, %3) : (i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.br ^bb3(%4 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb3(%5: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.return %5 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
  }
  llvm.func @conchy(%arg0: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, %arg1: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>> {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.call @estvide(%arg0) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @tete(%arg0) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %5 = llvm.call @queue(%arg0) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %6 = llvm.call @conchy(%5, %arg1) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %7 = llvm.call @cons(%4, %6) : (i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.br ^bb3(%7 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb3(%8: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %9 = llvm.call @cons(%2, %8) : (i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.return %9 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
  }
  llvm.func @main() {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.null : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.call @cons(%0, %1) : (i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %5 = llvm.mlir.constant(dense<[10, 11, 12, 13, 14]> : vector<5xi64>) : vector<5xi64>
    %6 = llvm.call @init(%5, %2) : (vector<5xi64>, i64) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %7 = llvm.mlir.constant(dense<[15, 11, 12, 13, 14]> : vector<5xi64>) : vector<5xi64>
    %8 = llvm.call @init(%7, %2) : (vector<5xi64>, i64) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %9 = llvm.call @conc(%6, %8) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %10 = llvm.call @conc(%4, %9) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %11 = llvm.call @printli(%10) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %12 = llvm.call @estvide(%6) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i1
    llvm.cond_br %12, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb2:  // pred: ^bb0
    %13 = llvm.call @tete(%6) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %14 = llvm.call @queue(%6) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %15 = llvm.call @conc(%14, %8) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %16 = llvm.call @cons(%13, %15) : (i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.br ^bb3(%16 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb3(%17: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %18 = llvm.call @printli(%17) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %19 = llvm.call @estvide(%8) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i1
    llvm.cond_br %19, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.br ^bb7(%6 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb6:  // pred: ^bb4
    %20 = llvm.call @tete(%8) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %21 = llvm.call @queue(%8) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %22 = llvm.call @conc(%21, %6) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %23 = llvm.call @cons(%20, %22) : (i64, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    llvm.br ^bb7(%23 : !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>)
  ^bb7(%24: !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>):  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb8
  ^bb8:  // pred: ^bb7
    %25 = llvm.call @printli(%24) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    %26 = llvm.call @conchy(%6, %8) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>, !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>
    %27 = llvm.call @printli(%26) : (!llvm.ptr<struct<"a", (i64, ptr<struct<"a">>)>>) -> i64
    llvm.return
  }
}

