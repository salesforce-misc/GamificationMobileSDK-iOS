# Save Time and Effort With Gamification Mobile SDK for iOS

Experience Gamification on your iOS mobile devices and use the mobile software development kit’s (SDK) capabilities and build custom mobile applications with unique user experiences. Use pre-built Gamification components to build your own apps or enhance your existing mobile apps. Build the SDK for your loyalty program members to view their assigned games, play games. sample app which is embedded with Gamification features.

**Where:** This feature is available in Lightning Experience in all editions.  
**How:** Install the Gamification Mobile SDK for iOS, create a connected app, and then clone the GitHub repository.

## iOS Mobile SDK for Gamification

Enhance brand engagement by providing Gamification features on your iOS mobile devices. Use the iOS Mobile Software Development Kit (SDK) for Gamification to build custom mobile applications with immersive member experiences. Elevate member experience and loyalty, by providing personalized offers, rewards, and checkouts on mobile devices.

### Supported Versions of Tools and Components

| Tool or Component     | Supported Version | Installation Details          |
|-----------------------|-------------------|-------------------------------|
| Swift Version         | 5.7+              | Installed by Xcode            |
| Xcode                 | 14.0+             | Install from the App Store    |
| iOS SDK               | 15.0+             | Installed by Xcode            |
| Swift Package Manager | 5.7+              | Included in Swift             |

### Installation

To integrate Gamification for iOS with your Xcode project, add it as a package dependency.

1. With your app project open in Xcode, select **File** → **Swift Packages** → **Add Package Dependency**.
2. Enter the repository URL: `https://github.com/loyaltysampleapp/GamificationMobileSDK-iOS`
3. Select a version, and click **Add Package**.

## Import SDK in an iOS Swift Project

Automatically download and manage external dependencies. To import  Gamification Mobile SDK for iOS, open the swift file where you want to save GamificationMobileSDK, and to the first line of code, add:

```swift
import GamificationMobileSDK
```

## GamificationForceSwift

GamificationForceSwift is a library that uses SwiftUI to build user interfaces in iOS apps while interacting with Salesforce. GamificationForceSwift provides tools, structures, classes, and utilities that make it easier to perform common operations, such as authentication and network requests. Key components of ForceSwift include:

- `GamificationForceAPI` - A struct that generates the path for API endpoints, based on the API name and version.
- `GamificationForceAuthenticator` - A  protocol that defines the required methods for handling access tokens in Salesforce API.
- `GamificationForceClient` - A class that handles network requests with authentication by using `ForceAuthenticator`. This class provides methods to fetch data from Salesforce API or a local JSON file. 
- `GamificationForceRequest` - A struct to help create and configure URLRequest instances. It provides utility functions to create requests with a URL, add query parameters, and set authorization.
- `NetworkManagerProtocol` - A protocol that defines the requirements for a network manager.
- `NetworkManager` - A class that handles network requests and data processing. This class conforms to the NetworkManagerProtocol and provides a method to fetch and decode the data into the specified type.

## APIManager

The `APIManager` class manages requests related to loyalty programs using the GamificationForce API. Interact with the Salesforce Gamification API and retrieve member games and playgame, in development and production environments. With APIManager, you can:
- Manage authentication by creating an instance of ForceAuthenticator.
- Interact with the Gamification APIs, including:
    - Get Games
    - Play Game

- Support both live API calls and local JSON file fetch for development mode.
- Manage asynchronous requests by using Swift Aync/Await syntax.

### Usage
1. In order to use the SDK, you need to provide a valid `accessToken` to interact with Salesforce API. To do this, you are required to conform and implement [`GamificationForceAuthenticator`](./Sources/GamificationMobileSDK/ForceSwift/GamificationForceAuthenticator.swift) protocol which we provided in the SDK.

2. Create an instance of `GamificationForceClient` with the necessary parameters:

```swift
let authManager = GamificationForceAuthenticator.shared
let forceClient = GamificationForceClient(auth: authManager)
```

3. Create an instance of `APIManager` with the necessary parameters:

```swift
let gamificationAPIManager = APIManager(auth: authManager, instanceURL: "YourInstanceURL", forceClient: forceClient)
```

4. Call the appropriate methods to interact with the Gamification API:

```swift
import GamificationMobileSDK

let instanceURL = URL(string: "https://your_salesforce_instance_url")!
let authManager = GamificationForceAuthenticator.shared
let forceClient = GamificationForceClient(auth: authManager)

let gamificationAPIManager = APIManager(auth: authManager,
                                        instanceURL: instanceURL,
                                        forceClient: forceClient)


// Retrieve getGames for a member
    let result = try await gamificationAPIManager.getGames(participantId: "1234567890")
// Retrieve the played game reward for a member
    let result = try await gamificationAPIManager.playGame(gameParticipantRewardId: gameParticipantRewardId)

```

For a detailed understanding of each method and its parameters, please refer to the comments in the provided `APIManager` code.

## Contribute to the SDK

You can contribute to the development of the GamificationMobileSDK. 
1. Fork the GamificationMobileSDK for iOS [repository](https://github.com/loyaltysampleapp/GamificationMobileSDK-iOS).
2. Create a branch with a descriptive name.
3. Implement your changes.
4. Test your changes.
5. Submit a pull request.

See also:
[Fork a repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo)

## License

GamificationMobileSDK-iOS is available under the BSD 3-Clause License.

Copyright (c) 2023, Salesforce Industries
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
