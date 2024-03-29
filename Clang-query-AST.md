## Clang.md
...
AST
sudo apt-get update
sudo apt-get install clang-tools
clang-query

...

https://devblogs.microsoft.com/cppblog/exploring-clang-tooling-part-1-extending-clang-tidy/
https://devblogs.microsoft.com/cppblog/exploring-clang-tooling-part-2-examining-the-clang-ast-with-clang-query/
https://devblogs.microsoft.com/cppblog/exploring-clang-tooling-part-3-rewriting-code-with-clang-tidy/
https://clang.llvm.org/docs/LibASTMatchersReference.html#traversal-matchers


clang-query ast.cpp --
clang-query> ...

Only one file?

For many: Google ClangMR, large-scle refactoring ...


Large-Scale Automated Refactoring Using ClangMRhttps://research.google › pubs › pub41342
by H Wright · 2013 · Cited by 49 — In this paper, we present a real-world implementation of a system to refactor large C++ codebases efficiently. A combination of the Clang compiler framework and ...
4 pages

https://research.google/pubs/pub41342/
https://storage.googleapis.com/pub-tools-public-publication-data/pdf/41342.pdf

* Millions lines of code, C++ ... BigTable, AST ..
* 
* Indexer, Matcher, Refactorer
* User: node matching expression, callbacks on match 
* Filters, Traversals 

"1) Node Matching Expression: Developers use node matching expressions to register a callback with the ClangMR processor. These expressions may match a variety of node types,
and can be qualified with various logical filters and traversal
operations. Examples of node matching expressions used at
Google are shown in Figure 2, and a complete reference is
available on the Clang website [9].
2) Callbacks: When the preprocessor matches a node in
the AST, it invokes the provided callback with the node and
some context about where it was found, such as the source
location. The callback is written in C++, allowing it to query
the properties of the node and its context and make complex
decisions about what edits, if any, can be applied. They may
also decide to not make any edits. This technique allows
for much more powerful transformations than pure textual
substitution"

```StatementMathermatcher=
callExpr(allOf(
         argumentCountIs(1),
         callee(functionDecl(hasName(
         ”::Foo::Bar”)))))
          .bind(”call”);

(a) Match all calls to Foo::Bar which have a single
argument

TypeLocMatcher matcher=
loc(qualType(hasDeclaration(
             recordDecl(hasName(
              ”::scopedarray”)))))
              .bind(”loc”);

//Callback
voidRefactor(constMatchFinder::MatchResult&res){
  Clang::CXXMemberCallExpr∗ call=res.Nodes.getStmtAs<clang::CXXMemberCallExpr>(”call”);
  constclang::MemberExpr ∗memberexpr=llvm::dyncast<clang::MemberExpr>(call−>getCallee());
  EditState state(res,call); 
  state.ReplaceToken(memberexpr−>getMemberLoc(), ”Baz”);
  Report(&state);
}

```

...
_C. Refactorer
The source refactorer reads the list of edit commands
generated by the node matcher callbacks and filters out any
duplicate, overlapping or conflicting edit instructions before
editing the source code in the local version control client. Each
edit is processed serially in the version control client on the
local workstation of the developer, which is synchronized to
the version of code stored in the compilation index.
Even though it is local and serial, in practice, this step
is relatively quick, and edits spanning thousands of files are
performed on the order of tens of seconds. A final pass with
ClangFormat, a Clang-based formatting tool [10], ensures the
resulting code meets formatting and style guide recommendations_

...

* https://devblogs.microsoft.com/cppblog/exploring-clang-tooling-part-2-examining-the-clang-ast-with-clang-query/

(...)

clang-query main.cpp
...
```
m functionDecl(hasDescendant(callExpr().bind("functionCall")))

m callExpr(hasArgument(0, integerLiteral()), callee(functionDecl(hasName("addTwo"))))

set output dump 

m callExpr(hasArgument(0, expr().bind("a1")), hasArgument(1, expr().bind("a2")), hasArgument(2, expr().bind("a3"))) 

Match #1: 

Binding for "a1": 
DeclRefExpr <testfile.cpp:15:14> 'int' 'argc'

Binding for "a2": 
CallExpr <testfile.cpp:15:20, col:29> 'int' 
|-ImplicitCastExpr <col:20> 'int (*)(int, int)' 
| `-DeclRefExpr <col:20> 'int (int, int)' 'add' 
|-IntegerLiteral <col:24> 'int' 42 
`-ImplicitCastExpr <col:28> 'int' 
  `-DeclRefExpr <col:28> 'int' 'i' 

Binding for "a3": 
BinaryOperator <testfile.cpp:15:32, col:36> 'int' '*' 
|-IntegerLiteral <col:32> 'int' 4 
`-IntegerLiteral <col:36> 'int' 7 
```

