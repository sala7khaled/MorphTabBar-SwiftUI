//
//  SkeletonRow.swift
//  MorphTabBar
//
//  Created by Salah Khaled on 27/02/2026.
//

import SwiftUI

struct SkeletonRow: View {
    var body: some View {
        
        let color: Color = .gray.opacity(0.1)
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(alignment: .center) {
                
                // Avatar placeholder
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(color)
                    .frame(width: 44, height: 44)
                
                Spacer()
                
                // Right side
                VStack(spacing: 6) {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(color)
                        .frame(width: 40, height: 12)
                    
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .fill(color)
                        .frame(width: 40, height: 12)
                }
            }
            
            // Title line
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(color)
                .frame(height: 14)
            
            // Subtitle line
            RoundedRectangle(cornerRadius: 4, style: .continuous)
                .fill(color)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(width: 220, height: 12)
        }
    }
}
