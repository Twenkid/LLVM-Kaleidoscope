# LLI LLC ... 24.5.2024

ill f.ll
clang++ -S -emit-llvm m.cpp -o m.ll
llc -filetype=obj -relocation-model=pic f.ll -o f.o
clang++ -fPIE -stdlib=libc++ -std=c++14 f.o -o f.exe

* Interpreter of ll code: ill f.ll
* Compile clang++ to ll code
* Compile to object file relocatable for linking then with gcc++ or clang++
* linking with clang++ ...

./f.exe


```
:/mnt/c/Users/.../llvm$ lli f.ll
lli f.ll
nc -zv 192.168.100.106 8089 //Android sockets test ...
gcc sock0.c -o sock0.exe
./sock0.exe
./c.exe
cd /mnt/c/cpp/net
ip neigh
;////////////
sudo apt install clang
sudo dpkg --configure -a
sudo apt install llvm-runtime
cd llvm
mkdir llvm
 gedit m.cpp
clang++ -S -emit-llvm m.cpp -o m.ll
gedit f.ll
ill f.ll
 lli m.ll
lli f.ll
gedit f.ll
llc f.ll
llc --help
./f.s
llc filetype=obj f.ll -o f.o | clang++ f.o -o f.exe
llc --help | more
ls /usr/lib/x86_64-linux-gnu
clang++ f.o -L/usr/lib/x86_64-linux-gnu -o f.exe
ldconfig -p | grep libstdc++
clang++ f.o -L/lib/x86_64-linux-gnu/ -o f.exe
clang++ f.o -lstdc++ -o f.exe
clang++ -version
llc --version
g++ f.o -o f.exe
clang++ f.o -o f.exe -lstdc++
ls /usr/bin/ld
ldconfig -p | grep libstdc++
clang++ f.o -v -o f.exe -lc++
find ld
whereis ld
clang++ f.o -v -L /lib/x86_64-linux-gnu/ -o f.exe
 clang++ f.o -v -o f.exe
whereis libstdc++.so
ln -s /lib/x86_64-linux-gnu/libstdc++.so.6 libstdc++.so
llc -filetype=object f.ll
llc -filetype=obj f.ll -fPIE
llc -filetype=obj -fPIE f.ll
clang f.o -o f.exe -fPIE
clang -fPIE f.o -o f.exe
clang++ -fPIE f.o -o f.exe
clang -fPIE f.o -o f.exe -L/lib/x86_64-linux-gnu/libstdc++.so
clang++ -fPIE f.o -o f.exe -L/lib/x86_64-linux-gnu/libstdc++.so
g++ f.o -o f.exe
g++ -fPIE f.o -o f.exe
llc -fPIE -filetype=obj f.ll
llc -filetype=obj -relocation-model=pic f.ll -o f.o
g++ -fPIE f.o -o f.exe
clang++ -fPIE f.o -o fc.exe
g++ -fPIE f.o -o f.exe
clang++ -fPIE -v f.o -o f.exe -L/lib/x86_64-linux-gnu/libstdc++.so
where is libstdc++.so
whereis libstdc++.so
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 .
mv libstdc++.so libstdc++.so
clang++ -fPIE f.o -o f.exe
 clang++ -fPIE -stdlib=libc++ -std=c++14 f.o -o f.exe
whereis libc++
sudo apt install libc++
apt search libc++ | grep libc++
sudo apt install libc++-14-dev libc++abi-14-dev
clang++ -fPIE -stdlib=libc++ -std=c++14 f.o -o f.exe
./f.exe
clang++  -stdlib=libc++ -std=c++14 f.o -o f.exe
clang++ -fPIE -stdlib=libc++ -std=c++14 -O3 f.o -o f.exe
clang++ -fPIE -stdlib=libc++ -std=c++14 -O3 f.o -o f1.exe
./f1.exe
 gedit f.ll
```

```ll
;Declare printf
;declare i32 @printf(i8* nocapture, ...)
declare i32 @printf(i8*, ...) 

;@.str = private unnamed_addr constant [14 x i8] c"Hello, World!\00"
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00" ; Format string for printing an integer and newline
;@.str = private unnamed_addr constant [14 x i8] c"Hello, World!\00"

; Declare the function
define i32 @fibonacci(i32 %n) {
entry:
  ; Base cases
  %cond1 = icmp eq i32 %n, 0           
  br i1 %cond1, label %ret0, label %cont

ret0:                                          
  ret i32 0

cont:
  %cond2 = icmp eq i32 %n, 1          
  br i1 %cond2, label %ret1, label %recurse

ret1:                                          
  ret i32 1

recurse:
  ; Recursive calls
  %n_minus_1 = sub i32 %n, 1
  %n_minus_2 = sub i32 %n, 2
  %fib1 = call i32 @fibonacci(i32 %n_minus_1)
  %fib2 = call i32 @fibonacci(i32 %n_minus_2)

  ; Add results
  %result = add i32 %fib1, %fib2
  ret i32 %result
}

define i32 @main(){
  %result = call i32 @fibonacci(i32 33)   ; Get the 10th Fibonacci number
  %fmt_arg = getelementptr [4 x i8], [4 x i8]* @.str, i64 0, i64 0 ; Pointer to the format string
  call i32 (i8*, ...) @printf(i8* %fmt_arg, i32 %result) ; Call printf
  call i32 @fibonacci(i32 5)
  ret i32 0
}
```


