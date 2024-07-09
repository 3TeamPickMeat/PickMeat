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
    func uploadImage(image: UIImage, to urlString: String, x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, completion: @escaping (String?) -> Void){
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.pngData() {
                multipartFormData.append(imageData, withName: "file", fileName: "\(self.count).jpg", mimeType: "image/jpg")
            }
          
            let parameters: [String: Any] = [
                "x": String(format: "%.2f", x),
                "y": String(format: "%.2f", y),
                "w": String(format: "%.2f", w),
                "h": String(format: "%.2f", h)
            ]
            for (key, value) in parameters {
                       if let stringValue = value as? String {
                           multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                       }
                   }
            
        }, to: url)
        .validate()
        .response { response in
            switch response.result {
            case .success(let data):
                if let jsondata = data {
                    print("Image uploaded successfully:", String(data: jsondata, encoding: .utf8) ?? "")
                    //Pred(resulttext: String(data: jsondata, encoding: .utf8)!)
                    let resultString = String(data: jsondata, encoding: .utf8) ?? ""
                    self.count += 1
                    completion(resultString)
                }
            case .failure(let error):
                print("Error uploading image:", error)
            }
        }
    }
}
