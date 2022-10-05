//
//  RegistrationVC.swift
//  WorkingServices
//
//  Created by Illya Gurkov on 4.10.22.
//

import UIKit
import FirebaseAuth
import Firebase
class RegistrationVC: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var errorLBL: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var registration: UIButton!
    
    @IBOutlet weak var entrance: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    func setUpElements() {
        errorLBL.alpha = 0
       
    }
    
    func validateFiields() -> String? {
      
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Заполните все поля!!!"
        }
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if ValidPassword.isPasswordValid(cleanedPassword) == false {
            return "Не надежный пароль"
        }
        
        return nil
    }

    @IBAction func registrationAction(_ sender: UIButton) {
        let error = validateFiields()
        if error != nil{
            showError(error!)
        } else {
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let name = nameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil{
                    self.showError("Ошибка при создании пользователя")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["email" : email, name : name, "uid" : result!.user.uid]) {(error) in
                        if error != nil {
                            self.showError("Ошибка при сохранении пользовательских данных")
                        }
                    }
                    self.transitionToHoma()
            }
                
            }
        }
    }
    func showError(_ message: String) {
        errorLBL.text = message
        errorLBL.alpha = 1
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func transitionToHoma() {
        let ordersVC = storyboard?.instantiateViewController(withIdentifier: Constans.Storyboard.OrdersVC) as? OrdersVC
        view.window?.rootViewController = ordersVC
        view.window?.makeKeyAndVisible()
    }

}
