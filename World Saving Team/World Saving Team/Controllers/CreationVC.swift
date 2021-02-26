//
//  CreationVC.swift
//  World Saving Team
//
//  Created by Nikita Entin on 19.02.2021.
//

import UIKit
import CoreData


class CreationVC: UIViewController {
    
    private var team = Team(entity: NSEntityDescription.entity(forEntityName: "Team", in: context)!, insertInto: context)
   private var hero = Hero()

    
    private var networkManager = NetworkManager()
    private let items = ["Book", "Cape", "Spear", "Phone", "Earphones", "Laptop", "Socks", "Knife", "Pen", "Mug", "Cigar", "Jewelry", "Blanket", "Towel", "", "Ice Cream", "Bubble", "Disk", "Beer", "Cola"]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var leaderButton: UIButton! {
        didSet {
            leaderButton.tintColor = .red
        }
    }
    
    private var pageIndex = 0
    var numberOfHeroes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderButton.isEnabled = true
        leaderButton.layer.cornerRadius = 5
        firstTF.layer.cornerRadius = 5
        secondTF.layer.cornerRadius = 5
        thirdTF.layer.cornerRadius = 5
        updateUI()
        appDelegate.saveContext()
        
        networkManager.onCompletion = { currentHero in
            self.hero.name = currentHero.author
            self.hero.phrase = currentHero.quote
        }
        networkManager.parseData()
    }
    
    
    @IBAction func previousPageButton(_ sender: Any) {
        if pageIndex > 0 {
            saveParameters()
            pageIndex -= 1
            updateUI()
        }
    }
    
    @IBAction func nextPageButton(_ sender: Any) {
        saveParameters()
        pageIndex += 1
        updateUI()
        if pageIndex > numberOfHeroes {
            let reviewVC = storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewVC
            reviewVC.teams += [team]
            navigationController?.pushViewController(reviewVC, animated: true)
        }
        
    }
    
    @IBAction func makeRandom(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.firstTF.text = self.hero.name
            self.secondTF.text = self.hero.phrase
            self.thirdTF.text = self.items.randomElement()?.capitalized
        }
        networkManager.parseData()
    }
    
    @IBAction func makeLeader(_ sender: Any) {
        leaderButton.isSelected = !leaderButton.isSelected
        leaderButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        leaderButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    
}

extension CreationVC {
    
    private func updateUI() {
        switch pageIndex {
        case .zero:
            titleLabel.text = "Придумайте название команды"
            firstTF.placeholder = "Название команды"
            secondTF.isHidden = true
            thirdTF.isHidden = true
            randomButton.isHidden = true
            leaderButton.isHidden = true
        case (1...numberOfHeroes):
            titleLabel.text = "Создайте героя № \(pageIndex)"
            secondTF.isHidden = false
            thirdTF.isHidden = false
            randomButton.isHidden = false
            leaderButton.isHidden = false
            firstTF.placeholder = "Имя героя"
            secondTF.placeholder = "Фраза героя"
            thirdTF.placeholder = "Снаряжение героя"
        default:
            break
        }
        refreshTF()
    }
    
    private func refreshTF() {
        firstTF.text = ""
        secondTF.text = ""
        thirdTF.text = ""
    }
    
    private func saveParameters() {
        switch pageIndex {
        case 0:
            team.teamName = firstTF.text
        case 1...numberOfHeroes:
            team.heroes?.append(hero)
            team.heroes?[pageIndex - 1].name = firstTF.text!.capitalized
            team.heroes?[pageIndex - 1].phrase = secondTF.text!.capitalized
            team.heroes?[pageIndex - 1].item = thirdTF.text!
            
            if leaderButton.isSelected {
                team.heroes?[pageIndex - 1].isLeader = true
                leaderButton.isSelected = false
                leaderButton.isEnabled = false
            }
        default:
            break
        }
    }
    
}

extension CreationVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}
