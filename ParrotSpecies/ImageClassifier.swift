//
//  ImageClassification.swift
//  SeeFood
//
//  Created by Leon Wei on 5/31/21.
//

import SwiftUI

class ImageClassifier: ObservableObject {
  
  @Published private var classifier = Classifier()
  
  var imageClass: String? {
    if let confidence = classifier.confidence, let results = classifier.results {
      return results + " " + String(confidence)
    } else {
      return nil
    }
  }
  
  var imageConfidence: Float? {
    classifier.confidence
  }
  
  // MARK: Intent(s)
  func detect(uiImage: UIImage) {
    guard let ciImage = CIImage (image: uiImage) else { return }
    classifier.detect(ciImage: ciImage)
    
  }
  
}
