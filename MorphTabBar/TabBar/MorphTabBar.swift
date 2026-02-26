//
//  MorphTabBar.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

struct MorphTabBar<ExpandedContent: View>: View {
    
    // MARK: - Properties
    var barHeight: CGFloat = 52
    
    // MARK: - Builders
    @Binding var activeTab: AppTab
    @Binding var isExpanded: Bool
    @ViewBuilder var expandedContent: ExpandedContent
    @State private var viewWidth: CGFloat?
    
    // MARK: - View
    var body: some View {
        ZStack {
            
            let icons = Array(AppTab.allCases).compactMap( { $0.icon })
            let selectedIndex = Binding {
                return icons.firstIndex(of: activeTab.icon) ?? 0
            } set: { index in
                activeTab = Array(AppTab.allCases)[index]
            }
            
            if let viewWidth {
                let progress: CGFloat = isExpanded ? 1 : 0
                let labelSize: CGSize = CGSize(width: viewWidth, height: barHeight)
                let cornerRadius: CGFloat = labelSize.height / 2
                
                MorphGlassView(alignment: .center, progress: progress, labelSize: labelSize, cornerRadius: cornerRadius) {
                    expandedContent
                } label: {
                    CustomTabBar(index: selectedIndex, icons: icons) { image in
                        let font = UIFont.systemFont(ofSize: 19)
                        let config = UIImage.SymbolConfiguration(font: font)
                        
                        return UIImage(systemName: image, withConfiguration: config)
                    }
                    .frame(height: barHeight - 4)
                    .padding(.horizontal, 2)
                    .offset(y: -0.7)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .onGeometryChange(for: CGFloat.self) {
            $0.size.width
        } action: { newValue in
            viewWidth = newValue
        }
        .frame(height: viewWidth == nil ? barHeight : nil)
    }
}


// MARK: - Custom Tab Bar
fileprivate struct CustomTabBar: UIViewRepresentable {
    
    @Binding var index: Int
    var tint: Color = .gray.opacity(0.15)
    var icons: [String]
    var image: (String) -> UIImage?
    
    func makeUIView(context: Context) -> UISegmentedControl {
        let control = UISegmentedControl(items: icons)
        control.selectedSegmentIndex = index
        control.selectedSegmentTintColor = UIColor(tint)
        
        for (index, icon) in icons.enumerated() {
            control.setImage(image(icon), forSegmentAt: index)
        }
        control.addTarget(context.coordinator, action: #selector(context.coordinator.didSelect(_:)), for: .valueChanged)
        removeBackgroundColor(control: control)
        return control
    }
    
    func removeBackgroundColor(control: UISegmentedControl) {
        DispatchQueue.main.async {
            for view in control.subviews.dropLast() {
                if view is UIImageView {
                    view.alpha = 0
                }
            }
        }
    }
    
    func updateUIView(_ control: UISegmentedControl, context: Context) {
        guard control.selectedSegmentIndex != index else { return }
        control.selectedSegmentIndex = index
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        var parent: CustomTabBar
        init(parent: CustomTabBar) {
            self.parent = parent
        }
        
        @objc
        func didSelect(_ control: UISegmentedControl) {
            parent.index = control.selectedSegmentIndex
        }
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UISegmentedControl, context: Context) -> CGSize? {
        return proposal.replacingUnspecifiedDimensions()
    }
}

#Preview {
    @Previewable @State var activeTab: AppTab = .home
    @Previewable @State var isExpanded: Bool = false
    
    MorphTabBar(activeTab: $activeTab, isExpanded: $isExpanded) {}
}
