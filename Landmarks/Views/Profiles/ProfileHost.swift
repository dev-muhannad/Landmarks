//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Muhannad on 19/08/2023.
//

import SwiftUI

struct ProfileHost: View {
    @State private var draftProfile = Profile.default
    @EnvironmentObject var modelData: ModelData
    @Environment(\.editMode) var editMode // SwiftUI provides storage in the environment for values you can access using the @Environment property wrapper. Access the editMode value to read or write the edit scope.

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    } // Unlike the Done button that EditButton provides, the Cancel button doesn’t apply the edits to the real profile data in its closure.
                }
                Spacer()
                EditButton() // This toggles the environment’s editMode value on and off.
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
                // Apply the onAppear(perform:) and onDisappear(perform:) modifiers to populate the editor with the correct profile data and update the persistent profile when the user taps the Done button. Otherwise, the old values appear the next time edit mode activates.
            }
        }
        .padding()
    }
}


struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData()) // Even though this view doesn’t use a property with the @EnvironmentObject attribute, ProfileSummary, a child of this view, does. So without the modifier, the preview fails.
    }
}
