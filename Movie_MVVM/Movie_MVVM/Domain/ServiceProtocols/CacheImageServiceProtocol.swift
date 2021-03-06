// CacheImageServiceProtocol.swift
// Copyright © ClickWatch. All rights reserved.

import UIKit

protocol CacheImageServiceProtocol {
    func saveImageToCache(posterPath: String, image: UIImage)
    func getImageFromCache(posterPath: String) -> UIImage?
}
