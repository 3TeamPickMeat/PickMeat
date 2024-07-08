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
        NavigationView {
            VStack {
                if showCamera {
                    CameraView(imageData: $imageData, showCamera: $showCamera)
                } else {
                    AlbumImageSelectPage(showCamera: $showCamera, imageData: $imageData)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
