//
//  File.swift
//  JustMusic-Demo
//
//  Created by админ on 24.01.2023.
//
struct Song {
    
    let title: String
    let album: String
    let artist: String
    let cover: String
    let trackName: String
    
    static func createList() -> [Song] {
        [
            .init(title: "Limitless",
                  album: "None",
                  artist: "BaloonPlanet",
                  cover: "BalloonPanet",
                  trackName: "BalloonPlanet - Limitless"),
            .init(title: "Its Going Down - No Lead Vocals",
                  album: "New",
                  artist: "SOURWAH",
                  cover: "SOURWAH",
                  trackName: "SOURWAH - Its Going Down - No Lead Vocals"),
            .init(title:"The Last Hero",
                  album: "Best",
                  artist: "Veaceslav Draganov",
                  cover: "Veaceslav Draganov",
                  trackName: "Veaceslav Draganov - The Last Hero")
        ]
    }
    
}
