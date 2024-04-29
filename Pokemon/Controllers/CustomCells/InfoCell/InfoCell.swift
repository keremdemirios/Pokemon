//
//  InfoCell.swift
//  Pokemon
//
//  Created by Kerem Demir on 14.04.2024.
//

import UIKit

final class InfoCell: UITableViewCell {
    
    static let reuseIdentifier = "InfoCell"
    
    // MARK: UI Elements
    var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name"
        nameLabel.textColor = .label
        return nameLabel
    }()
    
    // MARK: Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    private func configureCell() {
        configureUI()
        configureInfoImageView()
        configureNameLabel()
    }
    
    func configureInfoImageView() {
        infoImageView.layer.borderWidth = 2
//        infoImageView.layer.borderColor = UIColor.clear.cgColor
        infoImageView.layer.cornerRadius = 10
    }
    
    func configureNameLabel() {
        nameLabel.font = .boldSystemFont(ofSize: 18)
    }
    
    private func configureUI() {
        addSubViews(infoImageView, nameLabel)
        NSLayoutConstraint.activate([
            // ImageView
            infoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            infoImageView.heightAnchor.constraint(equalToConstant: 100),
            infoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            // Label
            nameLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: 40),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: Functions
    
    func setCell(imageURL: URL?, name: String) {
        infoImageView.kf.setImage(with: imageURL)
        nameLabel.text = name
    }
}

// MARK: Extension


// TODO: BORDER COLOR
