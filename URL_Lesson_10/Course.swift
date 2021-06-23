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
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct WebsiteDescription: Decodable {
    let course: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
