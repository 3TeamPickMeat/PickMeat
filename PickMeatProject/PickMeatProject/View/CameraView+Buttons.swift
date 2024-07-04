//
//  CameraView+Buttons.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//


import SwiftUI

extension CameraView {
    
    var usePhotoButton: some View {
        ControlButtonView(label: "Send") {
            imageData = VM.photoData
            showCamera = false
        }
    }
    
    var retakeButton: some View {
        ControlButtonView(label: "다시찍기") {
            VM.retakePhoto()
        }
    }
    
    
    
    var AlbumButton: some View {
        Button {
            showPhotoPicker = true
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 0/255, green: 178/255, blue: 255/255), lineWidth: 5)
                .frame(width: 75, height: 75)
                .padding()
        }
    }
    
    var photoCaptureButton: some View {
        Button {
            VM.takePhoto()
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

#Preview {
    CameraView(imageData: .constant(nil), showCamera: .constant(true))
}

