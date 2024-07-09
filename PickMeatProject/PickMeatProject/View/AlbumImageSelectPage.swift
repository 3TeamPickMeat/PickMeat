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
    
    //@StateObject var loadModel = ImageClassificationViewModel()
    @EnvironmentObject var loadModel: ImageClassificationViewModel
    
    @State var VM = CameraViewModel()
    
    
    @Binding var showCamera: Bool
    @Binding var imageData: Data?

    
    @State var showPhotoPicker = false
    @State var recentPhotoData: Data?
    
    @Binding var checkImage: String
    
    @State var showMessage: Bool = false
    
    //@ var showProgress: Bool // 로딩 상태 변수 추가
    
    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90
    
    
    var isLandscape: Bool { vertiSizeClass == .compact }
    
    var body: some View {
        ZStack{
            
            Color(.black)
                .ignoresSafeArea()
            //Spacer()
            VStack {
               
           
                            
                
                Spacer()
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 300, height:  550)
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
                showMessageWithTimer()
                
            }
            .toolbar(.hidden, for: .tabBar)
            if showMessage{
                Text(checkImage)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    //.transition(.opacity)
                    .frame(width: 350,height: 40)
                    .position(x: 190 , y: 50)
            }
               
                        
            if  loadModel.isLoad{
       
                 CustomProgressView()
             }
        }
        
     
        
    }
    
    func showMessageWithTimer()  {
        print("ad",loadModel.isLoad)
         showMessage = true
         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             withAnimation {
                 print(checkImage)
                 showMessage = false
             }
         }
     }

}


struct AlbumImageSelectPage_Previews: PreviewProvider {
    static var previews: some View {
        AlbumImageSelectPage(showCamera: .constant(true), imageData: .constant(nil), checkImage: .constant(""))
    }
}
