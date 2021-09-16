extern crate once_cell;
extern crate pest;
#[macro_use]
extern crate pest_derive;

use once_cell::sync::Lazy; // 1.3.1
use std::sync::Mutex;

use std::ops::RangeFrom;
use pest::Parser;
use std::fs;
use pest::iterators::Pair;
use pest::iterators::Pairs;
#[derive(Parser)]
#[grammar = "truenim.pest"]
pub struct HLParser;
 
#[allow(non_snake_case)]
fn main() {
    let Arg = ::std::env::args().nth(1);
    let name = match Arg.as_ref().map(|s| &s[..]) {
        Some(lol) => lol,
		_ => "./test.hl"
    };
    let unparsed_file = fs::read_to_string(name).expect(name);

    let file = HLParser::parse(Rule::main, &unparsed_file).expect("unsuccessful parse");
    
    settypes(&"printli".to_string(),&"(!llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>)->(i64)".to_string());
    settypes(&"cons".to_string(),&r#"(i64, !llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)->(!llvm.ptr<!llvm.struct<"a", (i64, ptr<struct<"a">>)>>)"#.to_string());
    let mut outp="".to_string();
    for line in file{
		_print_ast(&line,0);
    	outp+=&format!("{}",choice(line))
	}
    outp+="}\n}";
    let header=r###"module {
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
"###.to_string()+getarrstr().as_str();
    fs::write("./codegen/out.mlir",header+outp.as_str()).expect("Unable to write file");
}
fn getarrconst() -> String{
    let values=ARRAY.lock().unwrap().clone();
    let mut res="".to_string();
    for x in values {
    	if let Ok(_) = x.parse::<i64>(){
    	res+=format!("%{} = constant {}: i64\n",ssanum(&x), x).as_str();
    	} else if x=="liVide"{
    	res+=format!("%{} = llvm.mlir.null : !llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>\n",ssanum(&x)).as_str();
    	}
    }
    let bvalues=BARRAY.lock().unwrap().clone();
    for x in bvalues {
    	res+=format!("%bool{} = constant {}: i1\n",ssabool(&x), x).as_str();
	}
    return res
}
fn getarrstr() -> String{
	println!("{}", 3);
    let values=SARRAY.lock().unwrap().clone();
    let mut res="".to_string();
    for x in values {
    	res+=format!("llvm.mlir.global constant @{a}(\"{a}\\00\")\n",a=rem_first_and_last(&x)).as_str();
	}
    return res
}

fn _print_type_of<T>(_: &T) {
    println!("{}", std::any::type_name::<T>())
}
fn _print_ast(pair: &pest::iterators::Pair<'_, Rule>, indent: usize) {
    let inner_pairs = pair.clone().into_inner();
    if inner_pairs.clone().count() > 0 {
        println!("{:indent$}{:#?}", "", pair.as_rule(), indent = indent);
        for inner_pair in inner_pairs {
            _print_ast(&inner_pair, indent + 2);
        }
    }else{
        println!("{:indent$}{:#?}: {}", "", pair.as_rule(), pair.as_span().as_str(), indent = indent);
    }
}
fn makeindex(x:Pair<Rule>) -> String{
		if x.as_rule()==Rule::iter{
		    let mut nums=x.clone().into_inner().next().unwrap().into_inner();
			let mut res="".to_string();
			let a =nums.next().unwrap();
			let mut varra="".to_string();
			res+= &choice(a.clone());
			res+=if let Ok(_) = a.as_str().to_string().parse::<i64>(){
    			varra=format!("%in{} = constant {}: index\n",ssanum(&a.as_str().to_string()), a.as_str().to_string());
    			varra.as_str()
			} else {
				varra=format!("%in{a} = std.index_cast %{a}: i64 to index\n",a=ssanum(&a.as_str().to_string()));
				varra.as_str()
			};
			let b =nums.next().unwrap();
			let mut varrb="".to_string();
			res+= &choice(b.clone());
			res+=if let Ok(_) = b.as_str().to_string().parse::<i64>(){
				varrb=format!("%in{} = constant {}: index",ssanum(&b.as_str().to_string()), b.as_str().to_string());
				varrb.as_str()
			} else {
				varrb=format!("%in{a} = std.index_cast %{a}: i64 to index",a=ssanum(&b.as_str().to_string()));
				varrb.as_str()
			};
			res
		} else if let Ok(_) = x.as_str().to_string().parse::<i64>(){
    		format!("%{} = constant {}: index",ssanum(&choice(x.clone())), choice(x))
    	} else {
    		format!("%in{a} = std.index_cast %{a}: i64 to index",a=ssanum(&choice(x)))
    	}
}

fn forloop(mut n:Pairs<Rule>)-> String{
  format!("%in1 = constant 1 : index\n{i}\nscf.for %in{a} = {b} step %in1{{\n%{a} = std.index_cast %in{a}: index to i64{c}}}\n", a=n.next().unwrap().as_str().to_string(),
  i=makeindex(n.clone().next().unwrap()), b=choice(n.next().unwrap()), c=choice(n.next().unwrap()))
    //choice(n.clone().into_inner().nth(2).unwrap().into_inner())
}
fn ifexpr(mut n:Pairs<Rule>)-> String{
  format!("if {} {}", choice(n.next().unwrap()), choice(n.next().unwrap()))

}
fn binop(mut n:Pairs<Rule>)-> String{
        if n.clone().next().unwrap().as_rule()==Rule::baseop {
      	return choice(n.next().unwrap())
      	}
      	if n.clone().next().unwrap().as_rule()==Rule::basevalue {
      	return choice(n.next().unwrap())
      	}
	 		  if n.clone().nth(1).unwrap().as_rule()==Rule::pow {return format!("{}_i32.pow({})", choice(n.next().unwrap()), choice(n.nth(1).unwrap()))}
	 		  if n.clone().nth(1).unwrap().as_rule()==Rule::times {return format!("&{}.repeat({})", choice(n.next().unwrap()), choice(n.nth(1).unwrap()))}
	 		  if n.clone().nth(1).unwrap().as_rule()==Rule::urem {return format!("{} urem {}", choice(n.next().unwrap()), choice(n.nth(1).unwrap()))}
	 		  unreachable!()
}
fn _stringymatch(mut n:Pairs<Rule>)-> String{
//match (i%3, i%5) { }  .as_str()
	let mut conds=choice(n.clone().nth(1).unwrap());
	let mut count=3;
	while	n.clone().nth(count)!=None{
		conds+=",";
		conds+=&choice(n.clone().nth(count).unwrap());
		count+=2;
	}
	let ins=format!("({}) => {a}.to_string()+&{b}, (true, _) => {a}.to_string(), (_, true) => {b}.to_string(), (_, _) => i.to_string()",
		"true".to_string()+&", true".repeat((count-3)/2),
		a=choice(n.next().unwrap()),
		b=choice(n.nth(1).unwrap()));
  	format!("match ({}) {{\n{}\n}}", conds, ins)
}
fn stringy(mut n:Pairs<Rule>)-> String{
/*	  %x= if %arg0 urem 3 eq 0
        print "fizz"
        yield 1
      else 
        yield 0
      %y= if %arg0 urem 5 eq 0
        print "buzz"
        yield 1
      else 
        yield 0
      if %x plus %y eq 0
        print "%d", arg0
      print "\OA"*/
	let mut allifcond="".to_string();
	while	n.clone().nth(2)!=None{
		allifcond+=&format!("%{} = scf.if {a}{{\nprint {b}\nyield 1\n}} else {{yield 0}}\n", suivant(), b=choice(n.next().unwrap()), a=choice(n.next().unwrap()));
	}
	allifcond+=&format!("%sum2 = addi %{}, %{}\n", current()-2, current()-3);
	allifcond+=&format!("%sum1 = addi %sum2, %{}\n", current()-1);
	allifcond+=&format!("%sum0 = addi %sum1, %{}\n", current()-0);
  format!("{}if %sum0 eq 0 {{print \"%d\", {}}}",allifcond,choice(n.next().unwrap()))
}
fn _ifsexpr(mut n:Pairs<Rule>)-> String{
  format!("if {} {{\n{}\n}} else {{\"\"}}", choice(n.clone().nth(0).unwrap()), choice(n.nth(1).unwrap()))

}
static mut PR: RangeFrom<i32> = 0..;
static mut PPR: i32 = 0;

fn suivant()->i32{unsafe{PPR=PR.next().unwrap();PPR}}
fn current()->i32{unsafe{PPR}}


static ARRAY: Lazy<Mutex<Vec<String>>> = Lazy::new(|| Mutex::new(vec![]));
fn ssanum(s:&String) -> usize{
	if ARRAY.lock().unwrap().clone().iter().position(|x| x == s)==None{
    	ARRAY.lock().unwrap().push(s.clone());
    }
    return ARRAY.lock().unwrap().clone().iter().position(|x| x == s).unwrap()
}
static BARRAY: Lazy<Mutex<Vec<String>>> = Lazy::new(|| Mutex::new(vec![]));
fn ssabool(s:&String) -> usize{
	if BARRAY.lock().unwrap().clone().iter().position(|x| x == s)==None{
    	BARRAY.lock().unwrap().push(s.clone());
    }
    return BARRAY.lock().unwrap().clone().iter().position(|x| x == s).unwrap()
}
fn clearssanum() {
	ARRAY.lock().unwrap().clear();
	BARRAY.lock().unwrap().clear();
}
static SARRAY: Lazy<Mutex<Vec<String>>> = Lazy::new(|| Mutex::new(vec![]));
fn ssastr(s:&String){
	if SARRAY.lock().unwrap().clone().iter().position(|x| x == s)==None{
    	SARRAY.lock().unwrap().push(s.clone());
    }
}

static TARRAY1: Lazy<Mutex<Vec<String>>> = Lazy::new(|| Mutex::new(vec![]));
static TARRAY2: Lazy<Mutex<Vec<String>>> = Lazy::new(|| Mutex::new(vec![]));

fn gettypes(s:&String) ->String{
	//println!("{}", s);
	let place=TARRAY1.lock().unwrap().clone().iter().position(|x| x == s).unwrap();
	return TARRAY2.lock().unwrap().clone().iter().nth(place).unwrap().to_string()

}
fn settypes(s:&String,t:&String){
	if TARRAY1.lock().unwrap().clone().iter().position(|x| x == s)==None{
    	TARRAY1.lock().unwrap().push(s.clone());
    	TARRAY2.lock().unwrap().push(t.clone());
    }
}
fn rem_first_and_last(value: &str) -> &str {
    let mut chars = value.chars();
    chars.next();
    chars.next_back();
    chars.as_str()
}

fn choice(n:Pair<Rule>)-> String{
    match n.as_rule() {
      Rule::expr|Rule::iter|Rule::when|Rule::int|Rule::string|Rule::alpha|Rule::main|Rule::digit|Rule::nl|Rule::tab|Rule::pge|Rule::pg|Rule::not|Rule::eq|Rule::urem|Rule::WHITESPACE|Rule::binvalue|Rule::svalue|Rule::rvalue|Rule::pow|Rule::times => {
      	if let Some(tail)=n.clone().into_inner().next(){
      	return choice(tail)
      	}
      	"".to_string()
      }
      Rule::body =>{clearssanum();
      	let mut outp = "".to_string();//choice(n.clone().into_inner().next().unwrap()
      	for line in n.into_inner(){
    		outp+=&format!("{}",choice(line));
		}
		format!("func @main(){{\n{a}{b}\n",b=outp, a={println!("{:?}", ARRAY); getarrconst()})},
      Rule::basevalue => "".to_string(),
      Rule::baseop =>{
      	let op = match  n.clone().into_inner().nth(1).unwrap().as_rule(){
      	 Rule::times =>"muli",
      	 Rule::plus =>"addi",
      	 Rule::minus =>"subi",
      	 _ =>"error"
      	};
      	
      	format!("{}\n{} = {} {}, {} : i64\n",
      		choice(n.clone().into_inner().nth(2).unwrap())+&choice(n.clone().into_inner().nth(0).unwrap()),
      		"%".to_string()+ssanum(&n.as_str().to_string()).to_string().as_str(), op,
      		"%".to_string()+ssanum(&n.clone().into_inner().next().unwrap().as_str().to_string()).to_string().as_str(),
      		"%".to_string()+ssanum(&n.clone().into_inner().nth(2).unwrap().as_str().to_string()).to_string().as_str()
      	)
      	/*else if n.clone().into_inner().nth(1).unwrap().as_rule()==Rule::plus {format!("%sum_next = addi {}, {} : i64)", choice(n.clone().into_inner().next().unwrap()), choice(n.into_inner().nth(2).unwrap()))}*/
      	//else {"%".to_string()+ssanum(&n.as_str().to_string()).to_string().as_str()}
      }
	  Rule::assign => {
         format!("{}\n%{} = select %bool{}, %{a}, %{a} : {}\n", choice(n.clone().into_inner().nth(2).unwrap()),
         	ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()), ssabool(&"0".to_string()),
         	choice(n.clone().into_inner().nth(1).unwrap()), a=ssanum(&n.into_inner().nth(2).unwrap().as_str().to_string())
         )
        }
      Rule::ty =>{
      	match n.as_str(){
      	"liste" =>{"!llvm.ptr<!llvm.struct<\"a\",(i64, ptr<struct<\"a\">>)>>".to_string()}
      	"bool" =>{"i1".to_string()}
      	_=>{"i64".to_string()}
      	}
      }
      Rule::atfunc =>{//    settypes(&"conc".to_string(),&"(i64, i64)->()".to_string());
      	clearssanum();
      	let mut args="(".to_string();
      	let mut a=n.clone().into_inner();
      	let _ =a.next();
      	while a.clone().nth(1).unwrap().as_rule()!=Rule::block{
      		let _ =a.next();
			args+=choice(a.next().unwrap()).as_str();
			if a.clone().nth(2)!=None{
				args+=","
			}
		}
		args+=")->(";
		let restype=choice(a.next().unwrap());
		args+=restype.as_str();
		args+=")";
		settypes(&n.clone().into_inner().nth(0).unwrap().as_str().to_string(),&args);
		
		let mut b=n.clone().into_inner();
		let mut inputs="".to_string();
		let _ =b.next();
		while b.clone().nth(1).unwrap().as_rule()!=Rule::block{
			inputs+="%";
      		inputs+=ssanum(&b.next().unwrap().as_str().to_string()).to_string().as_str();
      		inputs+=":";
			inputs+=choice(b.next().unwrap()).as_str();
			if b.clone().nth(2)!=None{
				inputs+=","
			}
		}
		format!("func @{}({})->{}{{\n{a}{b}\nreturn %{}: {}\n}}\n", n.clone().into_inner().nth(0).unwrap().as_str(), inputs, restype, ssanum(&a.clone().next().unwrap().into_inner().nth(0).unwrap().into_inner().nth(0).unwrap().as_str().to_string()), restype.as_str(), b=choice(a.next().unwrap()), a={println!("{:?}", ARRAY); getarrconst()})
		
      }
      Rule::func =>{
      	let mut args="".to_string();
      	let mut a=n.clone().into_inner();
      	let _ =a.next();
        while a.clone().nth(0)!=None{
			args+=&("%".to_string()+ssanum(&a.next().unwrap().as_str().to_string()).to_string().as_str());
			if a.clone().next()!=None{
				args+=","
			}
		}
        let mut colargs="".to_string();
        let mut b=n.clone().into_inner();
        let _ =b.next();
        while b.clone().next()!=None{
      		colargs+= &choice(b.next().unwrap());
      	}
        format!("{}\n%{} = call @{}({}): {}\n", colargs, ssanum(&n.clone().as_str().to_string()), n.clone().into_inner().next().unwrap().as_str(), args, gettypes(&n.into_inner().next().unwrap().as_str().to_string()))
        }
      Rule::assignarray => {
      	 format!("{}\n%a{a} = llvm.getelementptr %{}[%{},%{b}] : (!llvm.ptr<vector<5 x i64>>, i64, i64) -> !llvm.ptr<i64>\n%{a} = llvm.load %a{a}: !llvm.ptr<i64>\n", choice(n.clone().into_inner().nth(2).unwrap()), ssanum(&n.clone().into_inner().nth(1).unwrap().as_str().to_string()), ssanum(&"0".to_string()), a=ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()), b=ssanum(&n.into_inner().nth(2).unwrap().as_str().to_string()))
        }
      Rule::lastline => {
      	 if let Some(tail)=n.clone().into_inner().next(){
      		return format!("return {}", tail)
      	 }
      	"return\n".to_string()
        }
      Rule::array => {
         format!("{}\n%a{a} = llvm.getelementptr %{}[%{},%{b}] : (!llvm.ptr<vector<5 x i64>>, i64, i64) -> !llvm.ptr<i64>\n%{a} = llvm.load %a{a}: !llvm.ptr<i64>\n", choice(n.clone().into_inner().nth(1).unwrap()), ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()),ssanum(&"0".to_string()), a=ssanum(&n.clone().as_str().to_string()), b=ssanum(&n.into_inner().nth(1).unwrap().as_str().to_string()))
        }
      Rule::assignlist => {
         format!("%a{a} = constant dense<{c}> : vector<{d}xi64>\n%{a}= call @init(%a{a}, %{b}):(vector<{d}xi64>, i64)->(!llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>\n)", a=ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()),  d=n.clone().into_inner().nth(1).unwrap().as_str().split(",").collect::<Vec<_>>().len(), b=ssanum(&n.clone().into_inner().nth(1).unwrap().as_str().split(",").collect::<Vec<_>>().len().to_string()), c=n.clone().into_inner().nth(1).unwrap().as_str()	)
        }
		Rule::ternary => {
         format!("{}\n %{} = scf.if %{} -> !llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>{{\n{}scf.yield %{}: !llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>\n}} else{{{}scf.yield %{}: !llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>\n}}\n", choice(n.clone().into_inner().next().unwrap()),ssanum(&n.clone().into_inner().as_str().to_string()),  ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()), choice(n.clone().into_inner().nth(1).unwrap()), ssanum(&n.clone().into_inner().nth(1).unwrap().as_str().to_string()), choice(n.clone().into_inner().nth(2).unwrap()), ssanum(&n.clone().into_inner().nth(2).unwrap().as_str().to_string()))
        }
      Rule::cond => {
      let op = match  n.clone().into_inner().nth(1).unwrap().as_rule(){
      	 Rule::pg =>"sgt",
      	 Rule::eq =>"eq",
      	 _ =>"error"
      	};
      if let Some(_)=n.clone().into_inner().nth(4){
		  choice(n.clone().into_inner().nth(2).unwrap())+&choice(n.clone().into_inner().nth(0).unwrap())+
		  format!("%c{a} = llvm.icmp \"{e}\" %{b}, %{c} : {f}\n%b{a} = cmpi {e}, %{d}, %{c} : {f}\n%{a} = llvm.and %c{a}, %b{a} : i1\n",
		  	a=ssanum(&n.as_str().to_string()).to_string().as_str(),
		  	b=ssanum(&n.clone().into_inner().next().unwrap().as_str().to_string()).to_string().as_str(),
		  	c=ssanum(&n.clone().into_inner().nth(2).unwrap().as_str().to_string()).to_string().as_str(),
		  	d=ssanum(&n.clone().into_inner().nth(4).unwrap().as_str().to_string()).to_string().as_str(),
		  	e=op,
		  	f=choice(n.clone().into_inner().nth(5).unwrap())
		  ).as_str()
      } else {
	  	choice(n.clone().into_inner().nth(2).unwrap())+&choice(n.clone().into_inner().nth(0).unwrap())+
	  	format!("{} = llvm.icmp \"{}\" {}, {} : {}\n", "%".to_string()+ssanum(&n.as_str().to_string()).to_string().as_str(), op,
	  	"%".to_string()+ssanum(&n.clone().into_inner().next().unwrap().as_str().to_string()).to_string().as_str(),
	  	"%".to_string()+ssanum(&n.clone().into_inner().nth(2).unwrap().as_str().to_string()).to_string().as_str(),
	  	choice(n.clone().into_inner().nth(3).unwrap())
	  	).as_str()}
      /*
				let mut a=n.into_inner();
				let mut alph=choice(a.next().unwrap());
				let condi=a.next().unwrap();
				let mut alph2=choice(a.next().unwrap());
				let mut res="".to_string();
        res+=&match condi.as_rule(){
        	Rule::eq=>{alph+" eq "+&alph2}
        	Rule::pge=>{alph+">="+&alph2}
        	Rule::pg=>{alph+">"+&alph2}
        	_=> unreachable!()
        };
        while let Some(condile)=a.next(){
					res+="&&";
					alph=alph2;
					alph2=choice(a.next().unwrap());
        	res+=&match condile.as_rule(){
        		Rule::eq=>{alph+" eq "+&alph2}
        		Rule::pge=>{alph+">="+&alph2}
        		Rule::pg=>{alph+">"+&alph2}
        		_=> unreachable!()
        	};
        }
        res
        
        //choice(n.into_inner().next().unwrap())
        */
        }
      Rule::itercc|Rule::iterco|Rule::iteroc|Rule::iteroo => {
        let mut nums=n.clone().into_inner();
        return format!("%in{} to %in{}", ssanum(&nums.next().unwrap().as_str().to_string()), ssanum(&nums.next().unwrap().as_str().to_string()))
      }
      Rule::printexpr => {
      	ssastr(&n.clone().into_inner().nth(0).unwrap().as_str().to_string());
      	format!("{}\n%a{a} = llvm.mlir.addressof @{e} : !llvm.ptr<array<{d} x i8>>\n%b{a} = llvm.getelementptr %a{a}[%{b}, %{b}] : (!llvm.ptr<array<{d} x i8>>, i64, i64) -> !llvm.ptr<i8>\n%c{a} = llvm.call @printf(%b{a}) : (!llvm.ptr<i8>) -> i32\n", choice(n.clone().into_inner().nth(0).unwrap()), e=rem_first_and_last(n.clone().into_inner().nth(0).unwrap().as_str()).to_string(), d=n.clone().into_inner().nth(0).unwrap().as_str().to_string().chars().count()-1,  a=ssanum(&n.clone().as_str().to_string()),b=ssanum(&"0".to_string()))
        }
      Rule::extraire => {
      	format!("%a{a} = constant {c}: i32\n%b{a} = llvm.getelementptr %{e}[%{b},%a{a}] : (!llvm.ptr<!llvm.struct<\"a\", (i64, ptr<struct<\"a\">>)>>, i64, i32) -> !llvm.ptr<{d}>\n%{a} = llvm.load %b{a}: !llvm.ptr<{d}>\n", d=choice(n.clone().into_inner().nth(2).unwrap()), c=n.clone().into_inner().nth(1).unwrap().as_str(), e=ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()), a=ssanum(&n.clone().as_str().to_string()), b=ssanum(&"0".to_string()))
        }
      Rule::printnum => {
      	format!("{}\n%a{a} = llvm.mlir.addressof @long : !llvm.ptr<array<4 x i8>>\n%b{a} = llvm.getelementptr %a{a}[%{b}, %{b}] : (!llvm.ptr<array<4 x i8>>, i64, i64) -> !llvm.ptr<i8>\n%c{a} = llvm.call @printf(%b{a},%{c}) : (!llvm.ptr<i8>, i64) -> i32\n", choice(n.clone().into_inner().nth(0).unwrap()), c=ssanum(&n.clone().into_inner().nth(0).unwrap().as_str().to_string()), a=ssanum(&n.clone().as_str().to_string()),b=ssanum(&"0".to_string()))
        }
      Rule::var => "".to_string(),
      Rule::binop => binop(n.into_inner()),
      Rule::printstringy => stringy(n.into_inner()),
      Rule::forloop => forloop(n.into_inner()),
			Rule::ifexpr => ifexpr(n.into_inner()),
			//Rule::ifsexpr => ifsexpr(n.into_inner()),
			Rule::end=>{
        "\n".to_string()+&choice(n.clone().into_inner().next().unwrap())+"\n"
      }
      Rule::choice=>{
        choice(n.clone().into_inner().next().unwrap())//+"\n"
      }
      Rule::block => {
        let mut outp="".to_string();
    		for line in n.into_inner(){
      		outp+=&format!("{}",choice(line))}
    		outp
        //unsafe{PR=vecnum[0]*vecnum[1]}
      }
      Rule::EOI =>{"".to_string()}  
      _   => {
      	if let Some(tail)=n.clone().into_inner().next(){
      	return choice(tail)
      	}
      	"".to_string()
      }
   }
}
