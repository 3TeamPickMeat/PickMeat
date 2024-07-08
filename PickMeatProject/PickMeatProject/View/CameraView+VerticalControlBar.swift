//
//  CameraView+VerticalControlBar.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

extension CameraView {
    @ViewBuilder var verticalControlBar: some View {
        if VM.hasPhoto {
            verticalControlBarPostPhoto
                .toolbar(.hidden, for: .tabBar)
        } else {
            verticalControlBarPrePhoto
        }
    }
    
    var verticalControlBarPrePhoto: some View {
        VStack {
            changeCamera
                .frame(height: controlButtonWidth)
            photoCaptureButton
                .frame(height: controlButtonWidth)
            AlbumButton
                .frame(height: controlButtonWidth)
        }
        .padding(.vertical, -15)
    }
    
    var verticalControlBarPostPhoto: some View {
        VStack {
            usePhotoButton
                .frame(height: controlButtonWidth)
            Spacer()
            retakeButton
                .frame(height: controlButtonWidth)
        }
    }
}


//#Preview {
//    CameraView(showCamera: .constant(true))
//}

