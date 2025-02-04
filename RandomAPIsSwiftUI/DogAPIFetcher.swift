//
//  DogAPIFetcher.swift
//  RandomAPIsSwiftUI
//
//  Created by Skyler Robbins on 1/22/25.
//

import SwiftUI

enum DogError: Error {
    case imageDataMissing
    case invalidResponse
    case invalidURL
}

struct DogPhotoResponse: Decodable {
    let status: String
    let message: String // URL for the dog photo
}

struct DogAPIFetcher {
    /// Fetch a random dog photo as a SwiftUI `Image`.
    static func fetchDogPhoto() async throws -> SwiftUI.Image {
        // Create the URL for the API
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            throw DogError.invalidURL
        }
        
        // Fetch data from the API
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Decode the JSON response
        let photoResponse = try JSONDecoder().decode(DogPhotoResponse.self, from: data)
        
        // Validate the response and status
        guard photoResponse.status == "success",
              let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DogError.invalidResponse
        }
        
        // Fetch the actual image from the photo URL
        return try await fetchDogImage(from: URL(string: photoResponse.message)!)
    }
    
    /// Fetch an image from a given URL and return it as a SwiftUI `Image`.
    static func fetchDogImage(from url: URL) async throws -> SwiftUI.Image {
        // Fetch the image data
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Validate the response and create a UIImage
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200,
              let uiImage = UIImage(data: data) else {
            throw DogError.imageDataMissing
        }
        
        // Convert UIImage to SwiftUI Image
        return Image(uiImage: uiImage)
    }
}

