//
//  EntranceVC.swift
//  WorkingServices
//
//  Created by Illya Gurkov on 4.10.22.
//

import UIKit
import FirebaseAuth
class EntranceVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var enter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
setUpElements()
    }
    
    
    
    @IBAction func enterAction(_ sender: UIButton) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            if error != nil {
                self.lbl.text = error!.localizedDescription
                self.lbl.alpha = 1
            } else {  let ordersVC = self.storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.OrdersVC) as? OrdersVC
                self.view.window?.rootViewController = ordersVC
                self.view.window?.makeKeyAndVisible()
                
            }
        }
    }
    
    
    
    func setUpElements() {
        lbl.alpha = 0
       
    }
}
