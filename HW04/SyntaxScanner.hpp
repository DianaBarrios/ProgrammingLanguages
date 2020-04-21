//
//  SyntaxScanner.hpp
//  HW04
//
//  Created by Arturo Arenas on 9/5/19.
//  Copyright © 2019 Arturo Arenas. All rights reserved.
//

#ifndef SyntaxScanner_hpp
#define SyntaxScanner_hpp

#include <stdio.h>
#include <iostream>
#include <vector>
#include <string>

using namespace std;

class SyntaxScanner {
    
public:
    
    SyntaxScanner();
    void parse(vector<pair<string, string>>& tokens) throw (string);
    
private:
    
    const string SYNTAX_ERROR = "SYNTAX ERROR";

    void validate(vector<pair<string, string>>& tokens, int cur) throw (string);
    void match(string str, string target, int& cur) throw (string);
    void parseF(vector<pair<string, string>>& tokens, int& cur) throw (string);
    void parseE(vector<pair<string, string>>& tokens, int& cur) throw (string);
};

#endif /* SyntaxScanner_hpp */
