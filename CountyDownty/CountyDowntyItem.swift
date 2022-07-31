//
//  CountyDowntyItem.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 4/27/22.
//


import Foundation

class CountyDowntyItem: NSObject{
    //let anagram = "RealOn"
    //var result = false
    //let answer = "LOANER"
    //var playerInput = ""
    //var time: Double = 0.0
    //let questions = ["RealOn", "LOANER", "StockFal", "LOCKFAST", "FireSona", "FARINOSE"]
    let consonant = ["B","C","D","F","G","H","J", "K","L", "M","N","P", "Q","R","S","T","V","W","X","Y","Z"]
    let vowel = ["A","E","I","O","U"]
    let minVowel = 3
    let minConsonant = 4
    //var countVowel = 0
    //var countConsonant = 0
    var maxLetters = 9
    var minLetters = 8
    //var anagram = ""
    //var anagramApi = AnagramAPI()
    //var answers: [String]
    
//    func getTotalVowelsConsonants() {
//        //var countVowel: Int
//        //var countConsonant: Int
//
//
//        print(countVowel)
//        print(countConsonant)
//
//    }
//    init (newAnswers:[String]){
//
//        answers = newAnswers
//        super.init()
//    }
    
    
    func getAnagram() -> String {
        var anagram = ""
        var countVowel = 0
        var countConsonant = 0
        var vowels = vowel
        
         repeat {
            countVowel = Int.random(in: minVowel...maxLetters)
            countConsonant = Int.random(in: minConsonant...maxLetters)
             print(countVowel + countConsonant)
        } while  countVowel+countConsonant != maxLetters
        
        //getTotalVowelsConsonants()
        // now get the anagram
        let maxConsonant = 20
        for i in 1...countConsonant {
            var consonantArrayNum = Int.random(in: 0...maxConsonant)
            anagram = anagram + consonant[consonantArrayNum]
            
        }
            //var vowelArrayNum = Int.random(in: 0...4)
        var maxVowel = 4
        for j in 1...countVowel {
            var vowelArrayNum = Int.random(in: 0...maxVowel)
            anagram = anagram + vowels[vowelArrayNum]
            var index = (vowels.firstIndex(of: vowels[vowelArrayNum]) ?? nil)!
            vowels.remove(at: index)
            maxVowel = maxVowel - 1
                
        }
        
        
        return anagram
        
    }
    

    
}

