//
// Copyright 2023, 2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

import Foundation

extension UserProfileProxy {
    // Mocks
    static var mockAlice: UserProfileProxy {
        .init(userID: "@alice:matrix.pesbc.chat", displayName: "Alice", avatarURL: "mxc://matrix.pesbc.chat/UcCimidcvpFvWkPzvjXMQPHA")
    }

    static var mockBob: UserProfileProxy {
        .init(userID: "@bob:matrix.pesbc.chat", displayName: "Bob", avatarURL: nil)
    }

    static var mockBobby: UserProfileProxy {
        .init(userID: "@bobby:matrix.pesbc.chat", displayName: "Bobby", avatarURL: nil)
    }

    static var mockCharlie: UserProfileProxy {
        .init(userID: "@charlie:matrix.pesbc.chat", displayName: "Charlie", avatarURL: nil)
    }
    
    static var mockVerbose: UserProfileProxy {
        .init(userID: "@charlie:matrix.pesbc.chat", displayName: "Charlie is the best display name", avatarURL: nil)
    }
}
