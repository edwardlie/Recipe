//
//  ImageErrorView.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//


import SwiftUI

enum ImageError: Error {
    case serverError
    case noData
}

struct ImageErrorView: View {
    let error: Error

    var body: some View {
        return Text("❌ **Error**").font(.system(size: 60))
    }
}

#Preview {
    ImageErrorView(error: ImageError.noData)
}
