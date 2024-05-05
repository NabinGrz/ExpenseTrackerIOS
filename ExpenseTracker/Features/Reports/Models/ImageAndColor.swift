//
//  ImageAndColor"swift
//  ExpenseTracker
//
//  Created by Nabin Gurung on 27/04/2024"
//

import Foundation
import SwiftUI


struct ImageColorModel {
    let image: String
    let color: Color
}

final class PickImage {
    func get(category: String) -> ImageColorModel {
        switch category {
        case "Food":
            return ImageColorModel(image: "food", color: .yellow)
        case "Water":
            return ImageColorModel(image: "water", color: .pink)
        case "Clothing":
            return ImageColorModel(image: "clothing", color: .blue)
        case "Cosmetic":
            return ImageColorModel(image: "cosmetic", color: .green)
        case "Utils":
            return ImageColorModel(image: "utils", color: .red)
        case "Bike":
            return ImageColorModel(image: "bike", color: .purple)
        case "Transport":
            return ImageColorModel(image: "transport", color: .yellow)
        case "Khaja":
            return ImageColorModel(image: "khaja", color: .blue)
        case "Chocolate":
            return ImageColorModel(image: "chocolate", color: .pink)
        case "Meat":
            return ImageColorModel(image: "meat", color: .green)
        case "Milk":
            return ImageColorModel(image: "milk", color: .red)
        case "Grocery":
            return ImageColorModel(image: "grocery", color: .purple)
        case "Fruits":
            return ImageColorModel(image: "fruits", color: .blue)
        case "Stationary":
            return ImageColorModel(image: "stationary", color: .yellow)
        default:
            return ImageColorModel(image: "bill", color: .green)
        }
    }
}
