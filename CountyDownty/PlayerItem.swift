//
//  PlayerItem.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 4/27/22.
//

import Foundation


class PlayerItem: NSObject, Codable{
    //let anagram = "SLAPTCRIS"
    var name = "player"
    var result = false
    var answer = ""
    var recordTime = 0.0
    var definition = ""
    var points = 0
    var pointsString = ""
    //var playerInput = ""
    //var time: Double = 0.0
    var playedOnce = false
    var date  = ""
    var time = ""
    var word = ""
    //var curr = 0
    
    override init(){
        self.name = "player"
        self.pointsString = "0"
        self.result = false
        self.answer = ""
        self.recordTime = 0
        self.definition = ""
        self.playedOnce = false
        self.date = ""
        self.time = ""
        points = 0
        word = ""
    }
    
    
    init(name: String, result: Bool, answer: String, recordTime: Double,definition: String, playedOnce: Bool, date:String, time:String, points: Int , word: String ){
        self.name = name 
        self.result = result
        self.answer = answer
        self.recordTime = recordTime
        self.definition = definition
        self.playedOnce = playedOnce
        self.points = points 
        //today = 0
        self.date = date
        self.time = time
        self.word = word
        //curr = 0
    }
    init(definition: String, points: Int , word: String){
        self.points = points
        self.definition = definition
        self.word = word
    }
    
    // userdefaults stores basic infomration for certain keys,
    // make sure dont force unrap,
    // make sure use if let {
    
}
