//
//  CoursesViewController.swift
//  URL_Lesson_10
//
//  Created by Valerii D on 22.06.2021.
//

import UIKit

class CoursesViewController: UITableViewController {

    private let jsonUrlOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    private let jsonUrlTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    private let jsonUrlThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    private let jsonUrlFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    
    private var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!CourseCell

        let course = courses[indexPath.row]
        cell.configure(with: course)
 
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func fetchDataV1() {
        guard let url = URL(string: jsonUrlOne) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name ?? "")
                print(course.imageUrl ?? "")
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchDataV2() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                print(courses)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    func fetchDataV3() {
        guard let url = URL(string: jsonUrlThree) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription.course ?? [])
                print(websiteDescription.websiteDescription ?? "")
                print(websiteDescription.websiteName ?? "")
            } catch let error {
                print(error)
            }
        }.resume()
    }
    func fetchDataV4() {
        guard let url = URL(string: jsonUrlFour) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(websiteDescription.course ?? [])
                print(websiteDescription.websiteDescription ?? "nil")
                print(websiteDescription.websiteName ?? "nil")
            } catch let error {
                print(error)
            }
        }.resume()
    }
    func fetchDataV5() {
        guard let url = URL(string: jsonUrlTwo) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
