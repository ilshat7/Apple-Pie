//
//  Game.swift
//  Apple Pie
//
//  Created by Ильшат Мухамедьянов on 27.10.2020.
//

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    fileprivate var guessedLetters = [Character]()
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var gessedWord: String {
        var wordToShow = String()
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())){
                wordToShow += String(letter)
            } else {
                wordToShow += "_"
            }
        }
        return wordToShow
    }
    
    mutating func playerGuessed(letter: Character) {
        let lowercasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowercasedLetter)
        if !word.lowercased().contains(lowercasedLetter){
            incorrectMovesRemaining -= 1
        }
    }
}
