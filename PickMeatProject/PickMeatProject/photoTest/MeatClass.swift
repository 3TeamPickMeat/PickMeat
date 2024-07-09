import SwiftUI
import PhotosUI

struct MeatClass: View {
    @State private var image: UIImage? = nil
    @StateObject private var viewModel = ImageClassificationViewModel()
    @State  var selectedItem: PhotosPickerItem?
 

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 300, height: 300)
                    .overlay(Text("Select an image").foregroundColor(.white))
            }

            PhotosPicker("Select an image", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem, {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                            image = UIImage(data: data)
                           // viewModel.classifyImage(image!, completion: true - > void)
                        }
                        
                    }
                })

            Text(viewModel.classificationLabel)
                .padding()
                .font(.headline)
        }
        .padding()
    }
}
