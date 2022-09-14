//
//  ViewController.swift
//  Movve
//
//  Created by Полина Дусин on 05.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    var movieManager = MovieManager()
    
    var cellsData = [MovieModel]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    fileprivate let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Movie"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        movieManager.delegate = self
        movieManager.getPopularMovie()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView.frame = CGRect(x: 20, y: 0, width: view.frame.width, height: view.frame.height/1.9)
    }
    
    private func setupView() {
        // view
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(categoryNameLabel)
        
        // navigationBar
        title = "Movve"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // collectionView
        collectionView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // collectionView
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5),
            
            //categoryNameLabel
            categoryNameLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -5),
            categoryNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryNameLabel.widthAnchor.constraint(equalTo: collectionView.widthAnchor),
        ])
    }
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource methods
extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.setData(data: cellsData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/1.5)
    }
}

//MARK: - MovieManagerDelegate methods
extension MainViewController: MovieManagerDelegate {
    
    func didUpdateMovies(movies: [MovieModel]) {
        cellsData = movies
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
