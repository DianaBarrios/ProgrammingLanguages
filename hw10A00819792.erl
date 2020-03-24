-module(hw10A00819792).
-export([sumFirst/1, nestedSum/1, removeNestedLists/1, cleanString/1, evaluate/2, toBinaryString/1, zip/2, tuplesToList/1]).

%Diana Marcela Barrios Macias
%A00819792

% Complete the following functions and submit your file to Canvas.

% ========= IMPORTANT ==========
% Change the name of the file so that it contains your student ID or name.
% Do not change the names of the functions. The system will specifically look for the names used in this file. Changing the name of a function will automatically make you lose the points for that function.
% Do not change the number of arguments in the functions. Changing the number of arguments of a function will automatically make you lose the points for that function.
% Make sure that nothing additional is printed as the result of running this file. Avoid printing names, student IDs, or any other messages. If you print anything else, the system will wrongly grade your solutions.
% If your file cannot be loaded by the Erlang compiler, your grade will be zero. Then, submit only code that works.


% Sum of first n positive integers
sumFirst(X) -> X * (X+1) / 2 .

% Calculates the sum of the elements in a list (ignores nested lists).
nestedSum([]) -> 0 ;
nestedSum([X|Y]) -> if 
    is_list(X) -> hd(X) + nestedSum(tl(X)) + nestedSum(Y);
    true -> X + nestedSum(Y) 
    end.

% Removes nested lists in the argument and returns all the elements as one single plain list.
removeNestedLists([]) -> [];
removeNestedLists([X|Y]) -> if
    is_list(X) -> removeNestedLists(X) ++ removeNestedLists(Y);
    true -> [X] ++ removeNestedLists(Y)
    end.

% Cleans a string. Given a string, return recursively a 'cleaned' string where adjacent chars that are the same have been reduced to a single char. So "yyzzza" yields "yza".
cleanString([]) -> "";
cleanString([X]) -> [X];
cleanString([X|Y]) -> if
    X == hd(Y) -> cleanString(Y);
    true -> [X] ++ cleanString(Y)
    end. 

% Evaluation of polynomials
evaluate([], _) -> 0;
evaluate([Y|YS],X) -> Y*math:pow(X,length(YS)) + evaluate(YS,X) .

% Converts a number to a binary string.
toBinaryString(0) -> "0";
toBinaryString(1) -> "1";
toBinaryString(X) -> if
    X rem 2 == 0 -> toBinaryString(X div 2) ++ "0";
    true -> toBinaryString(X div 2) ++ "1"
    end.

% Zipping two lists
zip([], _) -> [];
zip(_,[]) -> [];
zip([X|XS],[Y|YS]) -> [{X,Y}] ++ zip(XS,YS) .

% Lists of tuples
tuplesToList([]) -> [];
tuplesToList([{F,S}|XS]) -> [F | tuplesToList(XS)] ++ [S] .