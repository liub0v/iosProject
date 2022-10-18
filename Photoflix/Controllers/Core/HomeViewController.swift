//
//  HomeViewController.swift
//  Photoflix
//
//  Created by Liubov Kurets on 27/07/2022.
//

import UIKit

enum Section: Int {
    case TrandingMovies = 0
    case TrandingTv = 1
    case Popular = 2
    case UpcomingMovies = 3
    case TopRated = 4 
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Trending Movies","Popular" , "Trending tv", "Upcomimg Movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(CollectionViewTableViewCell.self , forCellReuseIdentifier: CollectionViewTableViewCell.indentifier)
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureHeroHeaderView()
        
    }
    
    private func configureHeroHeaderView () {
        APICaller.shared.getTrandingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                
                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        
        var image = UIImage(named: "logo_image")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,  style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        
        navigationController?.navigationBar.tintColor = .white
        
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.indentifier, for: indexPath
        ) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Section.TrandingMovies.rawValue:
            APICaller.shared.getTrandingMovies { results in
                       switch results {
                       case .success(let titles):
                           cell.configure(with: titles)
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
        case Section.TrandingTv.rawValue:
            APICaller.shared.getTrandingTvs { results in
                       switch results {
                       case .success(let titles):
                           cell.configure(with: titles)
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
        case Section.Popular.rawValue:
            APICaller.shared.getPopularMovies { results in
                       switch results {
                       case .success(let titles):
                           cell.configure(with: titles)
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
        case Section.UpcomingMovies.rawValue:
            APICaller.shared.getUpcomingMovies{ results in
                       switch results {
                       case .success(let titles):
                           cell.configure(with: titles)
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
        case Section.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies{ results in
                       switch results {
                       case .success(let titles):
                           cell.configure(with: titles)
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
                   }
        default:
            return UITableViewCell()
            
        }
         
        return cell
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.minX + 20, y: header.bounds.minY, width: header.bounds.width + 20, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirtsLetter()
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let viewController = TitlePreviewViewController()
            
            viewController.configure(with: viewModel)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
}
