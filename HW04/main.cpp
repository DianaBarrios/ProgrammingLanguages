// Arturo Arenas Esparza - A00820982
// Diana Marcela Barrios - A00819792

#include <iostream>
#include <vector>
#include <string>
#include "LexicalScanner.hpp"
#include "SyntaxScanner.hpp"

using namespace std;

int main(){
    string s;
    getline(cin, s);
    vector<pair<string, string>> tokens;
    
    LexicalScanner lexicalAnalysis = LexicalScanner();
    SyntaxScanner syntacticalAnalysis = SyntaxScanner();
    try {
        tokens = lexicalAnalysis.scan(s);
        syntacticalAnalysis.parse(tokens);
        cout << "Your expression is correct! You're a functional programmer\n";
    }
    catch(string err){
        cout << err << endl;
    }
    
    return 0;
}
