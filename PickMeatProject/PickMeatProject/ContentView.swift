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
    @State var checkImage: String = ""
    @State var showProgress: Bool = true

    var body: some View {
            TabView {

                if showCamera {
                    CameraView(imageData: $imageData, showCamera: $showCamera, checkImage: $checkImage)
                        .tabItem {
                                            Label("카메라", systemImage: "camera")
                                        }
                } else {
                    AlbumImageSelectPage(showCamera: $showCamera, imageData: $imageData, checkImage: $checkImage )
                        .tabItem {
                                            Label("카메라", systemImage: "camera")
                                        }
                }
                
            
            TipView()
                          .tabItem {
                              Label("팁", systemImage: "lightbulb")
                          }
                
                      ResultDetailView()
                          .tabItem {
                              Label("검사결과", systemImage: "doc.plaintext.fill")
                          }
                  }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
