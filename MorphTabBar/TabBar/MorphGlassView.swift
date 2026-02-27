//
//  MorphGlassView.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

struct MorphGlassView<Content: View, Label: View>: View, Animatable {
    
    // MARK: - Properties
    var alignment: Alignment
    var progress: CGFloat
    var labelSize: CGSize = .init(width: 55, height: 55)
    var cornerRadius: CGFloat = 30
    
    // MARK: - Builders
    @ViewBuilder var content: Content
    @ViewBuilder var label: Label
    @State private var contentSize: CGSize = .zero
    
    // MARK: - View
    var body: some View {
        GlassEffectContainer {
            
            let widthDiff = contentSize.width - labelSize.width
            let heightDiff = contentSize.height - labelSize.height
            
            let widthRadius = widthDiff * contentOpacity
            let heightRadius = heightDiff * contentOpacity
            
            ZStack(alignment: alignment) {
                content
                    .compositingGroup()
                    .scaleEffect(contentScale)
                    .blur(radius: 14 * blurProgress)
                    .opacity(contentOpacity)
                    .onGeometryChange(for: CGSize.self) {
                        $0.size
                    } action: { newValue in
                        contentSize = newValue
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(
                        width: labelSize.width + widthRadius,
                        height: labelSize.height + heightRadius
                    )
                label
                    .compositingGroup()
                    .blur(radius: 14 * blurProgress)
                    .opacity(1 - labelOpacity)
                    .frame(width: labelSize.width, height: labelSize.height)
            }
            .compositingGroup()
            .clipShape(.rect(cornerRadius: cornerRadius))
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: cornerRadius))
        }
        .scaleEffect(
            x: 1 - (blurProgress * 0.5),
            y: 1 + (blurProgress * 0.35),
            anchor: scaleAnchor
        )
        .offset(y: offset * blurProgress)
    }
    
    // MARK: - Computed Properties
    var labelOpacity: CGFloat {
        min(progress / 0.35, 1)
    }
    
    var contentOpacity: CGFloat {
        max(progress - 0.35, 0) / 0.65
    }
    
    var contentScale: CGFloat {
        let minAspectScale = min(labelSize.width / contentSize.width,
                                 labelSize.height / contentSize.height)
        return minAspectScale + (1 - minAspectScale) * progress
    }
    
    var blurProgress: CGFloat {
        progress > 0.5 ? ((1 - progress) / 0.5) : (progress / 0.5)
    }
    
    var offset: CGFloat {
        switch alignment {
        case .bottom, .bottomLeading, .bottomTrailing: -80
        case .top, .topLeading, .topTrailing: 80
        default: -10
        }
    }
    
    var scaleAnchor: UnitPoint {
        switch alignment {
        case .bottomLeading: .bottomLeading
        case .bottom: .bottom
        case .bottomTrailing: .bottomTrailing
        case .topLeading: .topLeading
        case .top: .top
        case .topTrailing: .topTrailing
        case .leading: .leading
        case .trailing: .trailing
        default: .center
        }
    }
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
}


// MARK: - Morph Button Style
struct MorphButtonStyle<S: Shape>: ButtonStyle {
    var shape: S
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.glassEffect(.regular.interactive(), in: shape)
    }
}
