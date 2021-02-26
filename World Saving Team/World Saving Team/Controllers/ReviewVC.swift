//
//  ReviewVC.swift
//  World Saving Team
//
//  Created by Nikita Entin on 19.02.2021.
//

import UIKit
import CoreData

class ReviewVC: UIViewController {
    
    
    var teams = [Team]()
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        saveData()
        loadData()
    }
    
    @IBAction func backToMain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}


extension ReviewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        for i in teams {
            return i.teamName
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        teams.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in teams {
            return i.heroes?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        for i in teams.indices {
            cell.textLabel?.text = teams[i].heroes?[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        for currentTeam in teams {
            let currentHero = currentTeam.heroes?[indexPath.row]
            detailVC.hero = currentHero!
        }
        show(detailVC, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ReviewVC {
    
    private func saveData() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    private func loadData() {
        let request: NSFetchRequest<Team> = Team.fetchRequest()

        do {
            teams = try context.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
}
