//
//  MovieGalleryController.swift
//  GalleryMovie
//
//  Created by Michel Tan on 14/01/2025.
//
import UIKit
import Combine

class MovieGalleryController : UIViewController {
    
    @IBOutlet weak var movieGalleryCollectionView: UICollectionView!
    
    private var viewModel: MovieViewModel?
    private var movieSourceDelegate : MovieSourceDelegate?
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
        setupBindings()
        viewModel?.getFetchMovie()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
       private func setupViewModel() {
           // Idéalement, tu pourrais injecter le UseCase de l’extérieur
           // Pour la démo, on le crée localement
           let useCase = FetchMoviesUseCase(movieService: MockMovieService())
           viewModel = MovieViewModel(fetchMovieUseCase: useCase)
       }

       private func setupCollectionView() {
           // 1) Créer le SourceDelegate en lui passant le ViewModel
           guard let viewModel = viewModel else {return}
           movieSourceDelegate = MovieSourceDelegate(viewModel:viewModel)

           // 2) Assigner dataSource + delegate
           movieGalleryCollectionView.dataSource = movieSourceDelegate
           movieGalleryCollectionView.delegate = movieSourceDelegate

           // 3) Assigner un layout Compositional
           let layout = CollectionViewLayouts.shared.createCompostionalLayout()
           movieGalleryCollectionView.collectionViewLayout = layout
       }

    private func setupBindings() {
        // Souscrire à la propriété @Published listCurrentMovie
        viewModel?.$listCurrentMovie
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.movieGalleryCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        // Souscrire à la propriété @Published listMoviePopular
        // (si tu l’utilises dans le dataSource)
        viewModel?.$listMoviePopular
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.movieGalleryCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        //callback manual
        viewModel?.onMoviesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.movieGalleryCollectionView.reloadData()
            }
        }
    }
}
