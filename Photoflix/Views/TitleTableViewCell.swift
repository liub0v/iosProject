//
//  TitleTableViewCell.swift
//  Photoflix
//
//  Created by Liubov Kurets on 05/10/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let indentifier = "TitleTableViewCell"
    
   
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 30))
        
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
       
        return button
    }()
    
    
   
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlesPosterUImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterUImageView)
        contentView.addSubview(titleLabel )
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints(){
        let titlesPosterUImageViewConstraints = [
            titlesPosterUImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor ),
            titlesPosterUImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterUImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlesPosterUImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor ),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
            
        ]
        
        let playTitleButton = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)]
        
        NSLayoutConstraint.activate(titlesPosterUImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButton)
    }
    
    public func configure (with model: TitleViewModel ){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {return}
        
        titlesPosterUImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        
    }
    
    required  init?(coder: NSCoder) {
        fatalError()
    }
    

}
