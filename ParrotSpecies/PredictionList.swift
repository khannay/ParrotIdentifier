//
//  PredictionList.swift
//  ParrotSpecies
//
//  Created by Kevin Hannay on 11/7/21.
//

import SwiftUI

struct SpeciesOption: Identifiable {
  var species: String
  var confidence: Float
  var id: UUID = UUID()
}

struct PredictionList: View {
  @State var speciesOptions: [SpeciesOption]
  
  var body: some View {
    VStack {
      ForEach(speciesOptions) { prediction in
        Text(prediction.species+String(prediction.confidence))
      }
    }
  }
}

struct PredictionList_Previews: PreviewProvider {
  static var previews: some View {
    PredictionList(speciesOptions: [SpeciesOption(species: "quaker", confidence: 0.1), SpeciesOption(species: "Caique", confidence: 0.3)])
  }
}
