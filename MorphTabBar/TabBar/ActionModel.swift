//
//  ActionModel.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

struct ActionModel: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    var color: Color = .primary
    
    /// Dummy array data list
    static let dummyList: [ActionModel] = [
        ActionModel(icon: "scissors", title: "Trim"),
        ActionModel(icon: "crop", title: "Crop"),
        ActionModel(icon: "wand.and.stars", title: "Enhance"),
        ActionModel(icon: "textformat", title: "Text"),
        ActionModel(icon: "music.note", title: "Audio"),
        ActionModel(icon: "hare", title: "Speed"),
        ActionModel(icon: "square.on.square", title: "Duplicate"),
        ActionModel(icon: "arrow.uturn.backward", title: "Undo"),
        ActionModel(icon: "square.and.arrow.up", title: "Share"),
        ActionModel(icon: "bookmark", title: "Save"),
        ActionModel(icon: "trash", title: "Delete", color: .red)
    ]
}
