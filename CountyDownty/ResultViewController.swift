//
//  ResultViewController.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 4/27/22.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

class ResultViewController: UITableViewController{
    @IBOutlet weak var resultWords: UILabel!
    @IBOutlet weak var resultTime: UILabel!
    @IBOutlet weak var definitionHistory: UILabel!
    //var delegate: ResultViewControllerDelegate?    //var dictionaryAPI = DictionaryAPI()
    var player = PlayerItem()
    var countyDownty = CountyDowntyViewController()
    var audioPlayer: AVAudioPlayer?
    
    
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    
    func updateDefinition(def: String) {
        definitionHistory.text = def
    }
    
    @IBAction func doneButton() {
        
        guard let mainView = self.view
          else {
            print("I am not animation")
            return }
        let hudView = HudView.hud(inView: mainView, animated: true)
        hudView.text = "Good Luck"
        afterDelay(0.6) {
          hudView.hide()
            print("I am here")
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    func animation(){
        guard let mainView = navigationController?.parent?.view
        else {return }
        let hudView = HudView.hud(inView: mainView, animated: true)
        hudView.text = "Tagged"
    }
    
    override func viewDidLoad() {
        //countyDowntyViewController(didFinishEditing: item)
        super.viewDidLoad()
        tableView.allowsSelection = false
        //countyDownty.delegate = self
        
        update()
    }
    
    func playSound(soundName: String, soundType: String) {
        guard let url = Bundle.main.url(forResource: soundName , withExtension: soundType)
        else {
            return

        }
        do {
            print("I am at play Sound")
            audioPlayer = try! AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            audioPlayer?.play() // this is where sound _would_ play


            // CITE THIS SOURCE
            // source of code : https://www.youtube.com/watch?v=1htq-c4kVdA

        }
    }
    


    
    
    func update(){
        //let playerAnswer = player.answer
        let correct = player.result
        let time = player.time
        let definition = player.definition
        let points = player.points
        let pointsName = "Points ="
        let timeName = "Time:"
        let greatResult = "Congraulations"
        var goodResult = "Good"
        let poorResult = "LOSER"
        let mediumResult = "BE BETTER"
        var line1 = ""
        var line2 = ""
        let secondsName = "sec"
        let cheers = "CrowdCheers"
        let homer = "homer_snicker"
        
        if correct == true {
            //self.resultWords.text = "CONGRATULATIONS"
            //self.resultTime.text = String(format: "%.2f", item.time)
            if points >= 8 {
                resultWords.text = greatResult
                line1.add(text: pointsName, separatedBy: "")
                line1.add(text: player.pointsString, separatedBy: " ")
                
                pointsLabel.text = line1
                playSound(soundName: cheers, soundType: "mp3")
                
            } else if points >= 5 {
                resultWords.text = goodResult
                line1.add(text: pointsName, separatedBy: "")
                line1.add(text: player.pointsString, separatedBy: " ")
                pointsLabel.text = line1
                
               playSound(soundName: cheers, soundType: "mp3")
                
                //playSoundEffect()
            } else  if points == 0 {
                resultWords.text = poorResult
                line1.add(text: pointsName, separatedBy: "")
                line1.add(text: player.pointsString, separatedBy: " ")
                pointsLabel.text = line1
                //pointsLabel.text = line1
                playSound(soundName: homer , soundType: "mp3")
                //playSoundEffect()
            } else {
                resultWords.text = mediumResult
                line1.add(text: pointsName, separatedBy: "")
                line1.add(text: player.pointsString, separatedBy: " ")
                pointsLabel.text = line1
               playSound(soundName:  homer, soundType: "mp3")
                //playSoundEffect()
            }
            line2.add(text: timeName, separatedBy: " ")
            line2.add(text: time, separatedBy: " ")
            line2.add(text: secondsName, separatedBy: " ")
            resultTime.text = line2
            //resultTime.text  = "Time: " + String(format: "%.2f", time) //--------------------->
            definitionHistory.text = definition
            animation()
            
            
        } else {
            resultWords.text = "FAILURE"
            resultTime.text = " Too late "
            definitionHistory.text = " No Definition found"
            pointsLabel.text = "0"
        }
        
    }
    

   
    
    
}

