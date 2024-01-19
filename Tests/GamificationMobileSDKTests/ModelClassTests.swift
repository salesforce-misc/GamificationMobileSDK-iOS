/*
 * Copyright (c) 2023, Salesforce, Inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import XCTest
@testable import GamificationMobileSDK

final class ModelClassTests: XCTestCase {
    
    func testgetGameModel() throws {
        
        let activeGame = GameDefinition(name: "Barney and Clyde Style Promotion",
                                        gameDefinitionId: "1",
                                        description: "",
                                        type: .spinaWheel,
                                        startDate: Date(),
                                        endDate: nil,
                                        timeoutDuration: 10,
                                        gameRewards: [],
                                        participantGameRewards: [])
        let gameModel = GameModel(message: "Success", status: true, gameDefinitions: [activeGame])
        XCTAssertEqual(gameModel.gameDefinitions.first?.name, "Barney and Clyde Style Promotion")
    }

}
