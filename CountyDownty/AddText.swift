//
//  AddText.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 5/13/22.
//

import Foundation
extension String {
  mutating func add(
    text: String?,
    separatedBy separator: String
  ) {
    if let text = text {
      if !isEmpty {
        self += separator
      }
      self += text
    }
  }
}
