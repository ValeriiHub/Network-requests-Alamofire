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
    let numberOfLessons: String?
    let numberOfTests: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case link = "Link"
        case imageUrl = "ImageUrl"
        case numberOfLessons = "Number_of_lessons"
        case numberOfTests = "Number_of_tests"
    }
    
    init(dictCourse: [String : Any]) {
        name = dictCourse["name"] as? String
        link = dictCourse["link"] as? String
        imageUrl = dictCourse["imageUrl"] as? String
        numberOfLessons = dictCourse["number_of_lessons"] as? String
        numberOfTests = dictCourse["number_of_tests"] as? String
    }
    
    static func getCourses(from jsonData: Any) -> [Course] {
        guard let jsonData = jsonData as? Array<[String : Any]> else { return [] }
        
//        var courses: [Course] = []
//
//        for dictCourse in jsonData {
//            let course = Course(dictCourse: dictCourse)
//            courses.append(course)
//        }
//        return courses
        return jsonData.compactMap { Course(dictCourse: $0) }
    }
}

struct WebsiteDescription: Decodable {
    let course: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
