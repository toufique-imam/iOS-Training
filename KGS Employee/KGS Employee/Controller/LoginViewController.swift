//
//  ViewController.swift
//  KGS Employee
//
//  Created by Nuhash on 5/19/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
   // @IBOutlet weak var imageViewBack: UIImageView!
    
    var isInit = false
    
    let startColor = UIColor(red: 59.0/255.0, green: 129.0/255.0, blue: 47.0/255.0, alpha: 1)
    let endColor = UIColor(red: 159.0/255.0, green: 197.0/255.0, blue: 38.0/255.0, alpha: 1)
        
    
    @IBOutlet weak var gradientViewTop: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationController()
//        let user = User()
//        user.name = "nuhash"
//        user.password = "123"
//        user.fullName = "toufique imam"
//        user.email = "2013nuhash@gmail.com"
//        user.department = "ios"
//        user.designation = "Jr swe"
//        user.imagePath = "icon_profile"
//        CurrentUser.shared.addUser(user: user)
        
        textFieldPassword.delegate = self
        textFieldUserName.delegate = self
    }
    
    private func initNavigationController(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(!isInit){
            
            self.initializeViews()
            isInit = true
        }

    }
    
    private func gotoHomeViewController(){
        let storyboard = UIStoryboard.init(name: "HomePage", bundle: nil)
        let homepagevc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            homepagevc.modalTransitionStyle = .fullScreen
//          self.present(homepagevc, animated: true)
        self.navigationController?.setViewControllers([homepagevc], animated: true)
    }
    @IBAction func loginAction(_ sender: UIButton) {
        gotoHomeViewController()
        return
        let user = User()
        
        user.name = textFieldUserName.text ?? ""
        user.password = textFieldPassword.text ?? ""
        if(CurrentUser.shared.login(user: user)){
            gotoHomeViewController()
        }else{
            //TODO: show aleat dialogue for incorrect info
        }
    }
    
    private func initializeViews(){
        initTextField()
        initViewForm()
        initGradientView()
        initTextField()
        initLoginButton()
    }
    
    override func viewWillLayoutSubviews() {
        initLoginButton()
    }
    
    
    private func initGradientView(){
        gradientViewTop.addBlackGradientLayerInBackground(frame: gradientViewTop.bounds, colors: [startColor , endColor])
    }
    
    private func initViewForm(){
        viewForm.layer.cornerRadius = 10
        viewForm.dropShadow(color: .lightGray, opacity: 0.5, offset: CGSize(width: 1, height: -1), radius: 20, scale: false)
    }
    
    private func initLoginButton(){
        buttonLogin.dropShadowHalfRounded(color: .lightGray, opacity: 1, offset: CGSize(width: 1, height: -1), radius: 10, scale: false)
        buttonLogin.addBlackGradientLayerInBackground(frame: buttonLogin.bounds, colors: [startColor , endColor] , cornerRadius: 0.5 * buttonLogin.bounds.size.width)

        buttonLogin.layer.cornerRadius =  0.5 * buttonLogin.bounds.size.width
    }

    private func initTextField(){
        textFieldUserName.setLeftIcon(iconName: "icon_username")
        textFieldPassword.setLeftIcon(iconName: "icon_password")
        textFieldPassword.roundBorder()
        textFieldUserName.roundBorder()
    }
}


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == textFieldPassword){
            textField.resignFirstResponder()
        } else {
            textFieldPassword.becomeFirstResponder()
        }
        return true
    }
}
