module {
llvm.mlir.global constant @longn("%ld \00")
llvm.mlir.global external @stdin() : !llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>
llvm.mlir.global constant @__const.main.months("main, x:=1\0Awhile x!=2\0Aprint x\0Ax+=1\0Afor x in [1;2]\0Aprint x, 0, 2, whileloop, x:=1\0Awhile x!=2\0Aprint x\0Ax+=1, 3, 0, forloop, for x in [1;2]\0Aprint x, 0, 0\00")
llvm.func @free(!llvm.ptr<i8>)
llvm.func @malloc(i64) ->!llvm.ptr<i8>
llvm.func @printf(!llvm.ptr<i8>, ...) -> i64
llvm.func @puts(!llvm.ptr<i8>) -> i32
llvm.func @putchar(i32) -> i32
llvm.func @strlen(!llvm.ptr<i8>) -> i64
llvm.func @strtok(!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
llvm.func @strdup(!llvm.ptr<i8>) -> !llvm.ptr<i8>
llvm.func @strcpy(!llvm.ptr<i8>,  !llvm.ptr<i8>)-> !llvm.ptr<i8>
llvm.func @strtol(!llvm.ptr<i8>, !llvm.ptr<!llvm.ptr<i8>>, i32)-> i64
llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
llvm.func @llvm.memset.p0i8.i64(!llvm.ptr<i8>, i8, i64, i1) -> ()
llvm.func @getdelim(!llvm.ptr<!llvm.ptr<i8>>, !llvm.ptr<i64>, i32, !llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>) -> i64
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

func @str_split(%0: !llvm.ptr<i8>, %1: i8) -> !llvm.ptr<!llvm.ptr<i8>> {
	%null = llvm.mlir.null : !llvm.ptr<i8>
	%n1i8 = constant 1: i8
	%n0i8 = constant 0: i8
	%n0 = constant 0: i64
	%n3 = constant 3: i64
	%n8 = constant 8: i64
	%n1 = constant 1: i64
	%nm1 = constant -1: i64
    %4 = llvm.alloca %n1i8 x i8: (i8) -> !llvm.ptr<i8>
    llvm.store %1, %4: !llvm.ptr<i8> 
    
    %6 = llvm.load %0: !llvm.ptr<i8>
    
	%a, %22, %c, %21 = scf.while (%a = %6, %b=%null, %c=%0, %d=%n0) : (i8, !llvm.ptr<i8>, !llvm.ptr<i8>, i64) ->
		(i8, !llvm.ptr<i8>, !llvm.ptr<i8>, i64) {	
	  %condition = llvm.icmp "ne" %a, %n0i8: i8
	  scf.condition(%condition) %a,%b,%c,%d : i8, !llvm.ptr<i8>, !llvm.ptr<i8>, i64
	} do {
	^bb0(%9:i8, %10:!llvm.ptr<i8>, %11:!llvm.ptr<i8>, %12:i64):
	  %13 =  llvm.icmp "eq" %9, %1: i8
	  %14 = llvm.zext %13: i1 to i64
	  %15 = addi %12, %14: i64 
	  %16 = select %13, %11, %10: !llvm.ptr<i8>
	  %17 = llvm.getelementptr %11[%n1] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
	  %18 = llvm.load %17: !llvm.ptr<i8> 
	  scf.yield %18, %16, %17, %15: i8, !llvm.ptr<i8>, !llvm.ptr<i8>, i64
	}
	
	%23 = llvm.call @strlen(%0): (!llvm.ptr<i8>) -> i64
	%24 = llvm.getelementptr %0[%23] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
	%25 = llvm.getelementptr %24[%nm1] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
	%26 = llvm.icmp "ult" %22, %25: !llvm.ptr<i8> 
	%27 = llvm.zext %26: i1 to i64
	%28 = addi %21, %27: i64
	%29 = llvm.shl %28, %n3: i64
	%30 = addi %29, %n8: i64
	%31 = llvm.call @malloc(%30): (i64) -> !llvm.ptr<i8>
	%32 = llvm.bitcast %31: !llvm.ptr<i8> to !llvm.ptr<!llvm.ptr<i8>>
	%33 = llvm.call @strtok(%0, %4): (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
	
	%i, %44 = scf.while (%36 = %33, %37=%n0) : (!llvm.ptr<i8>, i64) ->
		(!llvm.ptr<i8>, i64) {	
	  %condition =  llvm.icmp "ne" %36, %null: !llvm.ptr<i8>
	  scf.condition(%condition) %36, %37 : !llvm.ptr<i8>, i64
	} do {
	^bb0(%36:!llvm.ptr<i8>, %37:i64):
	  %38 = llvm.call @strdup(%36): (!llvm.ptr<i8>) -> !llvm.ptr<i8>
	  %39 = addi %37, %n1: i64
	  %40 = llvm.getelementptr %32[%37] : (!llvm.ptr<!llvm.ptr<i8>>, i64) -> !llvm.ptr<!llvm.ptr<i8>>
	  llvm.store %38, %40: !llvm.ptr<!llvm.ptr<i8>>
	  %41 = llvm.call @strtok(%null, %4): (!llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.ptr<i8>
	  scf.yield %41, %39: !llvm.ptr<i8>, i64
	}
	
	%45 = llvm.getelementptr %32[%44] : (!llvm.ptr<!llvm.ptr<i8>>, i64) -> !llvm.ptr<!llvm.ptr<i8>>
  	llvm.store %null, %45: !llvm.ptr<!llvm.ptr<i8>>
  	return %32: !llvm.ptr<!llvm.ptr<i8>>
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
  %n150i8 = constant 150: i8
  %n1i8 = constant 1: i8
  %n0i8 = constant 0: i8
  %n44i8 = constant 44: i8
  
  %n255i32 = constant 255: i32
  %n0i32 = constant 0: i32
  %n1i32 = constant 1: i32
  %n2i32 = constant 2: i32
  %n3i32 = constant 3: i32
  %n10i32 = constant 10: i32

  
  %n0 = constant 0: i64
  %n1 = constant 1: i64
  %n2 = constant 2: i64
  %n3 = constant 3: i64
  %n4 = constant 4: i64
  %n8 = constant 8: i64
  %n32 = constant 32: i64
  %n150 = constant 150: i64
  %n1008 = constant 1008: i64
  
  %false = constant 0: i1
  %null = llvm.mlir.null : !llvm.ptr<i8>
  %nullptr = llvm.mlir.null : !llvm.ptr<!llvm.ptr<i8>>
  
  //!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>
  //!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>
  
  %3 = llvm.alloca %n1 x i64: (i64) -> !llvm.ptr<i64>
  %bufptr = llvm.alloca %n1i8 x i8: (i8) -> !llvm.ptr<!llvm.ptr<i8>>
  %2 = llvm.alloca %n8 x !llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>: (i64) -> !llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>
  llvm.store %n1008, %3: !llvm.ptr<i64>
  %mall = llvm.call @malloc(%n1008): (i64) -> !llvm.ptr<i8>
  llvm.store %mall, %bufptr: !llvm.ptr<!llvm.ptr<i8>>
  %4 = llvm.mlir.addressof @stdin: !llvm.ptr<!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
  %450 = llvm.load %4: !llvm.ptr<!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
  %1= llvm.call @getdelim(%bufptr, %3, %n255i32, %450): (!llvm.ptr<!llvm.ptr<i8>>, !llvm.ptr<i64>, i32, !llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>) -> i64
  
  %buf = llvm.load %bufptr: !llvm.ptr<!llvm.ptr<i8>>
  %5 = llvm.call @puts(%buf): (!llvm.ptr<i8>) -> i32
  %toksptr= call @str_split(%buf, %n44i8): (!llvm.ptr<i8>, i8) -> !llvm.ptr<!llvm.ptr<i8>>
  llvm.call @free(%buf): (!llvm.ptr<i8>) -> ()
    
  //%1 = llvm.alloca %n1i8 x i8: (i8) -> !llvm.ptr<i8>
  //%1 = llvm.alloca %n150i8 x i8: (i8) -> !llvm.ptr<array<150 x i8>>
  //%3 = llvm.getelementptr %1[%n0, %n0] : (!llvm.ptr<array<150 x i8>>, i64, i64) -> !llvm.ptr<i8>
  //%4 = llvm.mlir.addressof @__const.main.months : !llvm.ptr<array<150 x i8>>
  //%5= llvm.getelementptr %4[%n0, %n0] : (!llvm.ptr<array<150 x i8>>, i64, i64) -> !llvm.ptr<i8>
  //llvm.call @llvm.memcpy.p0i8.p0i8.i64(%3, %5, %n150, %false): (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
  //%6= call @str_split(%3, %n44i8): (!llvm.ptr<i8>, i8) -> !llvm.ptr<!llvm.ptr<i8>>

   
  %7 = llvm.getelementptr %2[%n0, %n0i32, %n0] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32, i64) -> !llvm.ptr<i8>
  llvm.call @llvm.memset.p0i8.i64(%7, %n0i8, %n1008, %false): (!llvm.ptr<i8>, i8, i64, i1) -> ()


  %imax, %nmax = scf.while (%i = %n0, %n=%n1) : (i64, i64) -> (i64, i64) {
  	%currtokptr = llvm.getelementptr %toksptr[%i] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
 	%currtok = llvm.load %currtokptr: !llvm.ptr<!llvm.ptr<i8>>
	%condition = llvm.icmp "ne" %currtok, %null: !llvm.ptr<i8>
	scf.condition(%condition) %i, %n : i64, i64
  } do {
	^bb0(%i:i64, %n:i64):
	  %currtokptr = llvm.getelementptr %toksptr[%i] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
	  %31 = llvm.getelementptr %currtokptr[%n0] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
	  %10 = llvm.load %31: !llvm.ptr<!llvm.ptr<i8>>
	  %osef1 = llvm.call @puts(%10): (!llvm.ptr<i8>) -> i32
	  %33 = llvm.getelementptr %2[%n, %n0i32, %n0] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32, i64) -> !llvm.ptr<i8>
	  %34 = llvm.call @strcpy(%33, %10): (!llvm.ptr<i8>,  !llvm.ptr<i8>)-> !llvm.ptr<i8>
	  llvm.call @free(%10): (!llvm.ptr<i8>) -> ()
	  
	  %36 = llvm.getelementptr %currtokptr[%n1] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
	  %37 = llvm.load %36: !llvm.ptr<!llvm.ptr<i8>>
	  %osef2 = llvm.call @puts(%37): (!llvm.ptr<i8>) -> i32
	  %35 = llvm.getelementptr %2[%n, %n1i32, %n0] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32, i64) -> !llvm.ptr<i8>
	  %38 = llvm.call @strcpy(%35, %37): (!llvm.ptr<i8>,  !llvm.ptr<i8>)-> !llvm.ptr<i8>
	  llvm.call @free(%37): (!llvm.ptr<i8>) -> ()
	  
	  %39 = llvm.getelementptr %currtokptr[%n2] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
	  %40 = llvm.load %39: !llvm.ptr<!llvm.ptr<i8>>
	  %osef3 = llvm.call @puts(%40): (!llvm.ptr<i8>) -> i32
	  %41 = llvm.call @strtol(%40, %nullptr, %n10i32): (!llvm.ptr<i8>, !llvm.ptr<!llvm.ptr<i8>>, i32)-> i64
	  %42 = llvm.shl %41, %n32: i64
	  %43 = llvm.ashr %42, %n32: i64
	  %44 = llvm.getelementptr %2[%43] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64) -> !llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>
	  %45 = llvm.getelementptr %2[%n, %n2i32] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32) -> !llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
	  llvm.store %44, %45: !llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
	  llvm.call @free(%40): (!llvm.ptr<i8>) -> ()
	  
	  %46 = llvm.getelementptr %currtokptr[%n3] : (!llvm.ptr<ptr<i8>>, i64) -> !llvm.ptr<ptr<i8>>
	  %47 = llvm.load %46: !llvm.ptr<!llvm.ptr<i8>>
	  %osef4 = llvm.call @puts(%47): (!llvm.ptr<i8>) -> i32
	  %48 =	llvm.call @strtol(%47, %nullptr, %n10i32): (!llvm.ptr<i8>, !llvm.ptr<!llvm.ptr<i8>>, i32)-> i64
	  %49 = llvm.shl %48, %n32: i64
	  %50 = llvm.ashr %49, %n32: i64
	  %51 = llvm.getelementptr %2[%50] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64) -> !llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>
	  %52 = llvm.getelementptr %2[%n, %n3i32] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32) ->!llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
	  llvm.store %51, %52: !llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
	  llvm.call @free(%47): (!llvm.ptr<i8>) -> ()

	  %np1 =  addi %n, %n1 : i64
	  %ip4 =  addi %i, %n4 : i64
	  scf.yield %ip4, %np1: i64, i64
  }
  
  
  %27 =llvm.bitcast %toksptr: !llvm.ptr<!llvm.ptr<i8>> to !llvm.ptr<i8> 
  llvm.call @free(%27): (!llvm.ptr<i8>) -> ()
  
  %main = llvm.getelementptr %2[%n1] : (!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64) -> !llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>
  %13 = llvm.getelementptr %main[%n0, %n3i32] : (!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32) ->!llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
  %19 =  llvm.load %13: !llvm.ptr<!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
  %20 = llvm.getelementptr %19[%n0, %n0i32, %n0] : (!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32, i64) -> !llvm.ptr<i8>
  %22 = llvm.call @puts(%20): (!llvm.ptr<i8>) -> i32
  %15 = llvm.getelementptr %19[%n0, %n2i32] : (!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32) ->!llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
  %18 =  llvm.load %15: !llvm.ptr<!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
  %21 = llvm.getelementptr %18[%n0, %n0i32, %n0] : (!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32, i64) -> !llvm.ptr<i8>
  
  //%22 = call i32 (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i64 0, i64 0), i8* %20, i8* %21)

  %225 = llvm.call @puts(%21): (!llvm.ptr<i8>) -> i32
  
  %23= llvm.getelementptr %main[%n0, %n2i32] : (!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32) ->!llvm.ptr<!llvm.ptr<struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
  %24 =  llvm.load %23: !llvm.ptr<!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>>
  %25 = llvm.getelementptr %24[%n0, %n0i32, %n0] : (!llvm.ptr<!llvm.struct<"struct.pair", (array<8 x i8>, array<1000 x i8>, ptr<struct<"struct.pair">>, ptr<struct<"struct.pair">>)>>, i64, i32, i64) -> !llvm.ptr<i8>
  %26 = llvm.call @puts(%25): (!llvm.ptr<i8>) -> i32
  //%23 = getelementptr inbounds [8 x %struct.pair], [8 x %struct.pair]* %2, i64 0, i64 1, i32 2
  //%24 = load %struct.pair*, %struct.pair** %23, align 16, !tbaa !13
  //%25 = getelementptr inbounds %struct.pair, %struct.pair* %24, i64 0, i32 0, i64 0
  //%26 = call i32 @puts(i8* nonnull dereferenceable(1) %25)
  
  return
}

}
