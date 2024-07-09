//
//  SelectImageViewButton.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

extension AlbumImageSelectPage {
    
    var usePhotoButton: some View {

        NavigationLink(destination: PredictResultView(resultText: resultpred)) {
            Text("Send")
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .simultaneousGesture(TapGesture().onEnded {
            //loadModel.isLoad = false
             getmodeldata()
            if resultpred == ""{
                isActive = true
            }else{
                isActive = false
            }
     
            
        })
        .disabled(checkImage != "")
         
            //        .onTapGesture{
            //            print("누르")
            //            getmodeldata()
            //        }
        }
    
    
    
    var retakeButton: some View {
        Button {
            recentPhotoData = nil
            showCamera = true
            VM.retakePhoto()
            checkImage = ""
        } label: {
            Text("취소")
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
        
    }
    
    func getmodeldata(){
        print("아오")
     let getmodel = GetModelFunc()
     getmodel.detectObjects(in:UIImage(data: imageData!)!){
         response in
         
         if response{
             let box = getmodel.results.first
             let x = box!.boundingBox.origin.x
             let y = box!.boundingBox.origin.y
             let width = box!.boundingBox.width
             let height = box!.boundingBox.height
                                
             print("BoundingBox - x: \(String(describing: x)), y: \(String(describing: y)), width: \(String(describing: width)), height: \(String(describing: height))")
             print("이미지 사이즈",UIImage(data:imageData!)!.size)
             let imageSize = (UIImage(data:imageData!)!.size)
             print(imageSize)
             
             let actualX = x * imageSize.width
             let actualY = y * imageSize.height
             let actualWidth = width * imageSize.width
             let actualHeight = height * imageSize.height
             
             print("BoundingBox - x: \(actualX), y: \(actualY), width: \(actualWidth), height: \(actualHeight)")
             let sendData = [actualX,actualY,actualWidth,actualHeight]
             print(sendData)
             let sendmod = SendImageViewModel()
             sendmod.uploadImage(image: UIImage(data:imageData!)!, to: "http://192.168.10.138:8000/upload",x: actualX,y: actualY, w: actualWidth, h: actualHeight) {
                 resultString in
                 
                 if let resultS = resultString{
                   resultpred = resultS
                   
                     
                   
                 } else{
                     return
                 }
             }
            
         }
     
     }
        
   }

}



#Preview {
    AlbumImageSelectPage(showCamera: .constant(true), imageData: .constant(nil), checkImage: .constant(""))
}

