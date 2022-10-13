//
//  LoginViewController.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import UIKit

final class LoginViewController: UIViewController {
   var viewModel: LoginViewModel?
   
   @UsesLayout private var usernameTextField: UITextField = UITextField()
   @UsesLayout private var passwordTextField: UITextField = UITextField()
   @UsesLayout private var loginButton: UIButton = UIButton()
   @UsesLayout private var errorMessage: UILabel = UILabel()
   private var keyboardHeight: CGFloat = CGFloat()
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      viewModel?.userLoginData = UserLoginData()
      setupTextFieldDelegate()
      setupTextFieldTags()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      setupView()
      addKeyboardWillHideNotification()
      addKeyboardWillShowFrameNotification()
   }
   
   // MARK: - PRIVATE METHODS
   private func setupView() {
      loadBackground()
      addUsernameTextField()
      addPasswordTextField()
      addLoginButton()
      setupErrorMessage()
   }
   
   private func loadBackground() {
      @UsesLayout var loginBackground: UIImageView = UIImageView()
      loginBackground.image = UIImage(named: "movieBG")
      view.addSubview(loginBackground)
      NSLayoutConstraint.activate([
         loginBackground.topAnchor.constraint(equalTo: view.topAnchor),
         loginBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         loginBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         loginBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
   }
   
   private func addUsernameTextField() {
      view.addSubview(usernameTextField)
      setCommonAnchorsTo(usernameTextField)
      usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
      setStyleTo(usernameTextField, cornerRadius: 8, placeholder: "Username")
   }
   
   private func addPasswordTextField() {
      view.addSubview(passwordTextField)
      setCommonAnchorsTo(passwordTextField)
      passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20).isActive = true
      setStyleTo(passwordTextField, cornerRadius: 8, placeholder: "Password")
   }
   private func addLoginButton() {
      view.addSubview(loginButton)
      setCommonAnchorsTo(loginButton)
      loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
      loginButton.backgroundColor = .lightGray
      loginButton.setTitle("Log in", for: .normal)
      loginButton.addTarget(self, action: #selector(willSendLoginData), for: .touchUpInside)
   }
   private func setupErrorMessage() {
      view.addSubview(errorMessage)
      NSLayoutConstraint.activate([
         errorMessage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
         errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         errorMessage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
      ])
      errorMessage.textColor = .orange
      errorMessage.font = .systemFont(ofSize: 11, weight: .semibold)
      errorMessage.numberOfLines = .zero
      errorMessage.textAlignment = .center
      errorMessage.isHidden = true
      
   }
   
   private func setStyleTo(_ textField: UITextField, cornerRadius: CGFloat, placeholder: String) {
      textField.layer.cornerRadius = cornerRadius
      textField.backgroundColor = .white
      textField.placeholder = placeholder
      textField.addPadding(.both(8))
   }
   
   private func setCommonAnchorsTo(_ uiView: UIView) {
      NSLayoutConstraint.activate([
         uiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         uiView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
         uiView.heightAnchor.constraint(equalTo: uiView.widthAnchor, multiplier: 0.18)
      ])
   }
   
   private func setupTextFieldDelegate() {
      usernameTextField.delegate = self
      passwordTextField.delegate = self
   }
   
   private func setupTextFieldTags() {
      usernameTextField.tag = TextFieldTag.username.rawValue
      passwordTextField.tag = TextFieldTag.password.rawValue
   }
   
   @objc private func willSendLoginData() {
      passwordTextField.endEditing(true)
      viewModel?.requestLoginAccess()
      
      viewModel?.$state.observer = { [weak self] state in
         DispatchQueue.main.async {
            guard let serviceState: APIState = state else { return }
            switch serviceState {
               case .loading:
                  print("")
               case .success:
                  let coordinator: Coordinator = MainCoordinator(rootViewController: self?.navigationController ?? UINavigationController(), viewControllerFactory: iOSCoordinatorFactory())
                  coordinator.goToFilmCollection()
                  self?.errorMessage.isHidden = true
               case .failure:
                  self?.errorMessage.text = self?.viewModel?.errorMessage ?? ""
                  self?.errorMessage.isHidden = false

            }
         }
         
      }
   }
}

extension LoginViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
      switch textField.tag {
         case TextFieldTag.username.rawValue:
            viewModel?.userLoginData?.username = textField.text
         case TextFieldTag.password.rawValue:
            viewModel?.userLoginData?.password = textField.text
         default:
            print("error")
            
      }
      return true
   }
   
   func textFieldDidEndEditing(_ textField: UITextField) {
      switch textField.tag {
         case TextFieldTag.username.rawValue:
            viewModel?.userLoginData?.username = textField.text
         case TextFieldTag.password.rawValue:
            viewModel?.userLoginData?.password = textField.text
         default:
            print("error")
            
      }
   }
   
   private func addKeyboardWillShowFrameNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShowFrame), name: UIResponder.keyboardWillShowNotification, object: nil)
   }
   
   private func addKeyboardWillHideNotification() {
      NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
   }
   
   @objc private func onKeyboardWillShowFrame(_ notification: NSNotification) {
      usernameTextField.removeConstraints([usernameTextField.constraints[0]])
      let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue ?? CGRect()
      keyboardHeight = keyboardSize.height
      setCommonAnchorsTo(usernameTextField)
      usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -keyboardHeight/2).isActive = true
   }
   
   @objc private func onKeyboardWillHide() {
      
      
      view.layoutIfNeeded()
   }

}

