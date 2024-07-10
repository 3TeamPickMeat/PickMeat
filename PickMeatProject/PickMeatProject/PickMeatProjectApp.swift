//
//  PickMeatProjectApp.swift
//  PickMeatProject
//
//  Created by 박정민 on 6/27/24.
//

import SwiftUI

@main
struct PickMeatProjectApp: App {
    @StateObject  var loadModel = ImageClassificationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loadModel)
        }
    }
}
