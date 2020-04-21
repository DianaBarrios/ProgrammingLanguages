//
//  LexicalScanner.hpp
//  HW04
//
//  Created by Arturo Arenas on 9/4/19.
//  Copyright © 2019 Arturo Arenas. All rights reserved.
//

#ifndef LexicalScanner_hpp
#define LexicalScanner_hpp

#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>

using namespace std;

enum TokenNum {
    VARIABLE = 3,
    NUMBER = 5,
    PARENTHESIS = 6,
    OPERATOR = 7
};

class LexicalScanner {
    
public:
    
    LexicalScanner();
    vector<pair<string, string>> scan(string& s) throw (string);
    
private:
    const int ERROR = 100;
    const string LEXICAL_ERROR = "LEXICAL ERROR";
    const int transition[10][7] = {
        {0, 1, ERROR, 4, 9, 8, 0},
        {ERROR, ERROR, 2, ERROR, ERROR, ERROR, ERROR},
        {3, 3, 2, 2, 3, 3, 3},
        {3, 3, 3, 3, 3, 3, 3},
        {5, 5, 5, 4, 5, 5, 5},
        {5, 5, 5, 5, 5, 5, 5},
        {6, 6, 6, 6, 6, 6, 6},
        {7, 7, 7, 7, 7, 7, 7},
        {6, 6, 6, 6, 6, 6, 6},
        {7, 7, 7, 7, 7, 7, 7}
    };
    
    int getCharIdx(char c);
    bool isFinal(int state);
    string typeInterpreter(TokenNum t);
    
};

#endif /* LexicalScanner_hpp */
