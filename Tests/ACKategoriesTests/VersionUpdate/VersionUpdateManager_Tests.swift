import ACKategories
import ACKategoriesTesting
import XCTest

final class VersionUpdateManager_Tests: XCTestCase {
    func test_minBuildNumber_lower() async throws {
        let fetcher = VersionUpdateFetcher_Mock()
        let buildNumber = Int.random(in: 1..<10_000)
        
        fetcher.minBuildNumber = buildNumber - 1
        
        let subject = VersionUpdateManager(
            buildNumberProvider: buildNumber,
            fetcher: fetcher
        )
        let updateRequired = await subject.updateRequired
        
        XCTAssertFalse(updateRequired)
    }
    
    func test_minBuildNumber_equal() async throws {
        let fetcher = VersionUpdateFetcher_Mock()
        let buildNumber = Int.random(in: 1..<10_000)
        
        fetcher.minBuildNumber = buildNumber
        
        let subject = VersionUpdateManager(
            buildNumberProvider: buildNumber,
            fetcher: fetcher
        )
        let updateRequired = await subject.updateRequired
        
        XCTAssertFalse(updateRequired)
    }
    
    func test_minBuildNumber_higher() async throws {
        let fetcher = VersionUpdateFetcher_Mock()
        let buildNumber = Int.random(in: 1..<10_000)
        
        fetcher.minBuildNumber = buildNumber + 1
        
        let subject = VersionUpdateManager(
            buildNumberProvider: buildNumber,
            fetcher: fetcher
        )
        let updateRequired = await subject.updateRequired
        
        XCTAssertTrue(updateRequired)
    }
}
