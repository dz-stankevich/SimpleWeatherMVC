//
//  MainInfo.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 16.01.22.
//

import SnapKit
import UIKit

class MainWeatherInfo: UIView {
    //MARK: - Varibles
    private let edgeInsets = UIEdgeInsets(all: 20)
    private let imageSize = CGSize(width: 150, height: 150)
    private let separatorSize = CGSize(width: 1, height: 25)
    
    //MARK: - GUI Varibles
    private lazy var conteinerVert: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        
        return stack
    }()
    
    private lazy var conteinerHor: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 25
        stack.distribution = .equalCentering
        
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
        
    private lazy var sityLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var temperatureLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var statusLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()

    
    //MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView(){
        self.addSubview(conteinerVert)
        

        conteinerVert.addArrangedSubviews([imageView, sityLable, conteinerHor])
        conteinerHor.addArrangedSubviews([temperatureLable, separator,statusLable])
        //TODO: - add separator
        
        constraints()
        
    }
    
    //MARK: - Constraints
    
    private func constraints() {
        
        self.conteinerVert.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
        
        self.imageView.snp.updateConstraints{ (make) in
            make.size.equalTo(self.imageSize)
        }
        
        self.separator.snp.updateConstraints { (make) in
            make.size.equalTo(self.separatorSize)
        }
        
    }
    
    
    //MARK: - Methods
    //переделать, не должны знать о модели. Нужно чтобы просто передавалиcь string
    func setContent(model: CurrentWeather) {
        //self.imageView.image = UIImage(named: "snow-main")
        self.sityLable.text = model.name
        self.temperatureLable.text = String(Int(model.main.temp - 273)) + " C"
        self.statusLable.text = model.weather.first?.main
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    
    
}
