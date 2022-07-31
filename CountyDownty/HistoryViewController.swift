//
//  HistoryViewController.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 4/27/22.
//

//import Foundation
import UIKit

class HistoryViewController: UITableViewController, UINavigationControllerDelegate {

    @IBAction func newGame(){
            performSegue(withIdentifier: "gameSegue", sender: self)
        
    }
  
    
    var allWords = [PlayerItem]()
    var dataModel = DataModel()
    var countyDownty = CountyDowntyViewController()
    var result = ResultViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        countyDownty.timer.invalidate()
        //dataModel.loadHistorylistItems()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        countyDownty.delegate = self
        tableView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let resultView = "resultView"
      super.viewDidAppear(animated)

      navigationController?.delegate = self

        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedList
        if index >= 0 && index < dataModel.scoreList.count {
            let list = dataModel.scoreList[index]
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: resultView) as! ResultViewController
            controller.modalPresentationStyle = .fullScreen
            controller.player = list
        }
        tableView.reloadData()
    }

   
    
    // MARK: - Table View Data Source
    override func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        return dataModel.scoreList.count
    }
    
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
        let resultView = "resultView"
        //UserDefaults.standard.set(indexPath.row, forKey: "ListIndex")
      dataModel.indexOfSelectedList = indexPath.row
      let playerItem = dataModel.scoreList[indexPath.row]
      //performSegue(withIdentifier: "resultView", sender: playerItem)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: resultView) as! ResultViewController
        controller.modalPresentationStyle = .fullScreen
        controller.player = playerItem
        self.present(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    
    func configureText(//------------------------------------> useful
        for cell: UITableViewCell,
        with item: PlayerItem
    ) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.answer
        let label2 = cell.viewWithTag(1000) as! UILabel
        label2.text = item.date
        let label3 = cell.viewWithTag(1002) as! UILabel
        label3.text = item.pointsString
        
    }
    override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnagramList", for: indexPath)
        let aWord = dataModel.scoreList[indexPath.row]
        
        let label1 = cell.viewWithTag(1000) as! UILabel
        let label2 = cell.viewWithTag(1001) as! UILabel
        let label3 = cell.viewWithTag(1002) as! UILabel
        
        label1.text = aWord.date
        label2.text = aWord.word
        label3.text = aWord.pointsString
        
        
      return cell
    }
//    func sortChecklists() {
//      allWords.sort { allWords1, allWords2 in
//        return allWords1.points.localizedStandardCompare(allWords2.points) == .orderedDescending
//      }
//    }
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! CountyDowntyViewController
        //vc.newWord = self.item
        vc.delegate = self
    }
    

    // MARK: - Navigation Controller Delegates
    func navigationController(
      _ navigationController: UINavigationController,
      willShow viewController: UIViewController,
      animated: Bool
    ) {
      // Was the back button tapped?
      if viewController === self {
          dataModel.indexOfSelectedList = -1
      }
    }


}




extension HistoryViewController: CountyDowntyViewControllerDelegate {
    func didFinishResult(_ controller: CountyDowntyViewController, newItem: PlayerData, playerItem: PlayerItem) {
        let newRowIndex = dataModel.scoreList.count
        //allWords.append(newItem)
        //allWords.append(newItem)
        print(newItem.word)
        print(newItem.time)
        //update()
        dataModel.scoreList.append(playerItem)
        
        if playerItem.playedOnce == false {
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        if let cell = tableView.cellForRow(at: indexPath) {
            configureText(for: cell, with: playerItem)
        }
       
        dataModel.saveHistorylistItems()
        dataModel.sortLists()
        
        }
        
    }
    
    
    
    
    
}
