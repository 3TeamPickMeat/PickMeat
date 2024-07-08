//
//  SelectImageViewVertiControlBar.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

extension AlbumImageSelectPage {
    @ViewBuilder var verticalControlBar: some View {
            verticalControlBarPostPhoto

        
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
//    AlbumImageSelectPage(showCamera: .constant(true))
//}
