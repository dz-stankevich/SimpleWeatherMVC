//
//  WeatherCell.swift
//  SimpleWeather
//
//  Created by Дмитрий Станкевич on 23.01.22.
//

import Foundation
import SnapKit
import UIKit

class WeatherCell: UITableViewCell {
    //MARK: - Identifier
    static let reuseIdentifier = "SimpleWeatherIdentifier"
    
    //MARK: - Varibless
    
    private let imageSize = CGSize(width: 80, height: 80)
    
    private var edgeInsets = UIEdgeInsets(all: 10) {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }
    private var contentEdgeInsets = UIEdgeInsets(all: 16)
    
    //MARK: GUI Varibles
    private lazy var rootContainer = UIView()
    
    private lazy var imageConteiner = UIView()
    
    private lazy var image = UIImageView()
    
    private lazy var contentConteiner = UIView()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private lazy var temprLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 50)
        
        return label
    }()

    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.backgroundColor = .systemGray
        self.contentView.addSubview(rootContainer)
        self.rootContainer.addSubview(self.imageConteiner)
        self.rootContainer.addSubview(self.contentConteiner)
        
        self.imageConteiner.addSubview(self.image)
        
        self.contentConteiner.addSubview(self.timeLabel)
        self.contentConteiner.addSubview(self.weatherLabel)
        self.contentConteiner.addSubview(self.temprLabel)
        
        self.constraints()
        
    }
    
    private func initCellStyle() {
        self.rootContainer.layer.shadowOffset = CGSize(width: 1, height: 1)
        //self.rootContainer.layer.shadowColor = UIColor.darkGray.cgColor
        self.rootContainer.layer.shadowOpacity = 0.3
        
    
        self.rootContainer.layer.borderWidth = 1
        self.rootContainer.layer.borderColor = UIColor.black.cgColor
    }
    
    //MARK: - Constraints
    private func constraints() {
        self.rootContainer.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
        
        self.imageConteiner.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(self.imageConteiner.snp.height)
        }
        
        self.image.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(self.imageSize)
        }
        
        self.contentConteiner.snp.updateConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(self.imageConteiner.snp.right)
        }
        
        self.timeLabel.snp.updateConstraints { (make) in
            make.top.left.equalToSuperview().inset(self.edgeInsets)
            make.right.lessThanOrEqualTo(self.temprLabel.snp.left).offset(16)
            
        }
        
        self.weatherLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.timeLabel.snp.bottom).offset(16)
            make.left.bottom.equalToSuperview().inset(self.edgeInsets)
            //make.right.greaterThanOrEqualTo(self.temprLabel.snp.left).inset(self.edgeInsets)
        }
        
        self.temprLabel.snp.updateConstraints { (make) in
            make.left.lessThanOrEqualTo(self.timeLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(self.edgeInsets)
            make.centerY.equalTo(self.contentConteiner.snp.centerY)
        }
        
        super.updateConstraints()
        
    }
    
    //MARK: - Methods
    
    func setCell(time: String, weather: String, tempr: String) {
        //self.image.image = UIImage(named: "snow-main")
        self.timeLabel.text = time
        self.weatherLabel.text = weather
        self.temprLabel.text = "\(tempr)C"
        
        self.needsUpdateConstraints()
    }
    
    func setCellImage(image: UIImage) {
        self.image.image = image
    }
    
}

