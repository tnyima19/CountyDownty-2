//
//  AnagramAPI.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 5/6/22.
//

import UIKit


protocol DictionaryAPIDelegate {
    func didUpdateAnswers(_ dictionaryApi: DictionaryAPI, playerItem: PlayerItem)
    func didFailWithError(error: Error)
    
}


// parts of the code were used from
// https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16253670#overview
// getDefinition(word: String) and performRequest(with urlString: String)

class DictionaryAPI{
    //var anagramURL = "https://anagramica.com/all/:"
    var dictionaryURL = "https://wordsapiv1.p.rapidapi.com/words/"
    // transfer the word from View controller to this dictionaryAPI
    var apiKeys = "/definitions?rapidapi-key=8a5a87122cmsh66d66ef4e7ebca9p1f5475jsncd784bb40190"
    var found = true
    var delegate: DictionaryAPIDelegate?
    
    func getDefinition(word: String){
        let urlString = "\(dictionaryURL)\(word)\(apiKeys)"
        //print(urlString)
        performRequest(with: urlString, inputWord: word)

    }

    func performRequest(with urlString: String, inputWord: String){
        // Create URL
         if let url = URL(string: urlString) {
             //print("I am serching net")
             // step 2. create URL session
             let session = URLSession(configuration: .default)// thing that can perform the networking
                // 3 give the session a task
             let task = session.dataTask(with: url) {(data, response, error) in
                 if error != nil{
                     self.delegate?.didFailWithError(error: error!)
                     return

                 }
                 if let safeData = data {
                     
                     if let playerAnswer = self.parseJSON(dictionaryData: safeData, inputWord: inputWord){
                         print("I am at safe data")
                         //self.found = true
                         self.delegate?.didUpdateAnswers(self, playerItem: playerAnswer )
                         //return true
                     }

                 }
             }
             task.resume()// because task is created in suspended state

             // task takes teh data from the internet.

        }
        
        //return false
    
}
    func parseJSON(dictionaryData: Data, inputWord: String) -> PlayerItem? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(DictionaryData.self, from:dictionaryData)
            print("Search apple")
            let anagram = decodedData.word
            print(anagram)
            
            if decodedData.definitions!.count > 0  {
            
                //definition = decodedData.definitions[0].definition
                if let definition = decodedData.definitions![0].definition{
                print(definition)
                var points: Int
                if inputWord.count == 9 {
                    points = 18
                } else {
                    points = inputWord.count
                }
                let playerModelOne = PlayerItem(definition: definition, points: points, word: inputWord)
            //let anagramArray = decodedData.all
            //print(anagramArray[0])
            
            //let countyDowntyModel = CountyDowntyModel(answer: anagramArray)
                return playerModelOne
            }
            }
            
            
        }catch {
            print(error)
            return nil
        }
        
    return nil 
    }
}

