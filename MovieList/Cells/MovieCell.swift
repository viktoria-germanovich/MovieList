//
//  MovieCell.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 26.03.23.
//

import UIKit
import SnapKit
import SDWebImage

class MovieCell: UITableViewCell {
    
    //MARK: - Private properties
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = .noImage
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var voteView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var voteProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = .orange
        progressView.trackTintColor = .gray
        return progressView
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()

    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(MovieConstants.FatalError.initError)
    }
    
    //MARK: - Private functions
    private func setupViews() {
        contentView.backgroundColor = .black
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(movieTitle)
        infoStackView.addArrangedSubview(voteView)
        
        voteView.addSubview(voteProgressView)
        voteView.addSubview(voteLabel)

    }
    
    private func setupConstraints() {
        moviePosterImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(20)
            make.width.equalTo(80)
            make.height.equalTo(100)
        }
        infoStackView.snp.makeConstraints { make in
            make.leading.equalTo(moviePosterImageView.snp.trailing).offset(20)
            make.top.bottom.trailing.equalToSuperview().inset(20)
        }
        voteProgressView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
        }
        voteLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(voteProgressView.snp.trailing).offset(20)
        }
    }
    
    //MARK: - Internal functions
    func configure(with movie: Movie) {
        if let posterUrl = movie.posterURL {
            moviePosterImageView.sd_setImage(with: posterUrl)
        }
        movieTitle.text = movie.title
        voteProgressView.progress = Float(movie.voteAverage/10)
        voteLabel.text = String(format: "%.1f", movie.voteAverage)
    }
}
