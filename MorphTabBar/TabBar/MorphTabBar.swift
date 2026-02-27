//
//  MorphTabBar.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

struct MorphTabBar: View {
    
    // MARK: - Builders
    @Binding var activeTab: AppTab
    @Binding var isExpanded: Bool
    @State private var viewWidth: CGFloat?
    
    // MARK: - Properties
    var barHeight: CGFloat = 62
    var actions: [ActionModel]
    var onActionTap: (Int, ActionModel) -> Void
    
    // MARK: - View
    var body: some View {
        HStack(alignment: .bottom, spacing: 12) {
            
            tabBarView
            
            Button {
                withAnimation(.bouncy(duration: 0.5, extraBounce: 0.05)) {
                    isExpanded.toggle()
                }
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 19, weight: .bold))
                    .rotationEffect(.degrees(isExpanded ? 45 : 0))
                    .foregroundStyle(isExpanded ? .gray : .primary)
                    .frame(width: barHeight, height: barHeight)
            }
            .buttonStyle(MorphButtonStyle(shape: .circle))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 25)
    }
    
    // MARK: - Tab Bar View
    @ViewBuilder
    private var tabBarView: some View {
        ZStack {
            let icons = Array(AppTab.allCases).compactMap { $0.icon }
            
            let selectedIndex = Binding {
                icons.firstIndex(of: activeTab.icon) ?? 0
            } set: { index in
                activeTab = Array(AppTab.allCases)[index]
            }
            
            if let viewWidth {
                let progress: CGFloat = isExpanded ? 1 : 0
                let labelSize = CGSize(width: viewWidth, height: barHeight)
                let cornerRadius = labelSize.height / 2
                
                MorphGlassView(
                    alignment: .center,
                    progress: progress,
                    labelSize: labelSize,
                    cornerRadius: cornerRadius
                ) {
                    actionsView
                } label: {
                    GlassTabBar(index: selectedIndex, icons: icons) { image in
                        let font = UIFont.systemFont(ofSize: 18)
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
    
    // MARK: - Actions View
    @ViewBuilder
    private var actionsView: some View {
        GlassEffectContainer(spacing: 10) {
            LazyVGrid(
                columns: Array(repeating: GridItem(spacing: 10), count: 4),
                spacing: 10
            ) {
                ForEach(Array(actions.enumerated()), id: \.element.id) { index, action in
                    VStack(spacing: 6) {
                        Button {
                            onActionTap(index, action)
                            
                            withAnimation(.bouncy(duration: 0.4)) {
                                isExpanded = false
                            }
                        } label: {
                            Image(systemName: action.icon)
                                .font(.title3)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundStyle(action.color.opacity(0.7))
                                .background(.gray.opacity(0.09), in: .rect(cornerRadius: 16))
                        }
                        .buttonStyle(
                            MorphButtonStyle(shape: .rect(cornerRadius: 16))
                        )
                        
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
    @Previewable @State var activeTab: AppTab = .home
    @Previewable @State var isExpanded: Bool = false
    
    MorphTabBar(activeTab: $activeTab, isExpanded: $isExpanded, actions: ActionModel.dummyList) {_,_ in }
}



// MARK: - Glass Tab Bar
fileprivate struct GlassTabBar: UIViewRepresentable {
    
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
        var parent: GlassTabBar
        
        init(parent: GlassTabBar) {
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
