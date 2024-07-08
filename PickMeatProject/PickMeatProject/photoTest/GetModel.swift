import SwiftUI
import CoreML
import Vision

class GetModelFunc: ObservableObject {
    @Published var results: [VNRecognizedObjectObservation] = []
    private var model: VNCoreMLModel?

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

    func detectObjects(in image: UIImage) {
        guard let model = self.model else {
            print("Model is not loaded")
            return
        }

        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNCoreMLRequest(model: model) { (request, error) in
            if let results = request.results as? [VNRecognizedObjectObservation] {
                DispatchQueue.main.async {
                    self.results = results
                }
            } else {
                print("Failed to perform detection: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        request.imageCropAndScaleOption = .centerCrop
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform request: \(error)")
        }
    }
}
