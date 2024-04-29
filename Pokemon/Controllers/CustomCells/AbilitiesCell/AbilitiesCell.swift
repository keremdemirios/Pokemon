//
//  AbilitiesCell.swift
//  Pokemon
//
//  Created by Kerem Demir on 19.04.2024.
//

import UIKit

final class AbilitiesCell: UICollectionViewCell {

    static let reuseIdentifier = "AbilitiesCell"
    
    lazy var abilitiesImageView: UIImageView = {
        let abilitiesImageView = UIImageView()
        abilitiesImageView.translatesAutoresizingMaskIntoConstraints = false
        abilitiesImageView.image = UIImage(systemName: "swift")
        abilitiesImageView.tintColor = .label
        return abilitiesImageView
    }()
    
    lazy var abilitiesNameLabel: UILabel = {
        let abilitiesNameLabel = UILabel()
        abilitiesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        abilitiesNameLabel.text = "N/A"
        abilitiesNameLabel.textColor = .label
        return abilitiesNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        backgroundColor = .systemYellow.withAlphaComponent(0.50)
        layer.cornerRadius = 16
        
        addSubViews(abilitiesImageView, abilitiesNameLabel)
        NSLayoutConstraint.activate([
            abilitiesImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            abilitiesImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            abilitiesNameLabel.leadingAnchor.constraint(equalTo: abilitiesImageView.trailingAnchor, constant: 8),
            abilitiesNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    func setCell(abilitiesName: String) {
        abilitiesNameLabel.text = abilitiesName
        abilitiesNameLabel.sizeToFit()
    }

}
