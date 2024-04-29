//
//  ContainerVC.swift
//  Pokemon
//
//  Created by Kerem Demir on 12.04.2024.
//

import UIKit

class ContainerVC: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func configure() {
        
    }
    
    func resetContent() {
        DispatchQueue.main.async {
            self.profileImageView.image = self.image
        }
    }
}
