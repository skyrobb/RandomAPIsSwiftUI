//
//  ContentView.swift
//  RandomAPIsSwiftUI
//
//  Created by Skyler Robbins on 1/22/25.
//

import SwiftUI

class DogListManager: ObservableObject {
    @Published var dogs: [Dog] = []
}

struct ContentView: View {
    @EnvironmentObject var dogListManager: DogListManager
    @State var dogImage: Image?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var isPresented: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                if let dogImage = dogImage {
                    dogImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 10)
                } else if isLoading {
                    ProgressView("Loading Dog Photo...")
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                HStack {
                    Button("Fetch Dog Photo") {
                        Task {
                            isLoading = true
                            errorMessage = nil
                            do {
                                dogImage = try await DogAPIFetcher.fetchDogPhoto()
                            } catch {
                                errorMessage = "Failed to load photo: \(error.localizedDescription)"
                            }
                            isLoading = false
                        }
                    }
                    .buttonStyle(FetchDogPhotoButtonStyle())
                    .padding()
                    Button("Save Dog") {
                        isPresented = true
                    }
                    .buttonStyle(FetchDogPhotoButtonStyle())
                    .padding()
                }
            }
            .padding()
            .sheet(isPresented: $isPresented) {
                SaveDogView(image: dogImage)
                    .environmentObject(dogListManager)
            }
            NavigationLink("View Saved Dogs") {
                DogListView()
            }
            .buttonStyle(FetchDogPhotoButtonStyle())
        }
    }
}


struct FetchDogPhotoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background {
                Color.green.cornerRadius(10)
                    .opacity(configuration.isPressed ? 0.5 : 0.7)
            }
            .shadow(color: .gray, radius: configuration.isPressed ? 0 : 5)
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}


#Preview {
    ContentView()
}
