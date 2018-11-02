//
//  DataModel.swift
//  CasechekTest
//
//  Created by Jared Wheeler on 11/1/18.
//  Copyright © 2018 Jared Wheeler. All rights reserved.
//

import Foundation
import CoreData

class DataModel: NSObject {
    
    static let sharedInstance = DataModel()
    private override init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CasechekTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Remote Update Flow
    
    func refreshSiteData() {
        //Doing the network stuff witha raw URLSesh.  Again, would typically architect this into
        //the DataModel and make sure it behaves within an app-wide concurrency model.
        //(Which would include queued network calls, bouncing in and out of CoreData, etc.)
        let session = URLSession.shared
        
        guard let url = URL(string: "https://data.cityofchicago.org/resource/cwig-ma7x.json") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("ZOFvjWYWtHNXQ7Wb0GgJgtzkr", forHTTPHeaderField: "X-App-Token")
        
        session.dataTask(with: request) { (data, response, error) in
            guard let responseData = data else {return}

            //Back up to main for CoreData/UIView work
            DispatchQueue.main.async {
                self.update(siteData:responseData)
            }
        }.resume()
    }
    
    func update(siteData: Data) {
        //Entry point for a remote sync flow.
        //Close your eyes and picture a caching system with lots of
        //interesting eviction rules, concurrency stunts, etc.
        let moc: NSManagedObjectContext = self.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Site", in: moc) else { return }
        
        do {
            let siteJSON = try JSONSerialization.jsonObject(with: siteData, options: []) as! [[String: Any]]
            for site in siteJSON {
                if let siteName = site["aka_name"] as? String,
                    let siteAddress = site["address"] as? String,
                    let siteCity = site["city"] as? String,
                    let siteDate = site["inspection_date"] as? String,
                    let siteResults = site["results"] as? String {
                        let siteMO = NSManagedObject(entity: entity, insertInto: moc) as! Site
                        siteMO.name = siteName
                        siteMO.address = siteAddress
                        siteMO.city = siteCity
                        siteMO.date = Formatter.dateFrom(IS08601String: siteDate)
                        siteMO.status = siteResults
                        print(site)
                }
            }
            saveContext()
            
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
    }
}
