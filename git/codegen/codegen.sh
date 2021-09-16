echo &&
echo 'codegen...' &&
echo &&
pathy=./codegen &&
$pathy/mlir-opt $pathy/out.mlir --convert-scf-to-std --convert-std-to-llvm > $pathy/nimpass.mlir &&
$pathy/toyc-ch7 -opt $pathy/nimpass.mlir -emit=llvm &> $pathy/debuggy.ll &&
clang $pathy/debuggy.ll -o $pathy/hello &&
echo &&
echo 'running...' &&
echo &&
echo 'main, x:=1
while x!=2
print x
x+=1
for x in [1;2]
print x,0,2,whiloop, x:=1
while x!=2
print x
x+=1,3,0,forloop, for x in [1;2]
print x,0,0' | $pathy/hello;
