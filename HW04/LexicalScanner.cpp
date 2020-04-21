//
//  LexicalScanner.cpp
//  HW04
//
//  Created by Arturo Arenas on 9/4/19.
//  Copyright © 2019 Arturo Arenas. All rights reserved.
//

#include "LexicalScanner.hpp"

using namespace std;
    
LexicalScanner::LexicalScanner() = default;
    
vector<pair<string, string>> LexicalScanner::scan(string& s) throw (string){
    int curState = 0;
    vector<pair<string, string>> tokens;
    string curToken = "";
    
    int curChar = 0;
    while(curChar <= (int)s.size()){
        int charIdx = getCharIdx(s[curChar]);
        if(charIdx == ERROR){
            throw LEXICAL_ERROR;
        }
        curState = transition[curState][charIdx];
        if(isFinal(curState)){
            tokens.push_back(make_pair(curToken, typeInterpreter(TokenNum(curState))));
            curToken = "";
            curState = 0;
            curChar--;
        }
        else if(curState == ERROR){
            throw LEXICAL_ERROR;
        }
        else {
            if(curState) curToken.push_back(s[curChar]);
        }
        curChar++;
    }
    
    return tokens;
}
    
int LexicalScanner::getCharIdx(char c){
    if(c == ' ') return 0;
    else if(c == '$') return 1;
    else if((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) return 2;
    else if(c >= '0' && c <= '9') return 3;
    else if(c == '/' || c == '*' || c == '+' || c == '-') return 4;
    else if(c == '(' || c == ')') return 5;
    else if(c == NULL) return 6;
    else return ERROR;
}
    
bool LexicalScanner::isFinal(int state){
    return (state == 3 || state == 5 || state == 6 || state == 7);
}

string LexicalScanner::typeInterpreter(TokenNum t){
    string ans;
    switch(t){
        case VARIABLE:
            ans = "variable";
            break;
        case NUMBER:
            ans = "number";
            break;
        case PARENTHESIS:
            ans = "parenthesis";
            break;
        case OPERATOR:
            ans = "operator";
            break;
    }
    return ans;
}
