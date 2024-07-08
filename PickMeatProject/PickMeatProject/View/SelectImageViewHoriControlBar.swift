//
//  SelectImageViewHoriControlBar.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

extension AlbumImageSelectPage {
    @ViewBuilder var horizontalControlBar: some View {
            horizontalControlBarPostPhoto
    }
    
    var horizontalControlBarPostPhoto: some View {
        HStack {
            retakeButton
                .frame(width: controlButtonWidth)
            Spacer()
            
            usePhotoButton
                .frame(width: controlButtonWidth)
        }
    }
}

//#Preview {
//    AlbumImageSelectPage(showCamera: .constant(true))
//}
