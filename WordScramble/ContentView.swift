//
//  ContentView.swift
//  WordScramble
//
//  Created by Dennis Mutwiri Mugambi on 05/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State
    private var usedWords = [String]()
    
    @State
    private var rootWord = ""
    
    @State
    private var newWord = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord() {
        
        //lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        //extra validation to come
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        
        //find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            //load contents of start.txt into string
            if let startWords = try? String(contentsOf: startWordsURL) {
                //split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                //pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkWorm"
                
                //if we are here everythiing has worked, so we can exit
                return
            }
        }
        
        //if we are here then there was a problem -trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
