/*
 * Copyright (c) 2023, Salesforce, Inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import XCTest
@testable import GamificationMobileSDK

final class ForceRequestTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testRequest() throws {
        let path = "game/participant/1234/games"
        
        do {
            let request = try GamificationForceRequest.create(instanceURL: "https://instanceUrl", path: path, method: "GET")
            XCTAssertNotNil(request)
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testRequestError() throws {
        let path = "game/participant/@1234/games?"
        
        do {
            let request = try GamificationForceRequest.create(instanceURL: "", path: path, method: "GET")
            XCTAssertNil(request)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testUrlTransform() throws {
        
        let queryItems = [
            "response_type": "token",
            "client_id": "1",
            "redirect_uri": "123",
            "prompt": "login consent",
            "display": "touch"
        ]
        do {
            guard let url = URL(string:"https://instanceUrl") else {
                return
            }
            let authURL = try GamificationForceRequest.transform(from:url, add: queryItems)
            XCTAssertNotNil(authURL)
        }
        catch {
            XCTAssertNotNil(error)
        }
        
        do {
            guard let url = URL(string:"https://instanceUrl") else {
                return
            }
            let authURL = try GamificationForceRequest.create(url: url, method: "GET", queryItems: queryItems )
            XCTAssertNotNil(authURL)
        }
        catch {
            XCTAssertNotNil(error)
        }
        
    }


}
