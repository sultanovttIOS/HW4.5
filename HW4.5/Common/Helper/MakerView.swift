//
//  MakerView.swift
//  HW4.5
//
//  Created by Alisher Sultanov on 27/1/24.
//

import UIKit
import SnapKit

class MakerView {
    
    static let shared = MakerView()
    
    func makerTf(placeholder: String,
                 isSecureTextEntry: Bool = true,
                 rightView: UIButton,
                 rightViewMode: UITextField.ViewMode = .always) -> UITextField {
        let view = UITextField()
        view.placeholder = placeholder
        view.isSecureTextEntry = isSecureTextEntry
        view.rightView = rightView
        view.rightViewMode = rightViewMode
        return view
    }
    
    func makerLabel(text: String,
                    font: UIFont,
                    textColor: UIColor,
                    textAlignment: NSTextAlignment = .left,
                    numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
    
    func makerImageView(imageName: String,
                        cornerRadius: CGFloat,
                        clipsToBounds: Bool = true,
                        contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = clipsToBounds
        imageView.contentMode = contentMode
        return imageView
    }
    
    func makerButton(title: String?,
                     for state: UIControl.State = .normal,
                     imageName: String,
                     tintColor: UIColor,
                     backgroundColor: UIColor,
                     cornerRadius: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: state)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = tintColor
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius

        return button
    }
    
    
    func makerView(cornerRadius: CGFloat,
                   clipsToBounds: Bool = true,
                   backgroundColor: UIColor) -> UIView {
        let view = UIView()
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = clipsToBounds
        view.backgroundColor = backgroundColor
        return view
    }
}
