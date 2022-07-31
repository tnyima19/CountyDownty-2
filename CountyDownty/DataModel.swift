//
//  DataModel.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 5/12/22.
//

import Foundation
class DataModel {
    var scoreList = [PlayerItem]()
    
    var indexOfSelectedList: Int {
        get{
            return UserDefaults.standard.integer(forKey: "ListIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ListIndex")
        }
    }
    
    init(){
       loadHistorylistItems()
        sortLists()
        registerDefaults()
        handleFirstTime()
    }
    func registerDefaults() {
      let dictionary = [ "ListIndex": -1,
                         "FirstTime": true
                        ] as [String: Any]
      UserDefaults.standard.register(defaults: dictionary)
    }

    
    func handleFirstTime() {
      let userDefaults = UserDefaults.standard
      let firstTime = userDefaults.bool(forKey: "FirstTime")

      if firstTime {
        let listItem = PlayerItem()
        scoreList.append(listItem)

        indexOfSelectedList = 0
        userDefaults.set(false, forKey: "FirstTime")
      }
    }
    
    func sortLists() {
      scoreList.sort { scoreList1, scoreList2 in
        return scoreList1.pointsString.localizedStandardCompare(scoreList2.pointsString) == .orderedDescending
      }
    }
    
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("PlayerData.plist")
    }

    
    func saveHistorylistItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(scoreList)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
            
        }
    }
    
    // MARK: LOAD
    func loadHistorylistItems(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do {
                scoreList = try decoder.decode([PlayerItem].self, from: data)
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
}
