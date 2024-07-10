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
    
    @State var ret: String = ""
    
    //@State var showResult: Bool = false
    @State var isActive: Bool = false
    //@StateObject var loadModel = ImageClassificationViewModel()
    @EnvironmentObject var loadModel: ImageClassificationViewModel
    
    @State var VM = CameraViewModel()
    
    
    @Binding var showCamera: Bool
    @Binding var imageData: Data?

    
    @State var showPhotoPicker = false
    @State var recentPhotoData: Data?
    
    @Binding var checkImage: String
    
    @State var showMessage: Bool = false
    
    @State var resultpred: String = ""
    
    @State var GoToBack: Bool = true
    
    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90
    
    
    var isLandscape: Bool { vertiSizeClass == .compact }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color(.black)
                    .ignoresSafeArea()
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
                    showMessageWithTimer()
                    if let imageData = imageData {
                        print("앨범 이미지 데이터: \(imageData)")
                        
                    } else {
                        print("앨범 이미지가 없습니다.")
                    }
                   
                    
                }
                .toolbar(.hidden, for: .tabBar)
                
                //상단 고기/낫고기 텍스트 알림
                if showMessage && checkImage != ""{
                    
                    Text(checkImage)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(width: 350,height: 40)
                        .position(x: 190 , y: 50)
                        //.opacity(showMessage ? 1 : 0)
                }

                if  loadModel.isLoad && GoToBack{
                    CustomProgressView()
                }
                if isActive && GoToBack{
                    CustomProgressView()
                }
            }
            
        }
        
    }
    func showMessageWithTimer()  {
        print("ad",loadModel.isLoad)
        showMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          
                showMessage = false
            
        }
    }
}


struct AlbumImageSelectPage_Previews: PreviewProvider {
    static var previews: some View {
        AlbumImageSelectPage(showCamera: .constant(true), imageData: .constant(nil), checkImage: .constant(""))
    }
}
