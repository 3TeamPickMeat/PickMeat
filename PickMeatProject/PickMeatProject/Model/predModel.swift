//
//  predModel.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/4/24.
//

import Foundation
import SwiftUI

struct Pred{
    var id: Int
    var image: UIImage
    var date: Date
    
    init(id: Int, image: UIImage, date: Date) {
        self.id = id
        self.image = image
        self.date = date
    }
}

extension Pred: Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
