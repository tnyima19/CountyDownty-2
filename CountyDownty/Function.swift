//
//  Function.swift
//  CountyDownty
//
//  Created by Tenzing Nyima on 5/13/22.
//

import Foundation
func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
  DispatchQueue.main.asyncAfter(
    deadline: .now() + seconds,
    execute: run)
}
