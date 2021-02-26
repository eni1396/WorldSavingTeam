//
//  DetailVC.swift
//  World Saving Team
//
//  Created by Nikita Entin on 24.02.2021.
//

import UIKit

class DetailVC: UITableViewController {
    
    var hero = Hero()

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phraseTF: UITextField!
    @IBOutlet weak var itemTF: UITextField!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    @IBOutlet weak var leaderStatus: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderStatus.tintColor = .red
        
        updateUI()
    }
    
    
    @IBAction func makeLeader(_ sender: Any) {
        hero.isLeader = true
        leaderStatus.image = UIImage(systemName: "star.fill")
    }
    
    @IBAction func editContent(_ sender: Any) {
        let tfArray = [nameTF, phraseTF, itemTF]
        for tf in tfArray {
            tf?.backgroundColor = #colorLiteral(red: 0.9604069192, green: 1, blue: 0.7752690916, alpha: 1)
            tf!.isEnabled = !tf!.isEnabled
            if tf?.isEnabled == false {
                tf?.backgroundColor = .none
            }
        }
        hero.name = nameTF.text!
        hero.phrase = phraseTF.text!
        hero.item = itemTF.text!
    }
    
    private func updateUI() {
         
         nameTF.text = hero.name
         phraseTF.text = hero.phrase
         itemTF.text = hero.item
         leaderStatus.image = UIImage(systemName: "star")
         nameTF.isEnabled = false
         phraseTF.isEnabled = false
         itemTF.isEnabled = false
     }
    
}
