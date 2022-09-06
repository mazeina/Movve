//
//  ViewController.swift
//  Movve
//
//  Created by Полина Дусин on 05.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    let dataArray = [
        CustomData(title: "test0", image: UIImage(named: "testImage")!, url: "test0"),
        CustomData(title: "test1", image: UIImage(named: "testImage1")!, url: "test1"),
        CustomData(title: "test2", image: UIImage(named: "testImage2")!, url: "test2"),
        CustomData(title: "test3", image: UIImage(named: "testImage3")!, url: "test3"),
        CustomData(title: "test4", image: UIImage(named: "testImage4")!, url: "test4"),

    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
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

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.data = dataArray[indexPath.row]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/1.5)
    }
}
