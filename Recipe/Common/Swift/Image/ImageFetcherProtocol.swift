//
//  ImageFetcherProtocol.swift
//  Recipe
//
//  Created by Edward Lie on 5/29/25.
//

import Foundation
import UIKit
import SwiftUICore

protocol ImageFetcherProtocol: Sendable {
    func fetchImage(filePath: String) async throws -> Data
}
