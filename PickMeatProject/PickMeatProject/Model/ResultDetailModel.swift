//
//  ResultDetailModel.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/8/24.
//

import SwiftUI

struct ResultDetailModel{
    var id: Int
    var meatImage: UIImage
    var date: String
    var meatFresh: String
    
    init(id: Int, meatImage: UIImage, date: String, meatFresh: String) {
        self.id = id
        self.meatImage = meatImage
        self.date = date
        self.meatFresh = meatFresh
    }
    
}


extension ResultDetailModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
