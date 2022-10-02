//
//  Classifier.swift
//  SeeFood
//
//  Created by Leon Wei on 5/31/21.
//

import CoreML
import Vision
import CoreImage


extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}


enum SpeciesPrediction {
  
  case africanGrey(confidence: Float)
  case amazon(confidence: Float)
  case budgie(confidence: Float)
  case caique(confidence: Float)
  case quaker(confidence: Float)
  case cockatiel(confidence: Float)
  case cockatoo(confidence: Float)
  case conure(confidence: Float)
  case indianRingneck(confidence: Float)
  case macaw(confidence: Float)
  case senegal(confidence: Float)
  case sunConure(confidence: Float)
}

struct Classifier {
  
  var results: String?
  var confidence: Float?
  
  mutating func detect(ciImage: CIImage) {
    
    guard let model = try? VNCoreMLModel(for: ParrotsClassifier(configuration: MLModelConfiguration()).model)
    else {
      return
    }
    
    let request = VNCoreMLRequest(model: model)
    
    let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
    
    try? handler.perform([request])
    
    guard let results = request.results as? [VNClassificationObservation] else {
      return
    }
    
    if let firstResult = results.first {
      self.results = firstResult.identifier.replacingOccurrences(of: "_", with: " ").capitalizingFirstLetter()
      self.confidence = firstResult.confidence.rounded(toPlaces: 3)
    }
    
  }
  
}

