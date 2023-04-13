//
//  SelectedMovieViewController.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 3.04.23.
//

import UIKit

class SelectedMovieViewController: UIViewController {
    
    //MARK: - Properties
    private let movie: Movie
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(SelectedMovieCell.self, forCellReuseIdentifier: String(describing: SelectedMovieCell.self))
        tableView.allowsSelection = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(MovieConstants.FatalError.initError)
    }
    
    //MARK: - Private functions
    private func setupViews() {
        title = movie.title
        view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.titleView?.tintColor = .orange
        view.addSubview(movieTableView)
    }
    
    private func setupConstraints() {
        movieTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SelectedMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: SelectedMovieCell.self),
            for: indexPath
        ) as? SelectedMovieCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(with: movie)
        return cell
    }
}
