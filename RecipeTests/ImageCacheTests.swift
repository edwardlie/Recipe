//
//  ImageCacheTests.swift
//  RecipeTests
//
//  Created by Edward Lie on 6/2/25.
//

@testable import Recipe
import Testing
import Combine
import Foundation

actor MockImageFetcher: ImageFetcherProtocol {
    
    var fetchCount = 0
    var failedToFetch = false
    var dataToReturn: Data = Data()
    
    func setFailedToFetch(_ value: Bool) {
        failedToFetch = value
    }
    
    func fetchImage(filePath: String) async throws -> Data {
        fetchCount += 1
        if failedToFetch {
            throw NSError(domain: "MockImageFetcher", code: 1, userInfo: nil)
        }
        return dataToReturn
    }
}

struct ImageCacheTests {

    @Test func imageCachedSuccessfully() async throws {
        let mockImageFetcher = MockImageFetcher()
        let imageCache = ImageCache(imageFetcher: mockImageFetcher)
        let filePath = Bundle.main.url(forResource: "TestImage", withExtension: "jpg")?.path
        
        let notCachedResult = try await imageCache.fetchImage(filePath: filePath!)
        #expect(notCachedResult.data == Data())
        await #expect(mockImageFetcher.fetchCount == 1)
        
        let cachedResult = try await imageCache.fetchImage(filePath: filePath!)
        #expect(cachedResult.data == Data())
        await #expect(mockImageFetcher.fetchCount == 1)
    }
    
    @Test func imageCacheFailed() async throws {
        var failCount = 0
        let mockImageFetcher = MockImageFetcher()
        await mockImageFetcher.setFailedToFetch(true)
        let imageCache = ImageCache(imageFetcher: mockImageFetcher)
        let filePath = Bundle.main.url(forResource: "TestImage", withExtension: "jpg")?.path
        
        do {
            _ = try await imageCache.fetchImage(filePath: filePath!)
        } catch {
            failCount += 1
        }
        
        do {
            _ = try await imageCache.fetchImage(filePath: filePath!)
        } catch {
            failCount += 1
        }
        
        #expect(failCount == 2)
        await #expect(mockImageFetcher.fetchCount == 1)
    }
}
