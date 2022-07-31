//
//  CountyDowntyViewController.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 4/27/22.
//

import UIKit


protocol CountyDowntyViewControllerDelegate{
    func didFinishResult(_ controller: CountyDowntyViewController, newItem: PlayerData, playerItem: PlayerItem)

}

class CountyDowntyViewController: UITableViewController {
    @IBOutlet weak var anagram: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playerInput: UITextField!
    var dictionaryAPI = DictionaryAPI()
    //let resultViewIdentifier = "resultView"
    var delegate: CountyDowntyViewControllerDelegate?
    var item = PlayerData()
    var player = PlayerItem() //--------------------------->here
    var countyDowntyItem = CountyDowntyItem()
    var recordTime: Double = 0.0
    var secondsPassed: Double = 0
    var totalSeconds: Double = 60
    var timer = Timer()
   
    var question = ""
    
    
    
    //var answer = countyDowntyItem.questions[self().curr + 1]
    
    
    static func currentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return "\(hour):\(minutes)"
    }
    
    static func currentDay() -> String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return "\(month)/\(day)/\((year))"
    }
    
    static func today() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return day
        
    }
    
    
    func checkAnswer(playerAnswer:String, allAnswer:[String]) -> Bool{
        for j in allAnswer {
            if j == playerAnswer {
                return true
            }
        }
        return false
    }
    
    func getAnswer(playerAnswer:String, allAnswer:[String]) -> String{
        for j in allAnswer {
            if j == playerAnswer {
                return j
            }
        }
        return ""
    }
    

    
    func checkForAnagram(playerInput: String, anagram: String) -> Bool {
        var firstString = anagram
        var secondString = playerInput
        for i in secondString {
            print(firstString)
            if firstString.contains(i) {
                if let j = firstString.firstIndex(of: i) {
                    firstString.remove(at:j)
                    print(firstString)
                }
        
            } else {
                return false
            }
        }
        return true
        
    }


    @IBAction func checkButton(){
       //var goToDictionary = false
        let tryAgain = "TRY AGAIN"
        let emptyString = ""
        let searching = "SEARCHING"
        
            if let input = playerInput.text  {
                if secondsPassed >= 59 {
                    return
                }
                question = anagram.text!
                
                if checkForAnagram(playerInput: input, anagram: anagram.text!) == true {
                    
                    
                    guard let mainView = navigationController?.view
                      else { return }
                    let hudView = HudView.hud(inView: mainView, animated: true)
                    hudView.text = searching
                    afterDelay(0.3) {
                      hudView.hide()
                        self.dictionaryAPI.getDefinition(word: input)
                        
                    }
                    
                }else {
                playerInput.text = emptyString
                playerInput.placeholder = tryAgain
                
            }
        } 
        
    }
   

    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        timer.invalidate()
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        update()
        }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playerInput.becomeFirstResponder()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "resultSeuge"{
            let controller  = segue.destination as! ResultViewController
            controller.player = player
       
    }
    
    @objc func updateTimer(){
        let resultViewIdentifier = "resultView"
        
        if secondsPassed < totalSeconds{
            print("\(secondsPassed) seconds.")
            progressBar.progress = Float(secondsPassed)/Float(totalSeconds)
            secondsPassed += 0.25
                    }
        else{
            // change title label
            timer.invalidate()
            //titleEggs.text = "DONE!"
            progressBar.progress = 1.0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: resultViewIdentifier) as! ResultViewController
            vc.modalPresentationStyle = .fullScreen
            vc.player = player
            present(vc, animated: true)
        }
    }

    
    
    // method to pop up the key board
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerInput.becomeFirstResponder()
    }
    
    func update(){
        tableView.allowsSelection = false
        
        dictionaryAPI.delegate = self
        anagram.text = countyDowntyItem.getAnagram()
        timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    //MARK: - Table view Delegates - disables pressing the table View ------------------------------> USeful for project
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
        return nil
    }
    
}



extension CountyDowntyViewController: DictionaryAPIDelegate {
    
    func didUpdateAnswers(_ anagramApi: DictionaryAPI, playerItem: PlayerItem) {
        let resultViewIdentifier = "resultView"
        let fullTime = 60.0
        DispatchQueue.main.async {
            self.timer.invalidate()
            let result = true
            //let playerPlayedOnce = true
            print("seconsd passed is here")
            print(self.secondsPassed)
            let time = String(format: "%.2f", self.secondsPassed)
            let date = String(CountyDowntyViewController.currentDay())
            let pointsString = String(playerItem.points)
            self.secondsPassed = fullTime
            //let def = anagramAnswer.definition
            playerItem.result = result
            playerItem.time = time
            playerItem.date = date
            playerItem.pointsString = pointsString
            self.playerInput.isEnabled = false
            self.delegate?.didFinishResult(self, newItem: self.item, playerItem: playerItem)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: resultViewIdentifier) as! ResultViewController
            vc.modalPresentationStyle = .fullScreen
            vc.player = playerItem
            self.present(vc, animated: true)
            
        }
    }
    
    func didFailWithError(error: Error) {
        //self.showAlert()
        print(error)
        
    }
    
    
}

