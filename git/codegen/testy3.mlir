module {
llvm.mlir.global constant @longn("%ld \00")
llvm.func @free(!llvm.ptr<i8>)
llvm.func @malloc(i64) ->!llvm.ptr<i8>
llvm.func @printf(!llvm.ptr<i8>, ...) -> i64

func @queue(%0:!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) -> !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>> {
  %n0 = constant 0: i64
  %n1i32 = constant 1: i32
  %2 = llvm.getelementptr %0[%n0,%n1i32] : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  %3 = llvm.load %2: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  %4 = llvm.bitcast %0 :!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>> to !llvm.ptr<i8>
  llvm.call @free(%4):(!llvm.ptr<i8>)->()
  return %3: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>> 
}

func @estvide(%0:!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) -> i1{
	%null = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	%comp = llvm.icmp "eq" %0, %null: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	return %comp: i1
}

func @tete(%0:!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) -> i64{
  	%n0 = constant 0: i64
  	%n0i32 = constant 0: i32
	%dataptr = llvm.getelementptr %0[%n0,%n0i32] : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<i64>
	%data = llvm.load %dataptr: !llvm.ptr<i64>
	return %data: i64
}

func @init(%0:!llvm.ptr<i64>, %1:!llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>){
%3 = llvm.load %1: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
%n16 = constant 16: i64
%n8 = constant 8: i64
%n9 = constant 9: index
%n0 = constant 0: index
%n1 = constant 1: index
%11 = llvm.call @malloc(%n16):(i64)->(!llvm.ptr<i8>)
scf.for %in8 = %n9 to %n0 step %n1 iter_args(%7 = %3) -> (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) {
  %8 = std.index_cast %in8: index to i64
  %9 = llvm.getelementptr %0[%8] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
  %10 = llvm.load %9: !llvm.ptr<i64>
  %12 = llvm.bitcast %11 :!llvm.ptr<i8> to !llvm.ptr<i64>
  llvm.store %10, %12: !llvm.ptr<i64>
  %13 = llvm.getelementptr %11[%n8] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  %14 = llvm.bitcast %13 : !llvm.ptr<i8> to !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  llvm.store %7, %14: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  %15 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
  scf.yield %15: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}
%5 = llvm.bitcast %1 :!llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>> to !llvm.ptr<!llvm.ptr<i8>>
llvm.store %11, %5: !llvm.ptr<!llvm.ptr<i8>>
return
}

func @cons(%1:i64, %0:!llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>){
  %n16 = constant 16: i64
  %n8 = constant 8: i64
  %3 = llvm.call @malloc(%n16):(i64)->(!llvm.ptr<i8>)
  %4 = llvm.bitcast %3 :!llvm.ptr<i8> to !llvm.ptr<i64>
  llvm.store %1, %4: !llvm.ptr<i64>
  %5 = llvm.load %0: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  %6 = llvm.getelementptr %3[%n8] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  %7 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  llvm.store %5, %7: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  %8 = llvm.bitcast %0 :!llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>> to !llvm.ptr<!llvm.ptr<i8>>
  llvm.store %3, %8: !llvm.ptr<!llvm.ptr<i8>>
  return
}

func @printli(%0: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) {
  	%n0 = constant 0: i64
  	%n1 = constant 1: i64
  	  	%n0i32 = constant 0: i32
  	  	  %n1i32 = constant 1: i32
  	%null = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	%res = scf.while (%current = %0) : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) ->
		!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>> {
	
	  %condition = llvm.icmp "ne" %current, %null: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	  scf.condition(%condition) %current : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	  
	} do {
	^bb0(%current: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>):
	
	  %dataptr = llvm.getelementptr %current[%n0,%n0i32] : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<i64>
	  %data = llvm.load %dataptr: !llvm.ptr<i64>
	  
	  %20 = llvm.mlir.addressof @longn : !llvm.ptr<array<5 x i8>>
      %26 = llvm.getelementptr %20[%n0, %n0] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
      %27 = llvm.call @printf(%26,%data) : (!llvm.ptr<i8>,i64) -> i64
	  
	  %nextptr =llvm.getelementptr %current[%n0,%n1i32] : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
	  %next = llvm.load %nextptr: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
	  
	  scf.yield %next : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	}     
	return
}

func @main() {
  	%null = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
  	  	%n1 = constant 1: i64
  	%n12 = constant 12: i64
  	  	%n29 = constant 29: i64
  	  	  	%n11 = constant 11: i64
  	  	  	  	%n23 = constant 23: i64
  %1 = llvm.alloca %n1 x !llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>: (i64) -> !llvm.ptr< !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  llvm.store %null, %1: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  call @cons(%n12, %1): (i64, !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>)->()
    call @cons(%n29, %1): (i64, !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>)->()
      call @cons(%n11, %1): (i64, !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>)->()
        call @cons(%n23, %1): (i64, !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>)->()
  %3 = llvm.load %1: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  %4 = call @queue(%3): (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)
  call @printli(%4):(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->()
  return
}

}
