//
//  ContentView.swift
//  PickMeatProject
//
//  Created by 박정민 on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageData: Data? = nil
    @State var showCamera: Bool = false
    var body: some View {
        VStack {
            CameraView(imageData: $imageData, showCamera: $showCamera)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
