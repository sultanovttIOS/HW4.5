//
//  CustomTableViewCell.swift
//  HW4.5
//
//  Created by Alisher Sultanov on 27/1/24.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var cellView = MakerView.shared.makerView(cornerRadius: 0,
                                                           backgroundColor: .clear)
    
    private lazy var titleLabel = MakerView.shared.makerLabel(text: "",
                                                              font: UIFont.systemFont(ofSize: 17, weight: .regular),
                                                              textColor: .black,
                                                              numberOfLines: 2)
    
    private lazy var dataLabel = MakerView.shared.makerLabel(text: "",
                                                             font: UIFont.systemFont(ofSize: 14, weight: .regular),
                                                             textColor: .darkGray,
                                                             numberOfLines: 1)
    
    private lazy var leftImage = MakerView.shared.makerImageView(imageName: "",
                                                                 cornerRadius: 24)
    
    private lazy var rightImage = MakerView.shared.makerImageView(imageName: "",
                                                                  cornerRadius: 4)
    
    private lazy var settingsBtn = MakerView.shared.makerButton(title: "",
                                                                imageName: "settings",
                                                                tintColor: .black,
                                                                backgroundColor: .clear,
                                                                cornerRadius: 0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    private func setupUI() {
        setupCellView()
        setupLeftImage()
        setupTitleLabel()
        setupDataLabel()
        setupRightImage()
        setupSettingsBtn()
    }
    
    private func setupSettingsBtn() {
        cellView.addSubview(settingsBtn)
        settingsBtn.snp.makeConstraints { make in
            make.centerY.equalTo(cellView.snp.centerY)
            make.trailing.equalTo(cellView.snp.trailing)
            make.leading.equalTo(rightImage.snp.trailing).offset(10)
            make.height.width.equalTo(24)
        }
    }
    
    private func setupRightImage() {
        cellView.addSubview(rightImage)
        rightImage.snp.makeConstraints { make in
            make.centerY.equalTo(cellView.snp.centerY)
            make.leading.equalTo(titleLabel.snp.trailing).offset(12)
            make.height.width.equalTo(68)
        }
    }
    
    private func setupDataLabel() {
        cellView.addSubview(dataLabel)
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(leftImage.snp.trailing).offset(16)
            make.height.equalTo(20)
        }
    }
    
    private func setupTitleLabel() {
        cellView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cellView.snp.top)
            make.leading.equalTo(leftImage.snp.trailing).offset(16)
            make.width.equalTo(198)
            make.height.equalTo(58)
        }
    }
    
    private func setupLeftImage() {
        cellView.addSubview(leftImage)
        leftImage.snp.makeConstraints { make in
            make.centerY.equalTo(cellView.snp.centerY)
            make.leading.equalTo(cellView.snp.leading)
            make.height.width.equalTo(48)
        }
    }
    
    private func setupCellView() {
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureCell(withFirstImage firstImage: String, title: String, data: String, additionalImage: String) {
        leftImage.image = UIImage(named: firstImage)
        titleLabel.text = title
        dataLabel.text = data
        rightImage.image = UIImage(named: additionalImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
