//
//  SendPythonModel.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/8/24.
//

import Foundation
import SwiftUI
import Alamofire

class SendImageViewModel: ObservableObject {
    var count = 1
    func uploadImage(image: UIImage, to urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.pngData() {
                multipartFormData.append(imageData, withName: "file", fileName: "\(self.count).jpg", mimeType: "image/jpg")
            }
        }, to: url)
        .response { response in
            switch response.result {
            case .success(let data):
                if let jsonData = data {
                    print("Image uploaded successfully:", String(data: jsonData, encoding: .utf8) ?? "")
                    self.count += 1
                }
            case .failure(let error):
                print("Error uploading image:", error)
            }
        }
    }
}
