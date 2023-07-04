//
//  ProductTableViewCell.swift
//  FirstHomeWork
//
//  Created by Sevara on 4/7/23.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .medium)
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 11, weight: .regular)
        return view
    }()
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        addContrains()
    }
    
    private func addView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(image)
    }
    
    private func addContrains() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalTo(image.snp.leading).offset(-25)
        }
        
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(100)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func updateData(model: Product) {
        nameLabel.text = model.title
        infoLabel.text = model.description
        image.kf.setImage(with: URL(string: model.thumbnail!))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
