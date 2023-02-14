//
//  String.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/14.
//

import Foundation

extension String {
    func toChampImgURL() -> URL? {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/13.1.1/img/champion/\(self).png")
    }
    func toBackgroundChampImgURL() -> URL? {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(self)_0.jpg")
    }
}
