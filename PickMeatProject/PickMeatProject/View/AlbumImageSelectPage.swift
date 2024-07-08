//
//  AlbumImageSelectPage.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AlbumImageSelectPage: View {
    @Environment(\.verticalSizeClass) var vertiSizeClass
    
    
    @State var VM = CameraViewModel()
    
    
    @Binding var showCamera: Bool
    @Binding var imageData: Data?

    
    @State var showPhotoPicker = false
    @State var recentPhotoData: Data?
    
    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90
    
    
    var isLandscape: Bool { vertiSizeClass == .compact }
    
    
    var body: some View {
        ZStack{
            Color(red: 197/255, green: 227/255, blue: 255/255)
                .ignoresSafeArea()
            VStack {
                Spacer()
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Text("이미지를 불러올 수 없습니다.")
                }
                Spacer()
                    HStack {
                        if isLandscape {
                            verticalControlBar
                                .frame(width: controlFrameHeight)
                        }
                    }
                    if !isLandscape {
                        horizontalControlBar
                            .frame(height: controlFrameHeight)
                    }
            }
            .onAppear {
                if let imageData = imageData {
                    print("앨범 이미지 데이터: \(imageData)")
                } else {
                    print("앨범 이미지가 없습니다.")
                }
            }

        }
    }
}

struct AlbumImageSelectPage_Previews: PreviewProvider {
    static var previews: some View {
        AlbumImageSelectPage(showCamera: .constant(true), imageData: .constant(nil))
    }
}
