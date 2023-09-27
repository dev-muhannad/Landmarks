//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by Muhannad on 04/08/2023.
//

import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    
    var landmarkIndex: Int {
        modelData.landmarks.firstIndex(where: {$0.id == landmark.id})!
    }
    
    var body: some View {
            ScrollView { // Unlike stacks, ScrollView can make the user scroll through the descriptive content.
                MapView(coordinate: landmark.locationCoordinate)
                            .ignoresSafeArea(edges: .top) // To allow the map content to extend to the top edge of the screen.
                            .frame(height: 300) // When you specify only the height parameter, the view automatically sizes to the width of its content. In this case, MapView expands to fill the available space.
                        
                CircleImage(image: landmark.image)
                            .offset(y: -130)
                            .padding(.bottom, -130)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(landmark.name)
                                    .font(.title)
                                FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite) // Use landmarkIndex with the modelData object to ensure that the button updates the isFavorite property of the landmark stored in your model object.
                                // As you navigate from the list to the detail and tap the button, those changes persist when you return to the list. Because both views access the same model object in the environment, the two views maintain consistency.
                            }
                            HStack {
                                Text(landmark.park)
        
                                Spacer() // To direct the layout to use the full width of the device, separate the park and the state by adding a Spacer to the horizontal stack holding the two text views. A spacer expands to make its containing view use all of the space of its parent view, instead of having its size defined only by its contents.
                                
                                Text(landmark.state)
                                    .font(.subheadline)
                            }
                            
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            // When you apply a modifier to a layout view like a stack, SwiftUI applies the modifier to all the elements contained in the group.
                            
                            Divider()
                            
                            Text("About \(landmark.name)")
                                .font(.title2)
                            Text(landmark.description)

                        }
                        .padding()
            }
            .navigationTitle(landmark.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[4])
            .environmentObject(ModelData())
    }
}
