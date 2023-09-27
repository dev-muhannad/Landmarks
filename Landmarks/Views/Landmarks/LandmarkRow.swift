//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Muhannad on 02/08/2023.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark // When you add the landmark property, the preview stops working, because the LandmarkRow type needs a landmark instance during initialization. To fix the preview, you’ll need to add the landmark parameter to the LandmarkRow initializer, specifying one or a few elements of the landmarks array.

    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            
            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider { // The code you write in a preview provider only changes what Xcode displays in the canvas.
    static var landmarks = ModelData().landmarks
    
    static var previews: some View {
        Group {
            LandmarkRow(landmark: landmarks[0])
            LandmarkRow(landmark: landmarks[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
