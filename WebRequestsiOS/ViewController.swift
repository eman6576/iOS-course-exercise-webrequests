//
//  ViewController.swift
//  WebRequestsiOS
//
//  Created by Emanuel  Guerrero on 3/15/16.
//  Copyright © 2016 Project Omicron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://swapi.co/api/people/1/"
        let url = NSURL(string: urlString)!
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let responseData = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dictionary = json as? Dictionary<String, AnyObject> {
                        
                        if let name = dictionary["name"] as? String, let height = dictionary["height"] as? String, let birth = dictionary["birth_year"] as? String, let hair = dictionary["hair_color"] as? String {
                            
                            let person = SWPerson(name: name, height: height, birthYear: birth, hairColor: hair)
                            print(person.name)
                            print(person.height)
                            print(person.hairColor)
                            print(person.birthYear)
                            
                            if let flims = dictionary["films"] as? [String] {
                                for film in flims {
                                    print(film)
                                }
                            }
                        }
                    }
                } catch {
                    print("Could not serialize")
                }
            }
        }.resume()
    }
}

