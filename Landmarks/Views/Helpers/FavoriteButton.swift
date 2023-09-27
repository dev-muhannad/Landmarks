//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Muhannad on 05/08/2023.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool // A binding controls the storage for a value, so you can pass data around to different views that need to read or write it.
    
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly) // The title string that you provide for the button’s label doesn’t appear in the UI when you use the iconOnly label style, but VoiceOver uses it to improve accessibility.
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
