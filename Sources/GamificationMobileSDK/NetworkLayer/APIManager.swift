/*
 * Copyright (c) 2023, Salesforce, Inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

import Foundation

/// A class for managing requests related to loyalty programs using the Force API.
public class APIManager {
    
    /// An instance of `ForceAuthenticator` for authentication
    public var auth: GamificationForceAuthenticator
    
    
    /// The base URL of the loyalty program API
    public var instanceURL: String
    
    /// An instance of `ForceClient` to handle API requests
    private var forceClient: GamificationForceClient
    
    /// Initializes a `LoyaltyAPIManager` with the necessary parameters.
    public init(auth: GamificationForceAuthenticator, instanceURL: String, forceClient: GamificationForceClient) {
        self.auth = auth
        self.instanceURL = instanceURL
        self.forceClient = forceClient
    }

    /// Enumeration for sorting the results by a specific field.
    public enum SortBy: String {
        case expirationDate
        case effectiveDate
        case createdDate
    }
    
    /// Enumeration for specifying the sort order of the results.
    public enum SortOrder: String {
        case ascending
        case descending
    }
    
    
    /// Enumeration for identifying the type of resource to request.
    public enum Resource {
        case getGames(participantId: String, version: String)
        case playGame(gameParticipantRewardId: String, version: String)

    }
    
    /// Get path for given API resource
    /// - Parameter resource: A ``Resource``
    /// - Returns: A string represents URL path of the resource
    public func getPath(for resource: Resource) -> String {
        
        switch resource {
        case .getGames(participantId: let participantId, version: let version):
            return GamificationForceAPI.path(for: "game/participant/\(participantId)/games", version: version)
        case .playGame(gameParticipantRewardId: let gameParticipantRewardId, version: let version):
            return GamificationForceAPI.path(for: "game/gameParticipantReward/\(gameParticipantRewardId)/game-reward", version: version)
        }
    }
    
    /// Get Games information for the loyalty member
    /// - Parameters:
    ///   - membershipId: The membership number of the loyalty program member whose issued avialbele games are retrieved.
    ///   - version: The API version number
    ///   - devMode: Whether it's in devMode
    /// - Returns: A ``GameModel`` object
    public func getGames(
           participantId: String,
           version: String = APIVersion.defaultVersion,
           devMode: Bool = false,
           mockFileName: String = "GetGames_Success"
       ) async throws -> GameModel {
           do {
               if devMode {
                   let result = try forceClient.fetchLocalJson(type: GameModel.self, file: mockFileName)
                   return result
               }
               let path = getPath(for: .getGames(participantId: participantId, version: version))
               let request = try GamificationForceRequest.create(instanceURL: instanceURL, path: path, method: "GET")
               let result = try await forceClient.fetch(type: GameModel.self, with: request)
               return result
           } catch {
               GamificationLogger.error(error.localizedDescription)
               throw error
           }
       }
    
    /// Play Game information for the loyalty member
    /// - Parameters:
    ///   - gameParticipantRewardId: The game of the reward that participant has recieved for playing the game.
    ///   - version: The API version number
    ///   - devMode: Whether it's in devMode
    /// - Returns: A ``PlayGameModel`` object
    public func playGame(
           gameParticipantRewardId: String,
           version: String = APIVersion.defaultVersion,
           devMode: Bool = false,
           mockFileName: String = "PlayGame_Success"
       ) async throws -> PlayGameModel {
           do {
               if devMode {
                   try await Task.sleep(nanoseconds: 1_000_000_000)
                   let result = try forceClient.fetchLocalJson(type: PlayGameModel.self, file: mockFileName)
                   return result
               }
               let path = getPath(for: .playGame(gameParticipantRewardId: gameParticipantRewardId, version: version))
               let request = try GamificationForceRequest.create(instanceURL: instanceURL, path: path, method: "GET")
               let result = try await forceClient.fetch(type: PlayGameModel.self, with: request)
               return result
           } catch {
               GamificationLogger.error(error.localizedDescription)
               throw error
           }
       }
    
    public func getGame(
        participantId: String,
        gameParticipantRewardId: String,
        version: String = APIVersion.defaultVersion,
        devMode: Bool = false,
        mockFileName: String = "GetGames_Success"
    ) async throws -> GameDefinition? {
        do {
            if devMode {
                let result = try forceClient.fetchLocalJson(type: GameModel.self, file: mockFileName)
                return result.gameDefinitions.first
            }
            let path = getPath(for: .getGames(participantId: participantId, version: version))
            let queryItems = ["gameParticipantRewardId": gameParticipantRewardId]
            let request = try GamificationForceRequest.create(instanceURL: instanceURL, path: path, method: "GET", queryItems: queryItems)
            let result = try await forceClient.fetch(type: GameModel.self, with: request)
            return result.gameDefinitions.first
        } catch {
            GamificationLogger.error(error.localizedDescription)
            throw error
        }
    }
}
