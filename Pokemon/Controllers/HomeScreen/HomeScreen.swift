//
//  ViewController.swift
//  Pokemon
//
//  Created by Kerem Demir on 12.04.2024.
//

// MARK: Sender
import UIKit
import Koloda
import Kingfisher


protocol SendDataDelegate: AnyObject {
    func sendNoneLikeArray(_ data: [(image: Sprites, name: String)])
    func sendLikedArray(_ data: [(image: Sprites, name: String)])
}

final class HomeScreen: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var kolodaImageView: KolodaView!
    @IBOutlet weak var abilitiesCollectionView: UICollectionView!
    
    var likedArray = [(image: Sprites, name: String)]()
    var noneArray = [(image: Sprites, name: String)]()
    
    var containers = [ContainerVC]()
    
    var pokemonNames = [PokemonResults]()
    var pokemonImages = [Sprites]()
    var pokemonAbilities = [AbilityElement]()
    var pokemonAbilitiesDictionary: [Int: [String]] = [:]
    
//    var isAbilitiesUpdated: Bool = false
    
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Pokemons ⚡️"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadContainerView()
        reloadImageView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPokemonNames()
        loadPokemonDetail()
        laodPokemonAbilities()
    }
    
    // MARK: Configure
    private func configure() {
        configureKoloda()
        configureCollectionView()
        configureBackView()
    }
    
    private func configureBackView() {
        backView.layer.cornerRadius = 10
        backView.layer.borderWidth = 0.5
        backView.layer.borderColor = UIColor.systemYellow.cgColor
    }
    
    private func configureKoloda() {
        kolodaImageView.delegate = self
        kolodaImageView.dataSource = self
    }
    
    private func configureCollectionView() {
        abilitiesCollectionView.register(AbilitiesCell.self, forCellWithReuseIdentifier: AbilitiesCell.reuseIdentifier)
        
    }
    
    // MARK: API Functions
    private func loadPokemonNames() {
        MovieLogic.shared.getPokemonNames { [weak self] returnedNames in
            guard let self else { return }
            
            switch returnedNames {
            case .success(let names):
                self.pokemonNames = names.results ?? [PokemonResults]()
                DispatchQueue.main.async {
                    self.kolodaImageView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func laodPokemonAbilities() {
        let limit = 40
        
        for id in 1...limit {
            let abilitiesURL = Constants.getAbilities(forID: id)
            
            MovieLogic.shared.getPokemonAbilities(url: abilitiesURL) { [weak self] result in
                guard let self = self else { return }
            
                switch result {
                case .success(let abilities):
                    let abilitiesNames = abilities.abilities.map { $0.ability.name }
                    self.pokemonAbilitiesDictionary[id] = abilitiesNames
                    print("Abilities for ID \(id): \(abilitiesNames)")
                    DispatchQueue.main.async {
                        
                        self.abilitiesCollectionView.reloadData()
                    }
                    
                case .failure(let error):
                    print("Error fetching Pokemon abilities: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func loadPokemonDetail() {
        let limit = 40
        var pokemonImagesWithNumbers = [(Int, Sprites)]()
        
        for id in 1...limit {
            let imageURL = Constants.getDetail(forID: id)
            MovieLogic.shared.getPokemonDetails(url: imageURL) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let details):
                    if let sprites = details.sprites {
                        pokemonImagesWithNumbers.append((id, sprites))
                    } else {
                        print("Sprites not found in the response")
                    }
                    
                    if pokemonImagesWithNumbers.count == limit {
                        let sortedImages = pokemonImagesWithNumbers.sorted { $0.0 < $1.0 }
                        for (index, (id, sprites)) in sortedImages.enumerated() {
                            self.pokemonImages.append(sprites)
                            if index < self.pokemonNames.count {
                                self.pokemonNames.append(self.pokemonNames[index])
                            }
                        }
                        // Ekrana yükleme işlemi
                        DispatchQueue.main.async {
                            self.kolodaImageView.reloadData()
                        }
                    }
                case .failure(let error):
                    print("Error fetching Pokemon images: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: Functions
    private func loadContainerView() {
        for _ in 0...pokemonImages.count {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContainerVC") as! ContainerVC
            self.addChild(vc)
            containers.append(vc)
        }
    }
    
    private func reloadImageView() {
        DispatchQueue.main.async {
            self.kolodaImageView.reloadData()
        }
    }
    
    // MARK: Actions
    @IBAction func noneButtonAction(_ sender: Any) {
        kolodaImageView.swipe(.left)
        delegate?.sendLikedArray(noneArray)
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        kolodaImageView.swipe(.right)
        delegate?.sendLikedArray(likedArray)
    }
    
    @IBAction func toSecondVC(_ sender: UIBarButtonItem) {
        print("Second Screen is came.")
        
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondVC") as! ResultsScreen
        
        secondVC.likedArray = likedArray
        secondVC.nonedArray = noneArray
        
        print(likedArray)
        
        secondVC.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

// MARK: Extensions
extension HomeScreen {
    func abilitiesForPokemon(at index: Int) -> [String]? {
        guard index < pokemonAbilities.count else {
            return nil
        }
        
        let abilities = [pokemonAbilities[index].ability.name]
        return abilities
    }
}


extension HomeScreen: SendDataDelegate {
    
    func sendLikedArray(_ data: [(image: Sprites, name: String)]) {
        likedArray = data
    }
    
    func sendNoneLikeArray(_ data: [(image: Sprites, name: String)]) {
        noneArray = data
    }
}

extension HomeScreen: KolodaViewDelegate, KolodaViewDataSource {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let containerView = UIView()
        containerView.clipsToBounds = true
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        if index < pokemonImages.count {
            if let imageURL = URL(string: pokemonImages[index]._frontDefault) {
                imageView.kf.setImage(with: imageURL)
            } else {
                print("There is no URL or incorrect URL.")
            }
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: kolodaImageView.frame.width, height: kolodaImageView.frame.height)
        containerView.addSubview(imageView)
        
        if index < pokemonNames.count {
            let nameLabel = UILabel()
            nameLabel.textAlignment = .center
            nameLabel.textColor = .label
            nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            nameLabel.text = pokemonNames[index].name
            nameLabel.frame = CGRect(x: 0, y: kolodaImageView.frame.height - 40, width: kolodaImageView.frame.width, height: 30)
            containerView.addSubview(nameLabel)
        }
        
        return containerView
    }
    
    func kolodaNumberOfCards(_ koloda: Koloda.KolodaView) -> Int {
        return pokemonImages.count
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
          // Swipe yönüne göre işlemler
          switch direction {
          case .left:
              // Beğenilmeyenler listesine ekle
              if let name = pokemonNames[index].name {
                  noneArray.append((image: pokemonImages[index], name: name))
              } else {
                  print("Name not found for index \(index)")
              }

          case .right:
              // Beğenilenler listesine ekle
              if let name = pokemonNames[index].name {
                  likedArray.append((image: pokemonImages[index], name: name))
              } else {
                  print("Name not found for index \(index)")
              }

          default:
              break
          }
          
          // Swipe işlemi sonrasında abilitiesCollectionView'ı güncelle
          let currentCardIndex = koloda.currentCardIndex
          let currentCardID = currentCardIndex + 1
          
          if let abilities = pokemonAbilitiesDictionary[currentCardID] {
              DispatchQueue.main.async {
                  self.abilitiesCollectionView.reloadData()
              }
          }
      }
}

extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         let currentCardIndex = kolodaImageView.currentCardIndex
         let currentCardID = currentCardIndex + 1
         
         return pokemonAbilitiesDictionary[currentCardID]?.count ?? 0
     }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AbilitiesCell.reuseIdentifier, for: indexPath) as? AbilitiesCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3)
        let currentCardIndex = kolodaImageView.currentCardIndex
        let currentCardID = currentCardIndex + 1
        
        if let abilities = pokemonAbilitiesDictionary[currentCardID] {
            let ability = abilities[indexPath.item]
            cell.setCell(abilitiesName: ability)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let currentCardIndex = kolodaImageView.currentCardIndex
        let currentCardID = currentCardIndex + 1
        
        if let abilities = pokemonAbilitiesDictionary[currentCardID] {
            let ability = abilities[indexPath.item]
            let labelWidth = (ability as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]).width
            let cellWidth = labelWidth + 20
            
            return CGSize(width: cellWidth + 25, height: 50)
        } else {
            
            return CGSize(width: 100, height: 50)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 6, left: 15, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

}
