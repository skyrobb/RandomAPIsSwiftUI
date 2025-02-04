//
//  Dog.swift
//  RandomAPIsSwiftUI
//
//  Created by Skyler Robbins on 1/24/25.
//

import Foundation
import SwiftUI

struct Dog: Identifiable {
    let id = UUID()
    var name: String
    var image: SwiftUI.Image
}
