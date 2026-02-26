//
//  ContentView.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Builders
    @State var activeTab: AppTab = .home
    @State var isExpanded: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    activeTab.view
                }
            
            HStack(alignment: .bottom, spacing: 12) {
                MorphTabBar(activeTab: $activeTab, isExpanded: $isExpanded) {
                    ExpandedContent()
                }
                Button {
                    withAnimation(.bouncy(duration: 0.5, extraBounce: 0.05)) {
                        isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 19, weight: .medium))
                        .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                        .frame(width: 52, height: 52)
                        .foregroundStyle(.primary)
                }
                .buttonStyle(MorphButtonStyle(shape: .circle))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @ViewBuilder
    func ExpandedContent() -> some View {
        GlassEffectContainer(spacing: 10) {
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 4), spacing: 10) {
                ForEach(actions) { action in
                    VStack(spacing: 6) {
                        Button {
                            print("\(action.title) clicked")
                        } label: {
                            Image(systemName: action.icon)
                                .font(.title3)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundStyle(action.color.opacity(0.7))
                                .background(.gray.opacity(0.09), in: .rect(cornerRadius: 16))
                        }
                        .buttonStyle(MorphButtonStyle(shape: .rect(cornerRadius: 16)))
                        
                        Text(action.title)
                            .font(.system(size: 9))
                            .foregroundStyle(action.color)
                    }
                    
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    ContentView()
}





// MARK: - Dummy Actions
struct ActionModel: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    var color: Color = .primary
}

let actions: [ActionModel] = [
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
