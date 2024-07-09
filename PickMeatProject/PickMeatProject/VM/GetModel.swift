import SwiftUI
import CoreML
import Vision

class GetModelFunc: ObservableObject {
    @Published var results: [VNRecognizedObjectObservation] = []  // 감지된 결과를 저장할 배열
    private var model: VNCoreMLModel?  // CoreML 모델을 래핑하는 VNCoreMLModel 객체

    init() {
        // 모델 초기화
        let config = MLModelConfiguration()
        
        do {
            // 모델 이름을 사용하여 모델 로드
            let coreMLModel = try MeatDetecting(configuration: config)
            self.model = try VNCoreMLModel(for: coreMLModel.model)
        } catch {
            print("Failed to load model: \(error)")
        }
    }

    func detectObjects(in image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let model = self.model else {
            print("Model is not loaded")
            completion(false)
            return
        }

        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let results = request.results as? [VNRecognizedObjectObservation] {
                DispatchQueue.main.async {
                    self.results = results
                    completion(true)
                    
                }
            } else {
                completion(false)
                print("Failed to perform detection: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        request.imageCropAndScaleOption = .centerCrop
        do {
            try handler.perform([request])
        } catch {
            completion(false)
            print("Failed to perform request: \(error)")
        }
    }
}
