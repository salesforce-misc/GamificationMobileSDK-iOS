/*
 * Copyright (c) 2023, Salesforce, Inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import Foundation

// MARK: - PlayGameModel
public struct PlayGameModel: Codable {
    public let message: String?
    public let status: Bool
    public let gameReward: [PlayGameReward]
}

// MARK: - PlayGameReward
public struct PlayGameReward: Codable {
    public let name, rewardType: String
    public let color, description,rewardDefinitionId,gameRewardId: String?
    public let expirationDate: Date?
    public let rewardValue, imageUrl, issuedRewardReference: String?
}
