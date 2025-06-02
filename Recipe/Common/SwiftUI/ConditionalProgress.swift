//
//  ConditionalProgress.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import Foundation
import SwiftUICore
import SwiftUI

struct ProgressViewModifier: ViewModifier {
    let showProgress: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if showProgress {
                ProgressView()
            }
        }
    }
}
