% phase 1
regular_expression_to_nfa(RegularExpression, NFA) :-
    regular_expression_to_nfa_helper(RegularExpression, Start, End, States, Transitions, 1, _),
    to_nfa(Start, End, States, Transitions, accepting, NFA).

to_nfa(Start, End, States, Transitions, Token, NFA) :-
    NFA = nfa(start(NFA_Start),NFA_States, transitions(NFA_Transitions)),
    ((Start == End,!,NFA_Start = state(End,Token));
      NFA_Start = state(Start,not_accepting)),
    to_nfa_states(States, End, Token, NFA_States),
    to_nfa_transitions(Transitions,End, Token, NFA_Transitions). 

to_nfa_states(States, End, Token, NFA_States):-
    (
        States = [] ->
            NFA_States = []
        ; States =[States_Head|States_Tail] -> 
            (
                States_Head = End ->
                    NFA_States_Head = state(States_Head,Token),
                    to_nfa_states(States_Tail, End, Token, NFA_States_Tail),
                    NFA_States = [NFA_States_Head|NFA_States_Tail]
                ;true ->
                    NFA_States_Head = state(States_Head,not_accepting),
                    to_nfa_states(States_Tail, End, Token, NFA_States_Tail),
                    NFA_States = [NFA_States_Head|NFA_States_Tail]
            )  
    ).

update_end_state(End, Token, Transition, NFA_Transition):-
    Transition = (From, To, P),
    NFA_Transition = next(state(From,From_Token), state(To,To_Token),P),
   
    ((End == From,!,From_Token = Token);From_Token = not_accepting),
    ((End == To  ,!,To_Token = Token)  ;To_Token = not_accepting).

to_nfa_transitions(Transitions,End, Token, NFA_Transitions):-
    (
        Transitions = [] ->
            NFA_Transitions = []
        ; Transitions =[Transitions_Head|Transitions_Tail] -> 
            (
                update_end_state(End, Token, Transitions_Head, NFA_Transitions_Head),
                to_nfa_transitions(Transitions_Tail,End, Token, NFA_Transitions_Tail),
                NFA_Transitions = [NFA_Transitions_Head|NFA_Transitions_Tail]
            )  
    ).

regular_expression_to_nfa_helper(RegularExpression, Start, End, States, Transitions, Label, LastLabel) :-
    (
        RegularExpression = concat(RegularExpression_1,RegularExpression_2) -> 
            regular_expression_to_nfa_helper(RegularExpression_1, Start_1, End_1, States_1, Transitions_1, Label, LastLabel_1),
            regular_expression_to_nfa_helper(RegularExpression_2, Start_2, End_2, States_2, Transitions_2, LastLabel_1, LastLabel_2),
            update_translate(to, End_1, Start_2, Transitions_1, Transitions_1_New),
            delete(States_1, End_1, States_1_Rest),
            Start = Start_1,
            End = End_2,
            append(States_1_Rest, States_2, States),
            append(Transitions_1_New, Transitions_2, Transitions),
            LastLabel = LastLabel_2
        ;RegularExpression = or(RegularExpression_1,RegularExpression_2) -> 
            regular_expression_to_nfa_helper(RegularExpression_1, Start_1, End_1, States_1, Transitions_1, Label, LastLabel_1),
            regular_expression_to_nfa_helper(RegularExpression_2, Start_2, End_2, States_2, Transitions_2, LastLabel_1, LastLabel_2),
            Start = LastLabel_2,
            End is LastLabel_2 + 1,
            append([Start,End|States_1], States_2, States),
            Add_Trans_1 = (Start, Start_1, epsilon),
            Add_Trans_2 = (Start, Start_2, epsilon),
            Add_Trans_3 = (End_1, End, epsilon),
            Add_Trans_4 = (End_2, End, epsilon),
            append(Transitions_1, Transitions_2, Transitions_Rest),
            Transitions = [Add_Trans_1, Add_Trans_2, Add_Trans_3,Add_Trans_4|Transitions_Rest],
            LastLabel is LastLabel_2 + 2
        ;RegularExpression = star(RegularExpression_1) ->
            regular_expression_to_nfa_helper(RegularExpression_1, Start_1, End_1, States_1, Transitions_1, Label, LastLabel_1),
            Start = LastLabel_1,
            End is LastLabel_1 + 1,
            append([Start,End|States_1], [], States),
            Add_Trans_1 = (Start, End, epsilon),
            Add_Trans_2 = (Start, Start_1, epsilon),
            Add_Trans_3 = (End_1, Start_1, epsilon),
            Add_Trans_4 = (End_1, End, epsilon),
            Transitions = [Add_Trans_1, Add_Trans_2, Add_Trans_3,Add_Trans_4|Transitions_1],
            LastLabel is LastLabel_1 + 2
        ;RegularExpression = plus(RegularExpression_1) ->
            regular_expression_to_nfa_helper(concat(RegularExpression_1,star(RegularExpression_1)), Start, End, States, Transitions, Label, LastLabel)
        ;RegularExpression = optional(RegularExpression_1) ->
            regular_expression_to_nfa_helper(or(RegularExpression_1,epsilon), Start, End, States, Transitions, Label, LastLabel)
        ;RegularExpression = X ->
            Start = Label,
            End is Label + 1,
            States = [Start, End],
            Transitions = [(Start, End, X)],
            LastLabel is Label + 2
    ).

update_translate(Type, X, Y, Transitions, Transitions_New):-
    (
         Transitions = [] ->
            Transitions_New = []
        ;Transitions = [Transitions_Head|Transitions_Tail] -> 
            Transitions_Head = (From_Head,To_Head,Token_Head),
            (
                 Type = from -> 
                    (
                        From_Head = X ->
                            update_translate(Type, X, Y, Transitions_Tail, Transitions_New_Tail),
                            Transitions_New = [(Y,To_Head,Token_Head)|Transitions_New_Tail]
                        ; true ->
                            update_translate(Type, X, Y, Transitions_Tail, Transitions_New_Tail),
                            Transitions_New = [Transitions_Head|Transitions_New_Tail]
                    )
                ;Type = to -> 
                (
                    To_Head = X ->
                        update_translate(Type, X, Y, Transitions_Tail, Transitions_New_Tail),
                        Transitions_New = [(From_Head,Y,Token_Head)|Transitions_New_Tail]
                    ; true ->
                        update_translate(Type, X, Y, Transitions_Tail, Transitions_New_Tail),
                        Transitions_New = [Transitions_Head|Transitions_New_Tail]
                )
                ;Type = token -> 
                (
                    Token_Head = X ->
                        update_translate(Type, X, Y, Transitions_Tail, Transitions_New_Tail),
                        Transitions_New = [(From_Head,To_Head,Y)|Transitions_New_Tail]
                    ; true ->
                        update_translate(Type, X, Y, Transitions_Tail, Transitions_New_Tail),
                        Transitions_New = [Transitions_Head|Transitions_New_Tail]
                )
            )
    ).

%epsilon_closure
epsilon_closure(State, NFA, Closure) :-
    NFA = nfa(_, States, transitions(Transitions)),
    member(State, States),
    epsilon_closure_helper(States, Transitions, [State], [State], Closure).

epsilon_closure_helper(States, Transitions, OpenList, CloseList, Closure) :-
(
    OpenList = [] ->
        Closure = CloseList
    ; OpenList = [H|T] ->
        (setof(X, (member(X, States),
                  \+member(X, CloseList), 
                  \+member(X, T),
                  member(next(H, X, epsilon), Transitions)), Q) ->
            (append(Q, CloseList, QAll),
             append(Q, T, QT),
             epsilon_closure_helper(States, Transitions, QT, QAll, Closure))
            ; epsilon_closure_helper(States, Transitions, T, CloseList, Closure))
).

% accepting
accepting(NFA, State) :-
    NFA = nfa(_,States,_),
    member(state(Name,S), States),
    S \= not_accepting,
    State = state(Name,S).


% phase 2
scanner_to_nfa(Scanner, nfa(start(state(0, not_accepting)), States, transitions(Tran))):-
    scanner_to_nfa_helper(Scanner, All_NFA, 1),
    get_all_nfa_start(All_NFA, Starts),
    get_all_nfa_states(All_NFA, All_States),
    get_all_nfa_tran(All_NFA, All_Tran),
    States = [state(0, not_accepting)|All_States],
    get_epsilon_tran(Starts, Epsilon_Tran),
    append(Epsilon_Tran, All_Tran,Tran).

scanner_to_nfa_helper(Scanner, All_NFA, Label):-
    (
        Scanner = [] ->
            All_NFA = []
        ;Scanner = [H|T] ->
            H = scanner(Token, RE),
            regular_expression_to_nfa_helper(RE, Start, End, States, Transitions, Label, LastLabel),
            to_nfa(Start, End, States, Transitions, Token, NFA),
            scanner_to_nfa_helper(T, All_NFA_Rest, LastLabel),
            All_NFA = [NFA|All_NFA_Rest]
    ).

get_all_nfa_start(All_NFA, Starts):-
    (
        All_NFA = [] -> 
            Starts = []
        ;All_NFA = [H|T] ->
            H = nfa(start(Start),_,_),  
            get_all_nfa_start(T, Starts_Rest),
            append([Start],Starts_Rest,Starts)
    ).

get_all_nfa_states(All_NFA, All_States):-
    (
        All_NFA = [] -> 
            All_States = []
        ;All_NFA = [H|T] ->
            H = nfa(_,States,_),  
            get_all_nfa_states(T, States_Rest),
            append(States,States_Rest,All_States)
    ).

get_all_nfa_tran(All_NFA, All_Tran):-
    (
        All_NFA = [] -> 
            All_Tran = []
        ;All_NFA = [H|T] ->
            H = nfa(_,_,(transitions(Tran))),  
            get_all_nfa_tran(T, Tran_Rest),
            append(Tran,Tran_Rest,All_Tran)
    ).

get_epsilon_tran(Starts, Epsilon_Tran):-
    (
        Starts = []    ->
            Epsilon_Tran = [] 
        ;Starts = [H|T] ->
            get_epsilon_tran(T,Epsilon_Tran_Rest),
            Epsilon_Tran = [next(state(0, not_accepting),H,epsilon)|Epsilon_Tran_Rest]
    ).

accepting(NFA, State, S) :-
    NFA = nfa(_,States,_),
    member(state(Name,S), States),
    S \= not_accepting,
    State = state(Name,S).
    
