//
//  AnagramData.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 5/6/22.
//

import Foundation

struct DictionaryData: Decodable {
    var word: String
    var definitions: [Definitions]?
}


struct Definitions: Decodable{
    var definition: String?
}
