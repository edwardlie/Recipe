//
//  EmptyImageView.swift
//  Recipe
//
//  Created by Edward Lie on 6/2/25.
//

import SwiftUI

struct EmptyImageView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .foregroundColor(.gray.opacity(0.6))
            Text("No Image Available")
                .font(.headline)
                .foregroundColor(.gray.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.main.bounds.height)
        .background(Color(.systemBackground).opacity(0.6))
    }
}
