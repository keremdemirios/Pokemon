//
//  PokemonInfoScreen.swift
//  Pokemon
//
//  Created by Kerem Demir on 14.04.2024.
//

import UIKit
import Kingfisher

final class PokemonInfoScreen: UIViewController {
    // MARK: UI Elements
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var OKButton: UIButton!
    
    // Properties
    var imageURL: URL?
    var pokemonName: String?
    
    // MARK: Initializer
    init(imageURL: URL?, name: String?) {
        self.imageURL = imageURL
        self.pokemonName = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    // MARK: Configure
    private func configure() {
        configureView()
        setupInfoCard()
    }
    
    private func configureView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.systemOrange.cgColor
    }
    
    // MARK: Functions
    private func setupInfoCard() {
        pokemonImageView.kf.setImage(with: imageURL)
        pokemonNameLabel.text = pokemonName ?? ""
    }
    
    func appear(_ sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 1, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    func moveToRootViewController() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateInitialViewController()
        sceneDelegate.window?.rootViewController = rootViewController
    }
    
    // MARK: Actions
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        hide()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
//            self.moveToRootViewController()
        }
        
        
    }
    
}

// MARK: Extensions

