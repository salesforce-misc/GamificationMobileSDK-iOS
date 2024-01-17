/*
 * Copyright (c) 2023, Salesforce, Inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import XCTest
@testable import GamificationMobileSDK

final class ForceClientTests: XCTestCase {
    private var forceClient: GamificationForceClient!

    override func setUp() {
        forceClient = GamificationForceClient(auth: MockAuthenticator.sharedMock, forceNetworkManager: MockNetworkManager.sharedMock)

        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        forceClient = nil
    }
    
    func getMockRequest() async throws -> URLRequest {
        
        let path = "game/participant/1234/games"
        let request = try  GamificationForceRequest.create(instanceURL: "https://instanceUrl", path: path, method: "GET")
        return request
    }
    
    func testFetchLocalJson() async throws {
        let result = try forceClient.fetchLocalJson(type: GameModel.self, file: "GetGames_Success", bundle: Bundle.module)
        XCTAssertEqual(result.status, true)
        XCTAssertEqual(result.gameDefinitions.count, 4)
        XCTAssertNil(result.message)
        
        do {
            _ = try forceClient.fetchLocalJson(type: GameModel.self, file: "GetGames_Success", bundle: Bundle.main)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testServerFetch() async throws {
        let data = try XCTestCase.load(resource: "GetGames_Success")
        let mockSession = URLSession.mock(responseBody: data, statusCode: 200)
        let gameDefinitions = try await forceClient.fetch(type: GameModel.self, with: getMockRequest(), urlSession: mockSession)
        XCTAssertEqual(gameDefinitions.status, true)
        XCTAssertEqual(gameDefinitions.gameDefinitions.count, 4)
        XCTAssertNil(gameDefinitions.message)
    }
    
    func testFetch() async throws {

        let data = try XCTestCase.load(resource: "GetGames_Success")
        let mockSession = URLSession.mock(responseBody: data, statusCode: 200)

        MockAuthenticator.sharedMock.needToThrowError = true
        // Handle authentication failed scenrio
        do {
            let gamesWithAuthFlow = try await forceClient.fetch(type: GameModel.self, with: getMockRequest(), urlSession: mockSession)
            XCTAssertEqual(gamesWithAuthFlow.status, true)
        } catch {
            guard let commonError = error as? CommonError else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(commonError, CommonError.authenticationNeeded)
        }
        
        MockAuthenticator.sharedMock.needToThrowError = false
        
        MockNetworkManager.sharedMock.statusCode = 401
        var mockSessionWithError = URLSession.mock(responseBody: data, statusCode: 401)
        // Handle authentication failed scenrio
        do {
            let gamesWithAuthFlow = try await forceClient.fetch(type: GameModel.self, with: getMockRequest(), urlSession: mockSessionWithError)
            XCTAssertEqual(gamesWithAuthFlow.status, true)
        } catch {
            guard let commonError = error as? CommonError else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(commonError, CommonError.authenticationNeeded)
        }
        
        MockNetworkManager.sharedMock.statusCode = 403
        mockSessionWithError = URLSession.mock(responseBody: data, statusCode: 403)
        // Handle other error failed scenrio
        do {
            let gamesWithAuthFlow = try await forceClient.fetch(type: GameModel.self, with: getMockRequest(), urlSession: mockSessionWithError)
            XCTAssertEqual(gamesWithAuthFlow.status, true)
        } catch {
            guard let commonError = error as? CommonError else {
                XCTFail("Unexpected error type: \(error)")
                return
            }
            XCTAssertEqual(commonError, CommonError.functionalityNotEnabled)
        }

    }
}
