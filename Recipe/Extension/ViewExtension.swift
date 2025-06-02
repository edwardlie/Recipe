//
//  ViewExtension.swift
//  Recipe
//
//  Created by Edward Lie on 5/30/25.
//

import SwiftUI

extension View {
    func progressOverlay(showProgress: Bool) -> some View {
        self.modifier(ProgressViewModifier(showProgress: showProgress))
    }
}
