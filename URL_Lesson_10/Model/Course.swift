//
//  Course.swift
//  URL_Lesson_10
//
//  Created by Valerii D on 22.06.2021.
//

struct Course: Decodable {
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct WebsiteDescription: Decodable {
    let course: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
