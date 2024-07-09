//
//  MeatOrNot.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/8/24.
//

import SwiftUI
import CoreML
import Vision

class ImageClassificationViewModel: ObservableObject {
    @Published var classificationLabel: String = ""
    @Published var isLoad: Bool = true
   
    private var model: VNCoreMLModel?

    init() {
        loadModel()
    }
    
    private func loadModel() {
        let config = MLModelConfiguration()
        do {
            // 모델 이름을 사용하여 모델 로드
            let coreMLModel = try Meatclassfication(configuration: config)
            self.model = try VNCoreMLModel(for: coreMLModel.model)
            print("Model loaded successfully")
        } catch {
            print("Failed to load model: \(error)")
        }
    }

    func classifyImage(_ image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let model = self.model else {
            print("Model is not loaded")
         
            completion(false)
            return
        }
 
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNCoreMLRequest(model: model) { (request, error) in

            //request.usesCPUOnly = true
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                DispatchQueue.main.async {
                    self.classificationLabel = topResult.identifier
                    print("vm 에서",self.classificationLabel)
                    self.isLoad = false
                    completion(true)
                  
                }
            } else {
                print("Failed to perform classification: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
            }
        }

        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform request: \(error)")
 
            completion(false)
        }
    }
}
