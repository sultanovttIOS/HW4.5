//
//  ViewController.swift
//  HW4.5
//
//  Created by Alisher Sultanov on 27/1/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var backButton = MakerView.shared.makerButton(title: "",
                                                               for: .normal,
                                                               imageName: "arrowLeft",
                                                               tintColor: .black,
                                                               backgroundColor: .clear,
                                                               cornerRadius: 0)

    private lazy var titleLabel = MakerView.shared.makerLabel(text: "Create New Password 🔐",
                                                              font: UIFont.systemFont(ofSize: 30, weight: .semibold),
                                                              textColor: UIColor.black,
                                                              numberOfLines: 1)
    
    private lazy var subtitleLabel  = MakerView.shared.makerLabel(text: "Enter your new password. If you forget it, then you have to do forgot password.",
                                                                  font: UIFont.systemFont(ofSize: 15, weight: .regular),
                                                                  textColor: .darkGray,
                                                                  numberOfLines: 0)
     
    private lazy var passwordLabel = MakerView.shared.makerLabel(text: "Password",
                                                                 font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                                                 textColor: UIColor.black,
                                                                 numberOfLines: 1)
    
    private lazy var tf: UITextField = {
        let view = UITextField()
        view.placeholder = "Password"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 4))
        view.leftView = leftView
        view.leftViewMode = .always
        view.isSecureTextEntry = true
        let rightView = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        rightView.setBackgroundImage(UIImage(named: "Hide"), for: .normal)
        rightView.isUserInteractionEnabled = true
        rightView.addTarget(self, action: #selector(hideText), for: .touchUpInside)
        rightView.tag = 0
        view.rightView = rightView
        view.rightViewMode = .always
        view.addTarget(self, action: #selector(isEnabled), for: .editingChanged)
        view.tag = 0
        return view
    }()
    
    private lazy var borderView = MakerView.shared.makerView(cornerRadius: 0, backgroundColor: .gray)

    private lazy var confirmLabel = MakerView.shared.makerLabel(text: "Confirm Password",
                                                                font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                                                textColor: UIColor.black,
                                                                numberOfLines: 1)
    
    private lazy var confirmTf: UITextField = {
        let view = UITextField()
        view.placeholder = "Confirm Password"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 4))
        view.leftView = leftView
        view.leftViewMode = .always
        view.isSecureTextEntry = true
        let rightView = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        rightView.setBackgroundImage(UIImage(named: "Hide"), for: .normal)
        rightView.isUserInteractionEnabled = true
        rightView.addTarget(self, action: #selector(hideText), for: .touchUpInside)
        rightView.tag = 1
        view.rightView = rightView
        view.rightViewMode = .always
        view.addTarget(self, action: #selector(isEnabled), for: .editingChanged)
        view.tag = 1
        return view
    }()

    private lazy var SecondBorderView = MakerView.shared.makerView(cornerRadius: 0,
                                                                   backgroundColor: .gray)
        
    private lazy var rememberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .green
        button.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rememberLabel = MakerView.shared.makerLabel(text: "Remember me",
                                                                 font: .systemFont(ofSize: 18, weight: .semibold),
                                                                 textColor: .black,
                                                                 numberOfLines: 0)
    
    private lazy var continueBtn = MakerView.shared.makerButton(title: "Continue", imageName: "",
                                                                tintColor: .white,
                                                                backgroundColor: .systemPink,
                                                                cornerRadius: 16)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        configureNavigationBar()
        setupBackBtn()
        setupTitle()
        setupSubtitle()
        setupPasslabel()
        setupTf()
        setupBrd()
        setupConfirmlabel()
        setupConfirmTf()
        setupSecondBrd()
        setupRememberButton()
        setupRemembeLabel()
        setupContinueBtn()
    }
    
    private func configureNavigationBar() {
            navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowLeft")
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowLeft")
            navigationController?.navigationBar.tintColor = .black
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Notification", style: .plain, target: nil, action: nil)
        }
    
    private func setupContinueBtn() {
        view.addSubview(continueBtn)
        continueBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-36)
            make.height.equalTo(58)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        continueBtn.isEnabled = false
        continueBtn.addTarget(self, action: #selector(checkTf), for: .touchUpInside)
    }
    
    // Переход на следующий экран при активации кнопки
    @objc func checkTf(_ sender: UIButton) {
        
        let vc = SecondViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    // Проверяет валидацию текси филдов и дает активацию
    @objc func isEnabled(_ sender: UITextField) {

        if tf.text?.count ?? 0 > 4 && confirmTf.text?.count ?? 0 > 4 && tf.text == confirmTf.text {
            validate(tf, confirmTf, "")
            continueBtn.isEnabled = true
        } else {
            validate(tf, confirmTf, "Please, fill the field!")
            continueBtn.isEnabled = false
        }
    }
    
    // Проверяет отрицательную валидацию текст филдов и просить заполнить поля
    func validate(_ tf: UITextField, _ secondTf: UITextField, _ error: String,
                  borderColor: UIColor = .red, borderWidth: CGFloat = 1.0, cornerRadius: CGFloat = 5) {
        if let text = tf.text, let secondText = secondTf.text,
            text.count < 5, secondText.count < 5 {
            tf.placeholder = error
            secondTf.placeholder = error
            tf.layer.borderColor = borderColor.cgColor
            secondTf.layer.borderColor = borderColor.cgColor
            tf.layer.borderWidth = borderWidth
            secondTf.layer.borderWidth = borderWidth
            tf.layer.cornerRadius = cornerRadius
            secondTf.layer.cornerRadius = cornerRadius
        } else {
            tf.layer.borderColor = UIColor.white.cgColor
            secondTf.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func setupRemembeLabel() {
        view.addSubview(rememberLabel)
        rememberLabel.snp.makeConstraints { make in
            make.top.equalTo(SecondBorderView.snp.bottom).offset(24)
            make.leading.equalTo(rememberButton.snp.trailing).offset(16)
            make.height.equalTo(25)
        }
    }
    
    private func setupRememberButton() {
        view.addSubview(rememberButton)
        rememberButton.snp.makeConstraints { make in
            make.top.equalTo(SecondBorderView.snp.bottom).offset(24)
            make.leading.equalTo(SecondBorderView.snp.leading)
            make.height.width.equalTo(24)
        }
    }
    
    @objc func checkboxTapped() {
        rememberButton.isSelected = !rememberButton.isSelected
    }
    
    private func setupSecondBrd() {
        view.addSubview(SecondBorderView)
        SecondBorderView.snp.makeConstraints { make in
            make.top.equalTo(confirmTf.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    
    private func setupConfirmTf() {
        view.addSubview(confirmTf)
        confirmTf.snp.makeConstraints { make in
            make.top.equalTo(confirmLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }
    }
    
    private func setupConfirmlabel() {
        view.addSubview(confirmLabel)
        confirmLabel.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(24)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.height.equalTo(22)
        }
    }
    
    private func setupBrd() {
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.top.equalTo(tf.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    
    private func setupTf() {
        view.addSubview(tf)
        tf.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(32)
        }
    }
    
    @objc func hideText(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            tf.isSecureTextEntry = !tf.isSecureTextEntry
        case 1:
            confirmTf.isSecureTextEntry = !confirmTf.isSecureTextEntry
        default:
            break
        }
    }
    
    private func setupPasslabel() {
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.leading.equalTo(24)
            make.height.equalTo(22)
        }
    }
    
    private func setupTitle() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(88)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }
    }
    
    private func setupSubtitle() {
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(titleLabel.snp.horizontalEdges)
            make.height.equalTo(50)
        }
    }
    
    private func setupBackBtn() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(65)
            make.leading.equalTo(24)
            make.height.width.equalTo(28)
        }
    }
}



