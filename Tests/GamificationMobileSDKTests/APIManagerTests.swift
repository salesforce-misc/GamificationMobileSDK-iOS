/*
 * Copyright (c) 2023, Salesforce, Inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import XCTest
import GamificationMobileSDK


class MockAuthenticator: GamificationForceAuthenticator {
    static let sharedMock = MockAuthenticator()
    
    var needToThrowError = false
    
    func getAccessToken() -> String? {
        guard !needToThrowError else { return nil }
        return "AccessToken1234"
    }
    
    func grantAccessToken() async throws -> String {
        return "AccessToken1234"
    }
    
}

final class APIManagerTests: XCTestCase {

private var gamificationAPIManager: APIManager!
    
    override func setUp() {
        super.setUp()
        let forceClient = GamificationForceClient(auth: MockAuthenticator.sharedMock, forceNetworkManager: MockNetworkManager.sharedMock)

        
        gamificationAPIManager = APIManager(auth: MockAuthenticator.sharedMock,
                                       instanceURL:"https://instanceUrl",
                                       forceClient: forceClient)
        MockNetworkManager.sharedMock.statusCode = 200
        
    }
    
    override func tearDown() {
        gamificationAPIManager = nil
        super.tearDown()
    }
        
    func testGetGames() async throws {
        let identity = try await gamificationAPIManager.getGames(participantId: "123")

        XCTAssertNotNil(identity)
        XCTAssertEqual(identity.status, true)
        XCTAssertEqual(identity.gameDefinitions.count, 4)
   
        let devIdentity = try await gamificationAPIManager.getGames(participantId: "123", devMode: true)


        XCTAssertNotNil(devIdentity)
        XCTAssertEqual(identity.status, true)
        XCTAssertEqual(identity.gameDefinitions.count, 4)
        
        // Handle authentication failed scenrio
        MockNetworkManager.sharedMock.statusCode = 401
        do {
            _ = try await gamificationAPIManager.getGames(participantId: "123")
        } catch {
            guard let commonError = error as? CommonError else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(commonError, CommonError.authenticationNeeded)
        }
    }
    
    func testPlayGames() async throws {
        let identity = try await gamificationAPIManager.playGame(gameParticipantRewardId: "123")

        XCTAssertNotNil(identity)
   
        let devIdentity = try await gamificationAPIManager.playGame(gameParticipantRewardId: "123", devMode: true)


        XCTAssertNotNil(devIdentity)
        
        // Handle authentication failed scenrio
        MockNetworkManager.sharedMock.statusCode = 401
        do {
            _ = try await gamificationAPIManager.playGame(gameParticipantRewardId: "123")
        } catch {
            guard let commonError = error as? CommonError else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(commonError, CommonError.authenticationNeeded)
        }
    }

}
