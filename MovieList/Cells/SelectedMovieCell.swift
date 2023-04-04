//
//  SelectedMovieCell.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 3.04.23.
//

import UIKit
import SDWebImage

class SelectedMovieCell: UITableViewCell {
    
    //MARK: - Static properties
    static var reuseId = "SelectedMovieCell"
    
    //MARK: - Constants
    private enum Constants {
        static let overviewTitle = "Overview"
    }
    
    //MARK: - Properties
    private lazy var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private lazy var overviewTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.text = Constants.overviewTitle
        return label
    }()
    
    private lazy var overviewText: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private functions
    private func setupUI() {
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(overviewTitle)
        contentView.addSubview(overviewText)
    }
    
    private func setupConstraints() {
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(500)
        }
        overviewTitle.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(moviePosterImageView)
        }
        
        overviewText.snp.makeConstraints { make in
            make.top.equalTo(overviewTitle.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(moviePosterImageView)
        }
    }
    
    //MARK: - Public functions
    func configure(with movie: Movie) {
        moviePosterImageView.sd_setImage(with: movie.posterURL)
        overviewText.text = movie.overview
    }
}
