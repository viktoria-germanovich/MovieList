//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Viktoryia Hermanovich on 26.03.23.
//

import UIKit
import SnapKit
import CombineFeedbackUI
import SDWebImage

protocol MovieListDisplay {
    func update(with state: MovieState)
}

class MovieViewController: UIViewController, MovieListDisplay {
    
    //MARK: - Constants
    private struct Constants {
        static let title = "Movies"
        static let searchKey = "searchField"
        static let noDataImage = "nodata"
    }
    
    //MARK: - Properties
    private var movies: [Movie] = []
    private let intent = MovieIntent()
    private let initialState = MovieState(
        selectedMovie: nil,
        status: .loading,
        movies: [],
        query: ""
    )
    private var store: Store<MovieState,MovieEvent>?
    
    private lazy var searchBar: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseId)
        tableView.allowsSelection = true
        tableView.separatorColor = .gray
        return tableView
    }()

    private lazy var noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: Constants.noDataImage)
        return imageView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        intent.bind(to: self)
        store = Store(
            initial: initialState,
            feedbacks: [intent.whenLoadingMovies()],
            reducer: intent.reducer(state:event:)
        )
    }
    
    //MARK: - Private functions
    private func setupViews() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.searchController = searchBar
        navigationItem.title = Constants.title
        if let textField = searchBar.searchBar.value(forKey: Constants.searchKey) as? UITextField {
            textField.textColor = .white
        }
        
        view.addSubview(moviesTableView)
        view.addSubview(noDataImageView)
    }
    
    private func setupConstraints() {
        moviesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        noDataImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func handleMovieSelection(_ movie: Movie?) {
        guard let movie = movie else {
            return
        }
        let selectedMovieVC = SelectedMovieViewController(movie: movie)
        navigationController?.pushViewController(selectedMovieVC, animated: true)
    }
    
    //MARK: - Public functions
    func update(with state: MovieState) {
        switch state.status {
        case .noData:
            moviesTableView.isHidden = true
            noDataImageView.isHidden = false
        case .loaded:
            moviesTableView.isHidden = false
            noDataImageView.isHidden = true
            movies = state.movies
            moviesTableView.reloadData()
        case .selected:
            handleMovieSelection(state.selectedMovie)
        default: break
        }
    }
}

//MARK: - Table data source and selection logic
extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseId, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .clear
        let backView = UIView()
        backView.backgroundColor = .orange
        cell.selectedBackgroundView = backView
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        store?.send(event: .select(movies[indexPath.row]))
    }
}

//MARK: - Movies filter implementation
extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, let store = store else {
            return
        }
        store.send(event: .filter(with: query))
    }
}
