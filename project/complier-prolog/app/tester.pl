% note: all the predicates defined in this file start with the prefix test_
%       you are not allowed to reference any of these predicates in your own
%       solution.  if test_ appears anywhere in your lib/due190307.pl file
%       (even in a comment or string constant), it will be assumed you are 
%       trying to compromise the testing process and marked accordingly.

% A scanner will be defined as a list of scanner terms
%     where a scanner term is scanner(Token, RegularExpression)
%        where Token is the name the scanner returns if RegularExpression
%              matches an input string.  if there are multiple such matches,
%              the Token in the first scanner term in the list to match is
%              the one that should match.
%        where RegularExpression is a regular expression term defined later.

<<<<<<< HEAD
% from NFA definition in text:
=======
% from NFA definition in text: (see note below 190226)
>>>>>>> 890dac2977d24ee70b9228433af9fbfae45a881c
%     corresponds to term nfa(Start, States, Transitions)
%       Start is a state
%       States is a list of state terms
%       Transitions is a list of next terms
%     a state term has the form state(Name, Status)
%       where Name is a name given the state
%             Status is either
%                not_accepting if it is not an accepting state
%                Token         if it is an accepting state, when which Token
%                                 has been matched at this point.
<<<<<<< HEAD
=======

% 190226 note: https://wiki.csd.uwo.ca/display/CS33422017/the+making+of+phase+1+of+Prolog+task+due+in+course+git+repository+by+end+of+day+on+7+Mar+2019?focusedCommentId=37391344#comment-37391344

% These were notes I wrote before doing the implementation and so have
% drifted a bit from the actual testing code, however, the nfa term
% still has three parts:
%
%    * The first part however, is not a State, but the term start(State)
%    where State is filled in with the 'name' of the start state.  This
%    structure is used by my test_nfa_match predicate to find the start
%    of the automata that is being matched against.
%
%    * The States list maps nicely to the book definition of an NFA.
%    However, my testing code never checks directly to see what you put
%    in there.  Keeping a list of state(Name,Status) values there would
%    work fine, but it is over-specification in the sense that you
%    could store other structures there that could also work fine.
%
%    * The main thing is that somewhere there has to be the information
%    that allows your accepting predicate to tell if a given state is
%    an accepting state or not.  And in phase 2 (and 3), for the
%    accepting states, you also need to know what token type they are
%    accepting.
%
%    * The transitions() structure matters and is used by
%    test_nfa_match_helper to explore paths thru the nfa.
%
%    * As to the structure of a state name, all it has to be is something
%    that = works with.  In an instance of an nfa, I would expect it to
%    be grounded, i.e., having no free variables.


>>>>>>> 890dac2977d24ee70b9228433af9fbfae45a881c
%     a next term has the form next(From, To, Category)
%       where From is a state term in States
%             To is a state term in States
%             Category is a character category or the term epsilon
%               the categories will be 
%                   letter
%                   digit
%                   white_space
%                   question_mark
%                   exclamation_mark
%                   period
%                   comma
%                   colon
%                   semicolon
%                   minus_sign
%                   plus_operator
%                   binary_operators  for  * / % ^
%                   left_parenthesis
%                   right_parenthesis
%                   equal
%                   less_than
%                   greater_than
%                   undefined
%  the regular expression operators will be:
%    concat for concatenation as a binary infix operator
%    plus for one or more copies of its parameter as a postfix operator
%    star for zero or more copies of its parameter as a postfix operator
%    opertional for zero or one copies of its parameter as a postfix operator
%    or for from one or the other as a binary infix operator
%    (they are suffixed with underscore to avoid conflicts with existing operators)

:- op(300, yfx, 'concat').
:- op(500, yfx, 'or').
:- op(400, yf, 'plus').
:- op(400, yf, 'star').
:- op(400, yf, 'optional').

test_categorize([], []).
test_categorize([H_in|T_in], [H_result| T_result]) :- test_category(H_in, H_result), test_categorize(T_in, T_result).

test_category(X,Y) :- test_category_helper(X,Y).
test_category(X,undefined) :- \+ test_category_helper(X,_).


test_category_helper(Char, letter) :- [ACode] = "a", ACode @=< Char, [ZCode] = "z", Char @=< ZCode.
test_category_helper(Char, letter) :- [ACode] = "A", ACode @=< Char, [ZCode] = "Z", Char @=< ZCode.
test_category_helper(Char, digit) :- [ZeroCode] = "0", ZeroCode @=< Char, [NineCode] = "9", Char @=< NineCode.
test_category_helper(Char, white_space) :- [Char] = " ".
test_category_helper(Char, white_space) :- [Char] = "\n".
test_category_helper(Char, question_mark) :- [Char] = "?".
test_category_helper(Char, exclamation_mark) :- [Char] = "!".
test_category_helper(Char, period) :- [Char] = ".".
test_category_helper(Char, comma) :- [Char] = ",".
test_category_helper(Char, colon) :- [Char] = ":".
test_category_helper(Char, semicolon) :- [Char] = ";".
test_category_helper(Char, minus_sign) :- [Char] = "-".
test_category_helper(Char, plus_operator) :- [Char] = "+".
test_category_helper(Char, binary_operators) :- [Char] = "*".
test_category_helper(Char, binary_operators) :- [Char] = "/".
test_category_helper(Char, binary_operators) :- [Char] = "%".
test_category_helper(Char, binary_operators) :- [Char] = "^".
test_category_helper(Char, left_parenthesis) :- [Char] = "(".
test_category_helper(Char, right_parenthesis) :- [Char] = ")".
test_category_helper(Char, equal) :- [Char] = "=".
test_category_helper(Char, less_than) :- [Char] = "<".
test_category_helper(Char, greater_than) :- [Char] = ">".

test_count_successful_tests(N) :- setof(A, test_example_run_tests(A), L), length(L,N).

test_example_run_tests(Status) :-
                  test_case(InputString, RegularExpression, my_succeed), 
                  Result = my_succeed,
                  regular_expression_to_nfa(RegularExpression, NFA), 
                  test_categorize(InputString, TransformedString), 
                  test_nfa_match(TransformedString, NFA),
                  Status = [InputString, RegularExpression, Result].

test_example_run_tests(Status) :- 
                  test_case(InputString, RegularExpression, my_fail), 
                  Result = my_fail,
                  regular_expression_to_nfa(RegularExpression, NFA), 
                  test_categorize(InputString, TransformedString), 
                  \+ test_nfa_match(TransformedString, NFA),
                  Status = [InputString, RegularExpression, Result].

test_debug_run_tests(Status) :-
                  test_case(InputString, RegularExpression, my_succeed), 
                  Result = my_succeed,
                  regular_expression_to_nfa(RegularExpression, NFA), 
                  test_categorize(InputString, TransformedString), 
                  test_nfa_match(TransformedString, NFA),
                  Status = [InputString, RegularExpression, TransformedString, NFA, Result].

test_debug_run_tests(Status) :- 
                  test_case(InputString, RegularExpression, my_fail), 
                  Result = my_fail,
                  regular_expression_to_nfa(RegularExpression, NFA), 
                  test_categorize(InputString, TransformedString), 
                  \+ test_nfa_match(TransformedString, NFA),
                  Status = [InputString, RegularExpression, TransformedString, NFA, Result].

test_nfa_match(String, nfa(start(State),X,Y)) :- test_nfa_match_helper(String, nfa(start(State),X,Y), State).

<<<<<<< HEAD
=======
test_nfa_match(String, nfa(start(State),X,Y), Matches) :- 
     setof(Match, test_nfa_match_helper(String, nfa(start(State),X,Y), State, Match), ActualMatches),
     sort(Matches, SortedMatches),
     ActualMatches = SortedMatches.

test_nfa_match(String, nfa(start(State),X,Y), []) :- 
     \+ setof(Match, test_nfa_match_helper(String, nfa(start(State),X,Y), State, Match), _).

>>>>>>> 890dac2977d24ee70b9228433af9fbfae45a881c
test_nfa_match_helper("", NFA, State) :- epsilon_closure(State, NFA, Closure), 
     member(PossibleFinish, Closure),
     accepting(NFA, PossibleFinish).

<<<<<<< HEAD
test_nfa_match_helper([H|T], nfa(X,Y,  transitions(Transitions)), State) :- 
     member(next(State, NextState, H), Transitions),
     test_nfa_match_helper(T, nfa(X,Y, transitions(Transitions)), NextState).

test_nfa_match_helper(String, nfa(X,Y,transitions(Transitions)), State) :- 
=======
test_nfa_match_helper([H|T], nfa(X,Y,transitions(Transitions)), State) :- 
     epsilon_closure(State, nfa(X,Y,transitions(Transitions)), Closure),
     member(NextState, Closure),     
     NextState \= State,
     member(next(State, NextState, epsilon), Transitions),
     test_nfa_match_helper_closed([H|T], nfa(X,Y,transitions(Transitions)), NextState).

test_nfa_match_helper([H|T], nfa(X,Y,transitions(Transitions)), State) :- 
     test_nfa_match_helper_closed([H|T], nfa(X,Y,transitions(Transitions)), State).


test_nfa_match_helper("", NFA, State, Match) :- epsilon_closure(State, NFA, Closure), 
     member(PossibleFinish, Closure),
     accepting(NFA, PossibleFinish, Match).

test_nfa_match_helper([H|T], nfa(X,Y,transitions(Transitions)), State, Match) :- 
>>>>>>> 890dac2977d24ee70b9228433af9fbfae45a881c
     epsilon_closure(State, nfa(X,Y,transitions(Transitions)), Closure),
     member(NextState, Closure),     
     NextState \= State,
     member(next(State, NextState, epsilon), Transitions),
<<<<<<< HEAD
     test_nfa_match_helper(String, nfa(X,Y,transitions(Transitions)), NextState).

test_case("a",letter concat (letter star), my_succeed).

test_case("a",letter concat letter star, my_fail).

% test_case("a",(letter concat letter) star, my_fail).
% identical to  previous test case after operator processing and so doesn't
% show up as distinct in count of tests passed.

=======
     test_nfa_match_helper_closed([H|T], nfa(X,Y,transitions(Transitions)), NextState, Match).

test_nfa_match_helper([H|T], nfa(X,Y,transitions(Transitions)), State, Match) :- 
     test_nfa_match_helper_closed([H|T], nfa(X,Y,transitions(Transitions)), State, Match).

test_nfa_match_helper_closed([H|T], nfa(X,Y,  transitions(Transitions)), State, Match) :- 
     member(next(State, NextState, H), Transitions),
     test_nfa_match_helper(T, nfa(X,Y, transitions(Transitions)), NextState, Match).

test_nfa_match_helper_closed([H|T], nfa(X,Y,  transitions(Transitions)), State) :- 
     member(next(State, NextState, H), Transitions),
     test_nfa_match_helper(T, nfa(X,Y, transitions(Transitions)), NextState).

test_dfa_match(String, nfa(start(State),X,Y), Matches) :- 
     length(Matches, 1),
     setof(Match, test_dfa_match_helper(String, nfa(start(State),X,Y), State, Match), ActualMatches),
     sort(Matches, SortedMatches),
     ActualMatches = SortedMatches.

test_dfa_match(String, nfa(start(State),X,Y), []) :- 
     \+ setof(Match, test_dfa_match_helper(String, nfa(start(State),X,Y), State, Match), _).

test_dfa_match_helper("", NFA, State, Match) :- 
     accepting(NFA, State, Match).

test_dfa_match_helper([H|T], nfa(X,Y,  transitions(Transitions)), State, Match) :- 
     setof(NextState, member(next(State, NextState, H), Transitions), [NS]),
     test_dfa_match_helper(T, nfa(X,Y, transitions(Transitions)), NS, Match).


test_case("a",letter concat (letter star), my_succeed).

test_case("a",letter, my_succeed).

test_case("a",letter concat letter star, my_fail).

test_case("00a0",((letter) star) plus, my_fail).

% test_case("a",(letter concat letter) star, my_fail).
% identical to  previous test case after operator processing and so does not
% show up as distinct in count of tests passed.

test_count_successful_tests(Phase, Tests, N) :- setof(A, test_example_run_tests(Phase, Tests, A), L), length(L,N).

test_example_run_tests(Phase, Tests, Status) :-
                  member(TestCase, Tests),
                  test_case(Phase, TestCase, InputString, RegularExpression, Result), 
                  test_categorize(InputString, TransformedString), 
                  test_run_case(Phase, Result, TransformedString, RegularExpression, _),
                  Status = [InputString, RegularExpression, Result].


test_example_run_tests(Phase, all, Status) :-
                  test_case(Phase, _, InputString, RegularExpression, Result), 
                  test_categorize(InputString, TransformedString), 
                  test_run_case(Phase, Result, TransformedString, RegularExpression, _),
                  Status = [InputString, RegularExpression, Result].

test_run_case(phase1, my_succeed, TransformedString, RegularExpression, FA) :- 
                  regular_expression_to_nfa(RegularExpression, FA), 
                  test_nfa_match(TransformedString, FA).

test_run_case(phase1, my_fail, TransformedString, RegularExpression, FA) :- 
                  regular_expression_to_nfa(RegularExpression, FA), 
                  \+ test_nfa_match(TransformedString, FA).

test_run_case(phase2, [H|T], TransformedString, ScannerExpression, FA) :- 
                  scanner_to_nfa(ScannerExpression, FA), 
                  test_nfa_match(TransformedString, FA, [H|T]).

test_run_case(phase2, [], TransformedString, ScannerExpression, FA) :- 
                  scanner_to_nfa(ScannerExpression, FA), 
                  test_nfa_match(TransformedString, FA, []).

test_run_case(phase3, [H|T], TransformedString, ScannerExpression, DFA) :- 
                  scanner_to_nfa(ScannerExpression, NFA), 
                  scanner_nfa_to_dfa(NFA, DFA), 
                  test_dfa_match(TransformedString, DFA, [H|T]).

test_run_case(phase3, [], TransformedString, ScannerExpression, DFA) :- 
                  scanner_to_nfa(ScannerExpression, NFA), 
                  scanner_nfa_to_dfa(NFA, DFA), 
                  test_dfa_match(TransformedString, DFA, []).


test_debug_run_tests(Phase, Tests, Status) :-
                  member(TestCase, Tests),
                  test_case(Phase, TestCase, InputString, RegularExpression, Result), 
                  test_categorize(InputString, TransformedString), 
                  test_run_case(Phase, Result, TransformedString, RegularExpression, FA),
                  Status = [InputString, RegularExpression, TransformedString, FA, Result].


test_debug_run_tests(Phase, all, Status) :-
                  test_case(Phase, _, InputString, RegularExpression, Result), 
                  test_categorize(InputString, TransformedString), 
                  test_run_case(Phase, Result, TransformedString, RegularExpression, FA),
                  Status = [InputString, RegularExpression, TransformedString, FA, Result].

test_case(phase1, case00a0, "00a0",((letter) star) plus, my_fail).

test_case(phase1, case00, "a", letter, my_succeed).

test_case(phase1, case01, "a", letter concat (letter star), my_succeed).

test_case(phase1, case02, "a", letter concat letter star, my_fail).

test_case(phase2, case03, "a", [scanner(identifier, letter concat (letter star))], [identifier]).

test_case(phase2, case04, "a", [scanner(identifier, letter concat (letter star)),
                               scanner(number, digit concat (digit star))], [identifier]).

test_case(phase2, case04b, "2", [scanner(identifier, letter concat (letter star)),
                               scanner(number, digit concat (digit star))], [number]).

test_case(phase2, case05, ":", [scanner(identifier, letter concat (letter star)),
                               scanner(number, digit concat (digit star))], []).
% empty list of tokens indicates there should be no match.

test_case(phase2, case06, "aa", [scanner(identifier, letter plus),
                                 scanner(evenid, (letter concat letter) plus)],
                                [identifier, evenid]).


>>>>>>> 890dac2977d24ee70b9228433af9fbfae45a881c
