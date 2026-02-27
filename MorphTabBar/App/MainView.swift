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
    @State var isExpand: Bool = false
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .bottom) {
            
            activeTab.view
            
            MorphTabBar(activeTab: $activeTab, isExpand: $isExpand, actions: ActionModel.dummyList) { i, action in
                print("Tapped index: \(i)")
                print("Action: \(action.title)")
            }        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

#Preview {
    MainView()
}
