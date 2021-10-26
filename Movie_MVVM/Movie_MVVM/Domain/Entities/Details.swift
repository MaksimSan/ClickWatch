// Details.swift
// Copyright © ClickWatch. All rights reserved.

import Foundation
import RealmSwift

final class Details: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var title = String()
    @objc dynamic var overview = String()
    @objc dynamic var movieID: String?
}
