//
//  SaveDogView.swift
//  RandomAPIsSwiftUI
//
//  Created by Skyler Robbins on 1/24/25.
//

import SwiftUI

struct SaveDogView: View {
    @State var dogName: String = ""
    @State var image: SwiftUI.Image?
    @EnvironmentObject var dogListManager: DogListManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("Dog Name", text: $dogName)
                .frame(width: 300, height: 50)
                .multilineTextAlignment(.center)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save Dog") {
                if let image = image {
                    let newDog = Dog(name: dogName, image: image)
                    dogListManager.dogs.append(newDog) // Update shared DogListManager
                }
                dismiss() // Close the sheet
            }
            .buttonStyle(FetchDogPhotoButtonStyle())
            .padding()

            Button("Cancel") {
                dismiss() // Close the sheet without saving
            }
            .buttonStyle(CancelButtonStyle())
            .padding()
        }
    }
}

struct CancelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background {
                Color.red.cornerRadius(10)
                    .opacity(configuration.isPressed ? 0.5 : 0.7)
            }
            .shadow(color: .gray, radius: configuration.isPressed ? 0 : 5)
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

#Preview {
    SaveDogView()
        .environmentObject(DogListManager()) // Required for preview
}
