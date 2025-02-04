//
//  DogListView.swift
//  RandomAPIsSwiftUI
//
//  Created by Skyler Robbins on 1/24/25.
//

import SwiftUI

struct DogListView: View {
    @EnvironmentObject var dogListManager: DogListManager

    var body: some View {
        List(dogListManager.dogs) { dog in
            HStack {
                dog.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text(dog.name)
            }
        }
        .navigationTitle("Saved Dogs")
    }
}


#Preview {
    DogListView()
}
