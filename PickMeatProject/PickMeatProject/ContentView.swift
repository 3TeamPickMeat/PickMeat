//
//  ContentView.swift
//  PickMeatProject
//
//  Created by 박정민 on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showCamera = true
    @State private var imageData: Data?

    var body: some View {
        TabView {
            if showCamera {
                CameraView(imageData: $imageData, showCamera: $showCamera)
                    .tabItem {
                        Label("Camera", systemImage: "camera")
                    }
            } else {
                AlbumImageSelectPage(showCamera: $showCamera, imageData: $imageData)
            }
            TipView()
                .tabItem {
                    Label("Tip", systemImage: "lightbulb")
                }
            SplashView()
                .tabItem {
                    Label("Splash", systemImage: "sparkles")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
