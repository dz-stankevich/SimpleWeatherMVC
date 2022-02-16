//
//  DWComponent.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 18.01.22.
//

import Foundation
import UIKit
import SnapKit

class DWComponent: UIView {
    //MARK: - Varibles
    private let imageSize = CGSize(width: 50, height: 50)
    private let edgeInsets = UIEdgeInsets(all: 16)
    
    //MARK: - GUI Varibles
    private lazy var conteiner = UIView()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var info: UILabel = {
        var lable = UILabel()
        lable.textAlignment = .center
        lable.numberOfLines = 1
        lable.textColor = .black
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        
        return lable
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        initionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initionView() {
        self.addSubview(self.conteiner)
        
        self.conteiner.addSubview(imageView)
        self.conteiner.addSubview(info)
        
        setupConstraints()
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        self.conteiner.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.imageView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.size.equalTo(self.imageSize)
        }
        
        self.info.snp.updateConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    func setImage(with name: String) {
        self.imageView.image = UIImage(named: String(name))
    }
    
    func setInfo(with info: String) {
        self.info.text = info
    }
}
