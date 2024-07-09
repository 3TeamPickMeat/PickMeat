//
//  PhotoTopython.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/4/24.
//

import SwiftUI
import PhotosUI
import Vision
import CoreML
import CoreImage

struct PhotoTopython: View {
    
    @State var selectedItem: PhotosPickerItem?
    
    @State var biteData: Data?
    @State var detectedRect: CGRect?
    @State private var image: UIImage? = nil
    @StateObject private var ModelAct = GetModelFunc()
    
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
                        .overlay(
                            Rectangle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: detectedRect?.width ?? 0, height: detectedRect?.height ?? 0)
                                .position(x: detectedRect?.midX ?? 0, y: detectedRect?.midY ?? 0)
                        )
                }
                
                Spacer()
                Button("예측하기", action: {
                    
                    if let image = image {
                        ModelAct.detectObjects(in: image){
                            response in
                        }
                                 }
                  
                        
                })
                ForEach(ModelAct.results, id: \.self) { result in
                           let boundingBox = result.boundingBox
                           let x = boundingBox.origin.x
                           let y = boundingBox.origin.y
                           let width = boundingBox.width
                           let height = boundingBox.height

                           Text("BoundingBox - x: \(x), y: \(y), width: \(width), height: \(height)")
                               .padding()
                       }
            })
            
        })
        
    }
    
    //    private func GetModel(){
    //    let model = try? MeatDetecting()
    //    let input =
    //    }
    
}


#Preview {
    PhotoTopython()
}
