//
//  MainView.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - Builders
    @State var activeTab: AppTab = .home
    @State var isExpanded: Bool = false
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    activeTab.view
                }
            
            MorphTabBar(
                activeTab: $activeTab,
                isExpanded: $isExpanded,
                actions: ActionModel.dummyList
            ) { index, action in
                print("Tapped index: \(index)")
                print("Action: \(action.title)")
            }        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
}

#Preview {
    MainView()
}
