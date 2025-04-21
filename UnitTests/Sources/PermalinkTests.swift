//
// Copyright 2022-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

@testable import ElementX
import MatrixRustSDK
import XCTest

/// Just for API sanity checking, they're already properly tested in the SDK/Ruma
class PermalinkTests: XCTestCase {
    func testUserIdentifierPermalink() {
        let invalidUserId = "This1sN0tV4lid!@#$%^&*()"
        XCTAssertNil(try? matrixToUserPermalink(userId: invalidUserId))
        
        let validUserId = "@abcdefghijklmnopqrstuvwxyz1234567890._-=/:matrix.pesbc.chat"
        XCTAssertEqual(try? matrixToUserPermalink(userId: validUserId), .some("https://matrix.to/#/@abcdefghijklmnopqrstuvwxyz1234567890._-=%2F:matrix.pesbc.chat"))
    }
    
    func testPermalinkDetection() {
        var url: URL = "https://www.matrix.pesbc.chat"
        XCTAssertNil(parseMatrixEntityFrom(uri: url.absoluteString))
        
        url = "https://matrix.to/#/@bob:matrix.pesbc.chat?via=matrix.pesbc.chat"
        XCTAssertEqual(parseMatrixEntityFrom(uri: url.absoluteString),
                       MatrixEntity(id: .user(id: "@bob:matrix.pesbc.chat"),
                                    via: ["matrix.pesbc.chat"]))
        
        url = "https://matrix.to/#/!roomidentifier:matrix.pesbc.chat?via=matrix.pesbc.chat"
        XCTAssertEqual(parseMatrixEntityFrom(uri: url.absoluteString),
                       MatrixEntity(id: .room(id: "!roomidentifier:matrix.pesbc.chat"),
                                    via: ["matrix.pesbc.chat"]))
        
        url = "https://matrix.to/#/%23roomalias:matrix.pesbc.chat?via=matrix.pesbc.chat"
        XCTAssertEqual(parseMatrixEntityFrom(uri: url.absoluteString),
                       MatrixEntity(id: .roomAlias(alias: "#roomalias:matrix.pesbc.chat"),
                                    via: ["matrix.pesbc.chat"]))
        
        url = "https://matrix.to/#/!roomidentifier:matrix.pesbc.chat/$eventidentifier?via=matrix.pesbc.chat"
        XCTAssertEqual(parseMatrixEntityFrom(uri: url.absoluteString),
                       MatrixEntity(id: .eventOnRoomId(roomId: "!roomidentifier:matrix.pesbc.chat", eventId: "$eventidentifier"),
                                    via: ["matrix.pesbc.chat"]))
        
        url = "https://matrix.to/#/#roomalias:matrix.pesbc.chat/$eventidentifier?via=matrix.pesbc.chat"
        XCTAssertEqual(parseMatrixEntityFrom(uri: url.absoluteString),
                       MatrixEntity(id: .eventOnRoomAlias(alias: "#roomalias:matrix.pesbc.chat", eventId: "$eventidentifier"),
                                    via: ["matrix.pesbc.chat"]))
    }
}
