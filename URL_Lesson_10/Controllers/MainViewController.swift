//
//  MainViewController.swift
//  URL_Lesson_10
//
//  Created by Valerii D on 22.06.2021.
//

import UIKit

enum UserActons: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
    case postRequest = "POST Request"
}

class MainViewController: UICollectionViewController {

    private let userActions = UserActons.allCases

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! UserActionCell
    
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: nil)
        case .exampleOne:
            performSegue(withIdentifier: "ExampleOne", sender: nil)
        case .exampleTwo:
            performSegue(withIdentifier: "ExampleTwo", sender: nil)
        case .exampleThree:
            performSegue(withIdentifier: "ExampleThree", sender: nil)
        case .exampleFour:
            performSegue(withIdentifier: "ExampleFour", sender: nil)
        case .ourCourses:
            performSegue(withIdentifier: "OurCourses", sender: nil)
        case .postRequest:
            postRequest()
        }
    }
    
//MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "ShowImage" {
            let coursesVC = segue.destination as! CoursesViewController
            
            switch segue.identifier {
            case "ExampleOne":
                coursesVC.fetchDataV1()
            case "ExampleTwo":
                coursesVC.fetchDataV2()
            case "ExampleThree":
                coursesVC.fetchDataV3()
            case "ExampleFour":
                coursesVC.fetchDataV4()
            case "OurCourses":
                coursesVC.fetchDataV5()
            default:
                break
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

extension MainViewController {
    private func postRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData = [ "course" : "Networking",
                         "lesson" : "GET and POST"]  // словарь который будет передавать
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }  // создаем из словаря тело запроса
        
        var request = URLRequest(url: url)          // создаем URLRequest (запрос)
        request.httpMethod = "POST"
        request.addValue("aplication/json", forHTTPHeaderField: "Content-tipe")
        request.httpBody = httpBody                 // присваиваем запросу отконвертированные данные
        
        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let response = response, let data = data else { return }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
