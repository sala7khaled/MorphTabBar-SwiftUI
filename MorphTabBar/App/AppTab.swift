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
    case notifications = "Chats"
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
        
        /// uncomment for real implementation
//        switch self {
//        case .home: HomeView()
//        case .records: RecordView()
//        case .notifications: NotificationView()
//        case .settings: SettingView()
//        }
        
        VStack(spacing: 8) {
            Image(systemName: self.icon)
            Text(self.rawValue)
                .font(.footnote)
        }
        .foregroundStyle(.gray)
        .frame(width: 120, height: 120)
        .background(.gray.opacity(0.05))
        .cornerRadius(16)
    }
}
