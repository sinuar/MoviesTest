//
//  LoginViewController.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import UIKit

final class LoginViewController: UIViewController {
   @UsesLayout private var usernameTextField: UITextField = UITextField()
   @UsesLayout private var passwordTextField: UITextField = UITextField()
   @UsesLayout private var loginButton: UIButton = UIButton()
   @UsesLayout private var errorMessage: UILabel = UILabel()
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupTextFieldDelegate()
      setupTextFieldTags()
      setupView()
   }

   private func setupTextFieldDelegate() {
      usernameTextField.delegate = self
      passwordTextField.delegate = self
   }
   
   private func setupTextFieldTags() {
      usernameTextField.tag = 0
      passwordTextField.tag = 1
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
   }
   private func setupErrorMessage() {
      view.addSubview(errorMessage)
      NSLayoutConstraint.activate([
         errorMessage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
         errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         errorMessage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
      ])
      errorMessage.text = "mensaje de error"
      errorMessage.textColor = .orange
      errorMessage.textAlignment = .center
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
}

extension LoginViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      print("amonos")
      return true
   }
}
