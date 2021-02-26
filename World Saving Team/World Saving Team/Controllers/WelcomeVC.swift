//
//  WelcomeVC.swift
//  World Saving Team
//
//  Created by Nikita Entin on 19.02.2021.
//

import UIKit

class WelcomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createButton: UIButton! {
        didSet {
            createButton.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var reviewButton: UIButton! {
        didSet {
            reviewButton.layer.cornerRadius = 5
        }
    }
    
    @IBAction func addTeam(_ sender: Any) {
        let creationVC = storyboard?.instantiateViewController(withIdentifier: "create") as! CreationVC
        
            let alert = UIAlertController(title: "Внимание", message: "Укажите не менее 3 героев", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { inputText in
                inputText.placeholder = "Введите кол-во героев"
                inputText.keyboardType = .numberPad
                inputText.delegate = self
            } )
            
            let addAction = UIAlertAction(title: "Добавить", style: .cancel) { (text) in
                creationVC.numberOfHeroes = Int((alert.textFields?.first?.text) ?? "") ?? 0
                if creationVC.numberOfHeroes > 2 {
                    self.show(creationVC, sender: self)
                }
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func reviewTeam(_ sender: UIButton) {
        let reviewVC = storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewVC
        show(reviewVC, sender: nil)
    }
}

