//
//  ViewController.swift
//  AIMeng
//
//  Created by Iryna Piskorska
//

import UIKit
import FirebaseAuth
import SnapKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    let imgLogo: UIImageView = {
       let imgLogo = UIImageView()
        imgLogo.image = UIImage(named: "logo-white")
        imgLogo.contentMode = .scaleAspectFit
        return imgLogo
    }()
    
    let loginView = UIView()
    let loginFieldsView = UIView()
    var viewModel: LoginViewModel
    
    let txtFieldEmail = AimTextField(placeholderText: "login_txtfield_email".localized)
    let txtFieldPassword = AimTextField(isSecure: true ,placeholderText: "login_txtfield_password".localized)
    let btnLogin = AimButton(title: "login_btn".localized)
    let lblError = AimLabel(style: .small, labelText: "")
    
    let lblOrView = UIView()
    let lblOrDividerLeft = UIView()
    let lblOr = AimLabel(style: .small, labelText: "login_lbl_divider".localized)
    let lblOrDividerRight = UIView()
    
    // use biometrics button
    
    let btnBioView = UIView()
    let btnBioImage: UIImageView = {
        let btnBioImage = UIImageView()
        btnBioImage.image = UIImage(named: "touchID")
        return btnBioImage
    }()
    
    let btnBioLabel: UILabel = {
        let btnBioLabel = UILabel()
        btnBioLabel.text = "Use Biometrics"
        return btnBioLabel
    }()
    
    var btnBio: UIButton = {
        let btnBio = UIButton()
        return btnBio
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        view.backgroundColor = Constants.Color.primaryColor
        view.addSubview(imgLogo)
        loginView.backgroundColor = .white
        loginView.layer.cornerRadius = 50
        loginFieldsView.clipsToBounds = true
        
        loginView.addSubview(loginFieldsView)
        loginFieldsView.addSubview(txtFieldEmail)
        loginFieldsView.addSubview(txtFieldPassword)
        loginFieldsView.addSubview(btnLogin)
        loginFieldsView.addSubview(lblError)
        
        loginFieldsView.addSubview(lblOrView)
        lblOrView.addSubview(lblOrDividerLeft)
        lblOrView.addSubview(lblOr)
        lblOrView.addSubview(lblOrDividerRight)
        lblOrDividerLeft.backgroundColor = Constants.Color.secondaryColor
        lblOrDividerRight.backgroundColor = Constants.Color.secondaryColor
        
        loginFieldsView.addSubview(btnBioView)
        btnBioView.addSubview(btnBioImage)
        btnBioView.addSubview(btnBioLabel)
        btnBioView.addSubview(btnBio)
        
        view.addSubview(loginView)
        
        btnLogin.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        btnBio.addTarget(self, action: #selector(didTapBioButton), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            print("already signed in")
        }
        //lblError.alpha = 0
        lblError.text = "for test purposes: email: test@test.pl | password: testpl"
        
        imgLogo.snp.makeConstraints{ (make) in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        loginView.snp.makeConstraints{ (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        
        loginFieldsView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
        }
        
        txtFieldEmail.snp.makeConstraints{ (make) in
            make.height.equalTo(44)
            make.top.left.right.equalToSuperview()
        }
        
        txtFieldPassword.snp.makeConstraints{ (make) in
            make.height.equalTo(44)
            make.left.right.equalToSuperview()
            make.top.equalTo(txtFieldEmail.snp.bottom).offset(44)
        }
        
        lblError.snp.makeConstraints{ (make) in
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(txtFieldPassword.snp.bottom).offset(24)
        }
        
        btnLogin.snp.makeConstraints{ (make) in
            make.height.equalTo(44)
            make.left.right.equalToSuperview()
            make.top.equalTo(lblError.snp.bottom).offset(24)
        }
        
        lblOrView.snp.makeConstraints{ (make) in
            make.height.equalTo(44)
            make.left.right.equalToSuperview()
            make.top.equalTo(btnLogin.snp.bottom).offset(24)
        }
        
        lblOrDividerLeft.snp.makeConstraints{ (make) in
            make.height.equalTo(2)
            make.left.centerY.equalToSuperview()
            make.right.equalTo(lblOr.snp.left).offset(-16)
        }
        
        lblOrDividerRight.snp.makeConstraints{ (make) in
            make.height.equalTo(2)
            make.right.centerY.equalToSuperview()
            make.left.equalTo(lblOr.snp.right).offset(16)
        }
        
        lblOr.snp.makeConstraints{ (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        btnBioView.snp.makeConstraints{ (make) in
            make.top.equalTo(lblOrView.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
            make.width.equalTo(150)
        }
        
        btnBioImage.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.height.width.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        btnBioLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(btnBioImage.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        btnBio.snp.makeConstraints{ (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        
    }
    
    @objc private func didTapLoginButton() {
        guard let emailRaw = txtFieldEmail.txtField.text,
              let passwordRaw = txtFieldPassword.txtField.text
        else { return }
        
        let email = emailRaw.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordRaw.trimmingCharacters(in: .whitespacesAndNewlines)
        
        viewModel.firebaseAuth(email: email, password: password)
    }
    
    @objc private func didTapBioButton(_ sender: Any) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self?.viewModel.biometricsAuth()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}

extension LoginViewController: LoginViewModelViewDelegate {
    func didFailedLogin(error: String) {
        self.lblError.text = error
        self.lblError.alpha = 1
    }
}
