//
//  SelectImageViewButton.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

extension AlbumImageSelectPage {
    
    var usePhotoButton: some View {
        Button {
            
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
            Text("취소")
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
    
    
    
    
    
}

//#Preview {
//    AlbumImageSelectPage(showCamera: .constant(true))
//}

