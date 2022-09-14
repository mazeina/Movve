//
//  CustomCollectionViewCell.swift
//  Movve
//
//  Created by Полина Дусин on 06.09.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    var movieManager = MovieManager()
    
    fileprivate var backgroundImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = CGFloat(12)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    fileprivate let nameOfMovieLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    fileprivate let movieReleaseDataLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstreints()
        
        movieManager.delegateImage = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: MovieModel) {
        nameOfMovieLabel.text = data.movieName
        movieReleaseDataLabel.text = data.releaseData
        movieManager.getImageByPath(imagePath: data.imagePath)
    }
    
    func setupView() {
        contentView.addSubview(backgroundImage)
        contentView.addSubview(nameOfMovieLabel)
        contentView.addSubview(movieReleaseDataLabel)
    }
    
    func setupConstreints() {
        NSLayoutConstraint.activate([
            // backgroundImage
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            // nameOfMovieLabel
            nameOfMovieLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 5),
            nameOfMovieLabel.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor),
            
            // movieReleaseDataLabel
            movieReleaseDataLabel.topAnchor.constraint(equalTo: nameOfMovieLabel.bottomAnchor, constant: 5),
            movieReleaseDataLabel.widthAnchor.constraint(equalTo: backgroundImage.widthAnchor),
        ])
    }
}

//MARK: - MovieManagerImageDelegate methods
extension MovieCollectionViewCell: MovieManagerImageDelegate {

    func didLoadImage(with image: UIImage) {
        backgroundImage.image = image
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
