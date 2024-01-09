//
//  ModelClassTests.swift
//  
//
//  Created by Anandhakrishnan Kanagaraj on 05/05/23.
//

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
