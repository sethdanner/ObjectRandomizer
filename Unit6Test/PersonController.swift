//
//  PersonController.swift
//  Unit6Test
//
//  Created by Seth Danner on 7/2/18.
//  Copyright © 2018 Seth Danner. All rights reserved.
//

import Foundation
import GameKit

class PersonController {
    
    // MARK: Properties
    static let shared = PersonController()
    var numberOfPairs = 1
    
    var people: [Person] = [] {
        didSet {
            makePairs()
        }
    }
    
    var arrayforSections: [[Person]] = []
    
//    init() {
//        people = load()
//    }
    
    func randomizePeople() {
        
        people = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: people) as! [Person]
    }
    
    func makePairs() {
        var arrayOfPeople: [Person] = []
        
        var arrayOfPeopleGrouped: [[Person]] = []
        
        for person in people {
            
            if arrayOfPeople.count <= 1 {
                arrayOfPeople.append(person)
            }
            else {
                arrayOfPeopleGrouped.append(arrayOfPeople)
                let newPairOfPeople: [Person] = []
                numberOfPairs += 1
                arrayOfPeople = newPairOfPeople
                arrayOfPeople.append(person)
            }
        }
        
        arrayOfPeopleGrouped.append(arrayOfPeople)
        arrayforSections = arrayOfPeopleGrouped
    }
    
    // MARK: CRUD/Persistence
    func addPerson(with name: String) {
        let newPerson = Person(name: name)
        people.append(newPerson)
        save()
        
    }
    
    func deletePerson(person: Person) {
        
        guard let indexPath = people.index(of: person) else { return }
        people.remove(at: indexPath)
        save()
    }
    
    func fileURL() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullURL = path.appendingPathComponent("person").appendingPathExtension("json")
        return fullURL
    }
    
    func save() {
        let jssonEncoder = JSONEncoder()
        do {
            let data = try jssonEncoder.encode(people)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving \(error)")
        }
    }
    
    func load() -> [Person] {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let people = try jsonDecoder.decode([Person].self, from: data)
            return people
        } catch let error {
            print(error.localizedDescription)
        }
        return []
        
    }
}
