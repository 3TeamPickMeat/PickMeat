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

    @State var VM = CameraViewModel()
    @Binding var imageData: Data?
    @Binding var showCamera: Bool
    @State var selectedItem: PhotosPickerItem?
    @State var selectImage: UIImage?

    @State var showPhotoPicker = false
    @State var recentPhotoData: Data?

    let controlButtonWidth: CGFloat = 120
    let controlFrameHeight: CGFloat = 90

    var isLandscape: Bool { vertiSizeClass == .compact }

    var body: some View {
        ZStack {
            Color(red: 197/255, green: 227/255, blue: 255/255)
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
        }
        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem, matching: .images)
        .onChange(of: selectedItem) {
            if let item = selectedItem {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        selectImage = UIImage(data: data)
                        imageData = data
                        showCamera = false
                        print("이미지 사진 : ", selectImage!)
                        print("data : \(imageData!)")
                    }
                }
            }
        }
    }

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

}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(imageData: .constant(nil), showCamera: .constant(true))
    }
}

