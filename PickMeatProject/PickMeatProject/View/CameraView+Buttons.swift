//
//  CameraView+Buttons.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//


import SwiftUI

extension CameraView {
    
    var usePhotoButton: some View {
        Button {
            imageData = recentPhotoData
            showCamera = false
        } label: {
            Text("Send")
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    var retakeButton: some View {
        Button {
            recentPhotoData = nil
            showCamera = true
            VM.retakePhoto()
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

//#Preview {
//    CameraView(showCamera: .constant(true))
//}

