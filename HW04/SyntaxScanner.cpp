//
//  SyntaxScanner.cpp
//  HW04
//
//  Created by Arturo Arenas on 9/5/19.
//  Copyright © 2019 Arturo Arenas. All rights reserved.
//

#include "SyntaxScanner.hpp"

using namespace std;

SyntaxScanner::SyntaxScanner() = default;

void SyntaxScanner::validate(vector<pair<string, string>>& tokens, int cur) throw (string) {
    if(cur >= (int)tokens.size()){
        throw SYNTAX_ERROR;
    }
}

void SyntaxScanner::match(string str, string target, int& cur) throw (string) {
    if(str == target){
        cur++;
    }
    else{
        throw SYNTAX_ERROR;
    }
}

void SyntaxScanner::parseF(vector<pair<string, string>>& tokens, int& cur) throw (string) {
    try{
        validate(tokens, cur);
        match(tokens[cur].second, "operator", cur);
    }
    catch (string err){
        throw err;
    }
}

void SyntaxScanner::parseE(vector<pair<string, string>>& tokens, int& cur) throw (string) {
    try{
        validate(tokens, cur);
        if(tokens[cur].first == "("){
            match(tokens[cur].first, "(", cur);
            parseF(tokens, cur);
            parseE(tokens, cur);
            parseE(tokens, cur);
            validate(tokens, cur);
            match(tokens[cur].first, ")", cur);
        }
        else if(tokens[cur].second == "number"){
            match(tokens[cur].second, "number", cur);
        }
        else{
            match(tokens[cur].second, "variable", cur);
        }
    }
    catch (string err) {
        throw err;
    }
}

void SyntaxScanner::parse(vector<pair<string, string>>& tokens) throw (string) {
    int cur = 0;
    try{
        validate(tokens, cur);
        match(tokens[cur].first, "(", cur);
        parseF(tokens, cur);
        parseE(tokens, cur);
        parseE(tokens, cur);
        validate(tokens, cur);
        match(tokens[cur].first, ")", cur);
        if(cur < (int)tokens.size()){
            throw SYNTAX_ERROR;
        }
    }
    catch (string err) {
        throw err;
    }
}
