//
//  SecondVC.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//
// MARK: Listener
import UIKit

final class ResultsScreen: UIViewController {
    
    var isLike: Bool = true
    
    // MARK: Arrays
    var likedArray = [(image: Sprites, name: String)]()
    var nonedArray = [(image: Sprites, name: String)]()
    var currentData = [(image: Sprites, name: String)]()
    
    // MARK: UI Elements
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var infoTableView: UITableView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Liked Array in ResultsScreen: \(likedArray)")
        configure()
    }

    
    // MARK: Configure
    private func configure() {
        configureButtons()
        configureTableView()
        setInitial()
    }
    
    // MARK: Functions
    private func setInitial() {
        setCurrentData(with: likedArray)
        likeButton.backgroundColor = .systemGreen.withAlphaComponent(0.5)
    }
    
    private func setCurrentData(with data: [(image: Sprites, name: String)]) {
        currentData = data
        DispatchQueue.main.async {
            self.infoTableView.reloadData()
        }
    }
    
    private func configureTableView() {
        infoTableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.reuseIdentifier)
    }
    
    private func configureButtons() {
        likeButton.layer.borderWidth = 2
        dislikeButton.layer.borderWidth = 2
        
        likeButton.layer.borderColor = UIColor.systemGreen.cgColor
        dislikeButton.layer.borderColor = UIColor.systemRed.cgColor
        
        likeButton.layer.cornerRadius = 8
        dislikeButton.layer.cornerRadius = 8
    }
    
    // MARK: Actions
    @IBAction func showDislikes(_ sender: UIButton) {
        dislikeButton.backgroundColor = .systemRed.withAlphaComponent(0.5)
        likeButton.backgroundColor = .clear
        isLike = false
        
        // Set Data
        setCurrentData(with: nonedArray)
    }
    
    @IBAction func showLikes(_ sender: UIButton) {
        likeButton.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        dislikeButton.backgroundColor = .clear
        isLike = true
        
        // Set Data
        setCurrentData(with: likedArray)
    }
}

// MARK: Extensions
extension ResultsScreen: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
        return currentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseIdentifier, for: indexPath) as? InfoCell else { return UITableViewCell()}
        
        let data = currentData[indexPath.row]
        cell.setCell(imageURL: URL(string: data.image._frontDefault), name: data.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        infoTableView.deselectRow(at: indexPath, animated: false)
        
        // MARK: Go Info Page
        let selectedPokemon = currentData[indexPath.row]
        let imageURL = URL(string: selectedPokemon.image._frontDefault)
        
        let infoScreen = PokemonInfoScreen(imageURL: imageURL, name: selectedPokemon.name)
        infoScreen.modalPresentationStyle = .fullScreen
        infoScreen.appear(self)
    }
    
}

extension ResultsScreen: SendDataDelegate {
    func sendLikedArray(_ data: [(image: Sprites, name: String)]) {

        likedArray = data
    }
    
    func sendNoneLikeArray(_ data: [(image: Sprites, name: String)]) {
        
        nonedArray = data
    }
}
