;Declare printf
;declare i32 @printf(i8* nocapture, ...)
declare i32 @printf(i8*, ...) 

;@.str = private unnamed_addr constant [14 x i8] c"Hello, World!\00"
@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00" ; Format string for printing an integer and newline

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
  %result = call i32 @fibonacci(i32 33)   ; Get the 33th Fibonacci number
  %fmt_arg = getelementptr [4 x i8], [4 x i8]* @.str, i64 0, i64 0 ; Pointer to the format string
  call i32 (i8*, ...) @printf(i8* %fmt_arg, i32 %result) ; Call printf
  ;call i32 @fibonacci(i32 5)
  ret i32 0
}
