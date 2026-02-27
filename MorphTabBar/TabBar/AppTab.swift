//
//  AppTab.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 26/02/2026.
//

import SwiftUI

enum AppTab: String, CaseIterable {
    case home = "Home"
    case records = "Records"
    case notifications = "Notifications"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .home: "house.fill"
        case .records: "video.fill"
        case .notifications: "bell.fill"
        case .settings: "gearshape.fill"
        }
    }
    
    @ViewBuilder
    var view: some View {
        
        /// For testing (remove later)
        dummyView()
    }
    
    // MARK: - For Testing
    private func dummyView() -> some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: self.icon)
                    Text(self.rawValue)
                        .font(.headline)
                }
                .padding(.vertical, 8)
                
                ForEach(0 ..< 5) { _ in
                    SkeletonRow()
                        .padding(.horizontal, 8)
                        .padding(.vertical, 16)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 100)
            .padding(.top, 16)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}



