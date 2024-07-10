//
//  CameraView.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI
import PhotosUI

struct CameraView: View {
    @Environment(\.verticalSizeClass) var vertiSizeClass
    
    
    @EnvironmentObject var loadModel: ImageClassificationViewModel
    
    @State var showMessage: Bool = false
    
    @State var VM = CameraViewModel()
    @Binding var imageData: Data?
    @Binding var showCamera: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var selectImage: UIImage?
    
    @State var showPhotoPicker = false  // 포토픽커 뷰 상태표시
    @State var recentPhotoData: Data?
    
    @State var showHelpOverlay = true  // 도움말 오버레이 상태 변수 추가
    
    @State var pregresState: Bool = false
    
    @State var predResult: String = "" // 머신러닝 결과값
    
    @Binding var checkImage: String

    //@State var PhotoselectImage: UIImage? // 카메라 이미지 상태 추가
       
    
    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90
    
    var isLandscape: Bool { vertiSizeClass == .compact }
    
    var body: some View {
        NavigationStack{
            ZStack {
                
                
                Color(.black)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        cameraPreview
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
                //MARK: 오버레이 체크
                //            if showHelpOverlay {
                //                helpOverlay
                //                    .transition(.opacity)
                //                    .onTapGesture {
                //                        withAnimation {
                //                            showHelpOverlay = false
                //                        }
                //                    }
                //            }
                // 메세지
                if showMessage && checkImage != ""{
                    Text(checkImage)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(width: 350,height: 40)
                        .position(x: 190 , y: 50)
                }
                
                // 프로그래스
                if  loadModel.isLoad && pregresState{
                    CustomProgressView()
                }
            }
            
            .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) {
                if let item = selectedItem {
                    Task {
                        if let data = try? await
                            
                            item.loadTransferable(type: Data.self) {
                            selectImage = UIImage(data: data)
                            // selectImage 픽커에서 선택한 이미지 ------
                            
                            imageData = data
                            showCamera = false
                            print("이미지 사진 : ", selectImage!)
                            print("data : \(imageData!)")
                            print(checkImage)
                            // 이미지 분류 함수 호출
                            
                            if let selectedImage = selectImage {
                                loadModel.classifyImage(selectedImage) { response in
                                    if response {
                                        print("제대로 처리")
                                        
                                        loadModel.isLoad = false
                                        print("카메라뷰",loadModel.isLoad)
                                    }
                                    if loadModel.classificationLabel == "meat" {
                                        
                                    } else {
                                        checkImage = "이미지가 고기가 아닌거같아요 다시 선택해 주세요."
                                        
                                        print("camera", checkImage)
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }
                        
                    }
                    
                }
            }
            
        }

    }
    // 움직이는 카메라뷰
    private var cameraPreview: some View {
        GeometryReader { geo in
                    
                CameraPreview(cameraVM: $VM, frame: geo.frame(in: .global))
                    .ignoresSafeArea()
                    .onAppear {
                        VM.requestAccessAndSetup()
                    }
            
        }
        .ignoresSafeArea()
    }
    
    //    private var overlayContent: some View {
    //        VStack {
    //            Spacer()
    //
    //            HStack {
    //                Spacer()
    //
    //                VStack {
    //                    Text("촬영 버튼")
    //                        .font(.subheadline)
    //                        .foregroundColor(.white)
    //                        .padding(5)
    //                        .background(Color.black.opacity(0.7))
    //                        .cornerRadius(5)
    //
    //                    Image(systemName: "camera")
    //                        .resizable()
    //                        .frame(width: 50, height: 50)
    //                        .foregroundColor(.white)
    //                }
    //                .padding()
    //            }
    //        }
    //    }
    
    // 오버레이
//    private var helpOverlay: some View {
//            ZStack {
//                Color.black.opacity(0.7)
//                    .ignoresSafeArea()
//                VStack {
//                    Text("버튼 기능 설명")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                        .cornerRadius(10)
//                        .padding()
//                    
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Text("갤러리 버튼")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Text("사진 찍기")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Text("카메라 전환")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                            .padding()
//                        Spacer()
//                    }
//                    HStack {
//                        Spacer()
//                        Image(systemName: "arrow.down")
//                            .resizable()
//                            .frame(width: 45, height: 45)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Image(systemName: "arrow.down")
//                            .resizable()
//                            .frame(width: 45, height: 45)
//                            .padding()
//                        Spacer()
//                        Spacer()
//                        Image(systemName: "arrow.down")
//                            .resizable()
//                            .frame(width: 45, height: 45)
//                            .padding()
//                        Spacer()
//                    }
//                    .padding(.bottom, 50)
//                    Text("화면을 터치하여 도움말을 닫으세요")
//                        .font(.subheadline)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//            }
//        }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(imageData: .constant(nil), showCamera: .constant(true), checkImage: .constant(""))
    }
}
