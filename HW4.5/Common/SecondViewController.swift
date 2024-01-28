//
//  SecondViewController.swift
//  HW4.5
//
//  Created by Alisher Sultanov on 27/1/24.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var infoConteiner: [Simple] = [
        Simple(leftImage: "1", titleText: "Jane Cooper has published a new recipe!", dataText: "Today | 09:24 AM", rightImage: "8"),
        Simple(leftImage: "2", titleText: "Rochel has commented on your recipe", dataText: "1 day ago | 14:43 PM", rightImage: "9"),
        Simple(leftImage: "3", titleText: "Brad Wigington liked your comment", dataText: "1 day ago | 09:29 AM", rightImage: "10"),
        Simple(leftImage: "4", titleText: "Tyra Ballentine has published a new recipe!", dataText: "2 days ago | 10:29 AM", rightImage: "11"),
        Simple(leftImage: "5", titleText: "Marci Winkles has published a new recipe!", dataText: "3 days ago | 16:52 PM", rightImage: "12"),
        Simple(leftImage: "6", titleText: "Aileen has commented on your recipe", dataText: "4 days ago | 14:27 PM", rightImage: "13"),
        Simple(leftImage: "7", titleText: "George has commented on your recipe", dataText: "5 days ago | 09:20 AM", rightImage: "14")]
    
    private lazy var settingBtn = MakerView.shared.makerButton(title: "", imageName: "Setting",
                                                               tintColor: .black,
                                                               backgroundColor: .clear,
                                                               cornerRadius: 0)
    
    private lazy var generalLabel = MakerView.shared.makerLabel(text: "Ceneral",
                                                                font: .systemFont(ofSize: 18, weight: .regular),
                                                                textColor: .systemPink, textAlignment: .center,
                                                                numberOfLines: 1)
    
    private lazy var systemLabel = MakerView.shared.makerLabel(text: "System",
                                                               font: .systemFont(ofSize: 18, weight: .regular),
                                                               textColor: .gray, textAlignment: .center,
                                                               numberOfLines: 1)
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupConfigurationBar()
        setupRegisterTableView()
        
        setupSettingsBtn()
        setupGeneralLabel()
        setupSystemLabel()
        setupTableView()
    }
    
    private func setupRegisterTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupConfigurationBar(){
        navigationItem.backBarButtonItem?.title = "Notification"
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(generalLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.separatorStyle = .none
    }
    
    private func setupSystemLabel() {
        view.addSubview(systemLabel)
        systemLabel.snp.makeConstraints { make in
            make.top.equalTo(settingBtn.snp.bottom).offset(29)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
            make.height.equalTo(25)
            make.width.equalTo(191)
        }
    }
    
    private func setupGeneralLabel() {
        view.addSubview(generalLabel)
        generalLabel.snp.makeConstraints { make in
            make.top.equalTo(settingBtn.snp.bottom).offset(29)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.width.equalTo(191)
            make.height.equalTo(25)
        }
    }
    
    private func setupSettingsBtn() {
        view.addSubview(settingBtn)
        settingBtn.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(62)
            make.trailing.equalTo(view.snp.trailing).offset(-24)
            make.height.width.equalTo(28)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoConteiner.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.configureCell(withFirstImage: infoConteiner[indexPath.row].leftImage,
                           title: infoConteiner[indexPath.row].titleText,
                           data: infoConteiner[indexPath.row].dataText,
                           additionalImage: infoConteiner[indexPath.row].rightImage)
        return cell
    }
    // даю ячейкам высоту и расстояние между ними
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84 + 12
    }
}
