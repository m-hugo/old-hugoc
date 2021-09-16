module {
llvm.mlir.global constant @longn("%ld \00")
llvm.func @free(!llvm.ptr<i8>)
llvm.func @malloc(i64) ->!llvm.ptr<i8>
llvm.func @printf(!llvm.ptr<i8>, ...) -> i64
llvm.func @putchar(i32) -> i32

func @init(%0:vector<5xi64>, %taille:i64)->!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>{
%null = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
%n1 = constant 1: i64
%n16 = constant 16: i64
%n8 = constant 8: i64
%arret = std.index_cast %taille: i64 to index
%n0 = constant 0: index
%in1 = constant 1: index
%res=scf.for %in8 = %n0 to %arret step %in1 iter_args(%7 = %null) -> (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) {
  %a8 = std.index_cast %in8: index to i64
  %b8 = subi %taille, %a8: i64
  %8 = subi %b8, %n1: i64
  %11 = llvm.call @malloc(%n16):(i64)->(!llvm.ptr<i8>)
  %15 = llvm.bitcast %11 : !llvm.ptr<i8> to !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
  %10 = llvm.extractelement %0[%8:i64] :vector<5xi64>
  %12 = llvm.bitcast %11 :!llvm.ptr<i8> to !llvm.ptr<i64>
  llvm.store %10, %12: !llvm.ptr<i64>
  %13 = llvm.getelementptr %11[%n8] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  %14 = llvm.bitcast %13 : !llvm.ptr<i8> to !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  llvm.store %7, %14: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  scf.yield %15: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}
return %res: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}

func @cons(%1:i64, %5:!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>{
  %n16 = constant 16: i64
  %n8 = constant 8: i64
  %3 = llvm.call @malloc(%n16):(i64)->(!llvm.ptr<i8>)
  %0 = llvm.bitcast %3 :!llvm.ptr<i8> to !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
  %4 = llvm.bitcast %3 :!llvm.ptr<i8> to !llvm.ptr<i64>
  llvm.store %1, %4: !llvm.ptr<i64>
  %6 = llvm.getelementptr %3[%n8] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  %7 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  llvm.store %5, %7: !llvm.ptr<!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>>
  return %0: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}

func @printli(%0: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) ->i64 {
  	%n0 = constant 0: i64
  	%n1 = constant 1: i64
  	%null = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	%res = scf.while (%current = %0) : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>) ->
		!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>> {
	
	  %condition = llvm.icmp "ne" %current, %null: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	  scf.condition(%condition) %current : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	  
	} do {
	^bb0(%current: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>):
	
	  %2 = llvm.load %current: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
 	  %data = llvm.extractvalue  %2[0:i32]: !llvm.struct<"a", (i64, ptr<struct<"a">>)>
	  
	  %20 = llvm.mlir.addressof @longn : !llvm.ptr<array<5 x i8>>
      %26 = llvm.getelementptr %20[%n0, %n0] : (!llvm.ptr<array<5 x i8>>, i64, i64) -> !llvm.ptr<i8>
      %27 = llvm.call @printf(%26,%data) : (!llvm.ptr<i8>,i64) -> i64
	  
	  %3 = llvm.load %current: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	  %next = llvm.extractvalue  %3[1:i32]: !llvm.struct<"a", (i64, ptr<struct<"a">>)>
	  
	  scf.yield %next : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
	}
	%n10 = constant 10 : i32
    %12 = llvm.call @putchar(%n10):(i32)->i32 
	return %n1: i64 
}
func @queue(%0:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>{
%2 = constant 0: i64
%a1 = constant 1: i32
%b1 = llvm.getelementptr %0[%2,%a1] : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>>
%1 = llvm.load %b1: !llvm.ptr<!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>>

return %1: !llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>
}
func @tete(%0:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->i64{
%2 = constant 0: i64
%a1 = constant 0: i32
%b1 = llvm.getelementptr %0[%2,%a1] : (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>, i64, i32) -> !llvm.ptr<i64>
%1 = llvm.load %b1: !llvm.ptr<i64>

return %1: i64
}
func @estvide(%0:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->i1{
%2 = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
%1 = llvm.icmp "eq" %0, %2 : !llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>

return %1: i1
}
func @conc(%0:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,%1:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>{

%3 = call @estvide(%0): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i1)

 %2 = scf.if %3 -> !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>{
scf.yield %1: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
} else{
%4 = call @tete(%0): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i64)

%6 = call @queue(%0): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%5 = call @conc(%6,%1): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%7 = call @cons(%4,%5): (i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)
scf.yield %7: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}

return %2: !llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>
}
func @conchy(%0:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,%1:!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>{
%5 = constant 7: i64
%6 = constant 2: i64

%3 = addi %5, %6 : i64

%7 = call @estvide(%0): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i1)

 %4 = scf.if %7 -> !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>{
scf.yield %1: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
} else{
%8 = call @tete(%0): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i64)

%10 = call @queue(%0): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%9 = call @conchy(%10,%1): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%11 = call @cons(%8,%9): (i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)
scf.yield %11: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}

%2 = call @cons(%3,%4): (i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)

return %2: !llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>
}
func @main(){
%0 = constant 7: i64
%1 = llvm.mlir.null : !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
%5 = constant 5: i64
%bool0 = constant 0: i1

%2 = call @cons(%0,%1): (i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)

%3 = select %bool0, %2, %2 : !llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>
%a4 = constant dense<[10,11,12,13,14]> : vector<5xi64>
%4= call @init(%a4, %5):(vector<5xi64>, i64)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
)%a6 = constant dense<[15,11,12,13,14]> : vector<5xi64>
%6= call @init(%a6, %5):(vector<5xi64>, i64)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
)
%8 = call @conc(%4,%6): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%7 = call @conc(%3,%8): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%9 = call @printli(%7): (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(i64)


%11 = call @estvide(%4): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i1)

 %10 = scf.if %11 -> !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>{
scf.yield %6: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
} else{
%12 = call @tete(%4): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i64)

%14 = call @queue(%4): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%13 = call @conc(%14,%6): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%15 = call @cons(%12,%13): (i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)
scf.yield %15: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}

%16 = call @printli(%10): (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(i64)



%18 = call @estvide(%6): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i1)

 %17 = scf.if %18 -> !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>{
scf.yield %4: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
} else{
%19 = call @tete(%6): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(i64)

%21 = call @queue(%6): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%20 = call @conc(%21,%4): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%22 = call @cons(%19,%20): (i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)
scf.yield %22: !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>
}

%23 = call @printli(%17): (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(i64)



%24 = call @conchy(%4,%6): (!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>,!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a",(i64, ptr<struct<"a">>)>>)

%25 = call @printli(%24): (!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(i64)


return
}
}