//
//  CameraView+Buttons.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

extension CameraView {
    
    var usePhotoButton: some View {
        NavigationLink(destination: PredictResultView(resultText: predResult)) {
            Text("Send")
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .simultaneousGesture(TapGesture().onEnded {
            loadModel.isLoad = true
            pregresState = true
            print("1", checkImage)
            print("카메라 send")
            showCamera = true
            
            pregresState = false
            
            // 딥러닝 모델 2개 거치기
            if let data = VM.photoData, let _ = UIImage(data: data) {
                print("아오")
                let getmodel = GetModelFunc()
                getmodel.detectObjects(in: UIImage(data: data)!) { response in
                    if response {
                        let box = getmodel.results.first
                        let x = box!.boundingBox.origin.x
                        let y = box!.boundingBox.origin.y
                        let width = box!.boundingBox.width
                        let height = box!.boundingBox.height
                        
                        print("BoundingBox - x: \(String(describing: x)), y: \(String(describing: y)), width: \(String(describing: width)), height: \(String(describing: height))")
                        //print("이미지 사이즈", UIImage(data: imageData!)!.size)
                        let imageSize = UIImage(data: data)!.size
                        print(imageSize)
                        
                        let actualX = x * imageSize.width
                        let actualY = y * imageSize.height
                        let actualWidth = width * imageSize.width
                        let actualHeight = height * imageSize.height
                        
                        print("BoundingBox - x: \(actualX), y: \(actualY), width: \(actualWidth), height: \(actualHeight)")
                        let sendData = [actualX, actualY, actualWidth, actualHeight]
                        print(sendData)
                        let sendmod = SendImageViewModel()
                        sendmod.uploadImage(image: UIImage(data: data)!, to: "http://192.168.10.138:8000/upload", x: actualX, y: actualY, w: actualWidth, h: actualHeight) { resultString in
                            if let resultS = resultString {
                                predResult = resultS
                                pregresState = false
                                let redevimodel = ResultDetailViewModel()
                                let dbresult = redevimodel.insertDB(meatImage: UIImage(data:imageData!)!, date: "", meatFresh: resultS)
                                if dbresult{
                                    print("인서트 성공")
                                }else{
                                    print("인서트 실패")
                                }
                            } else {
                                return
                            }
                        }
                    }
                }
            }
        })
        .disabled(checkImage != "")
    }
    
    var retakeButton: some View {
        Button {
            recentPhotoData = nil
            showCamera = true
            VM.retakePhoto()
            checkImage = ""
        } label: {
            Text("다시찍기")
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    var AlbumButton: some View {
        Button {
            showPhotoPicker = true
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 0/255, green: 178/255, blue: 255/255), lineWidth: 5)
                .frame(width: 65, height: 65)
                .padding()
        }
    }
    
    var photoCaptureButton: some View {
        Button {
            VM.takePhoto()
            // ------- 카메라 찍었을 때 펑션 ------
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("2초 딜레이")
                let data = VM.photoData
                let image = UIImage(data: data!)
                selectImage = image
                loadModel.classifyImage(image!) { response in
                    if response {
                        loadModel.isLoad = false
                        if loadModel.classificationLabel != "meat" {
                            checkImage = "고기가 아닌거같아요 다시 찍어주세요."
                            showMessage = true
                            print("2", checkImage)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                print("3", checkImage)
                                showMessage = false
                            }
                        }
                    }
                }
            }
        } label: {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 65)
                Circle()
                    .stroke(Color(red: 0/255, green: 178/255, blue: 255/255), lineWidth: 5)
                    .frame(width: 75)
            }
        }
    }
    
    var changeCamera: some View {
        Button {
            VM.switchCamera()
        } label: {
            ZStack {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(red: 0/255, green: 178/255, blue: 255/255))
                    .padding(10)
            }
            .frame(width: 50, height: 50)
            .cornerRadius(10)
        }
    }
}
