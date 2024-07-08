//
//  SendImage.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/8/24.

import SwiftUI
import PhotosUI
import Vision
import CoreML
import CoreImage

struct SendImage: View {
    
    @State var selectedItem: PhotosPickerItem?
    
    @State var biteData: Data?
    @State var detectedRect: CGRect?
    @State  var image: UIImage?

    var body: some View {
        NavigationView(content: {
            VStack(content: {
                PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                    .onChange(of: selectedItem, {
                        Task{
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                                image = UIImage(data: data)
                                
                            }
                            
                        }
                    })
                
                Spacer()
                
                if let image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
             
                }
                
                Spacer()
                Button("Send", action: {
                   let sendimage = SendImageViewModel()
                    sendimage.uploadImage(image: image!, to: "http://127.0.0.1:8000/upload")
                              })
                .padding()
          
            })
            
        })
    }
}

#Preview {
    SendImage()
}
