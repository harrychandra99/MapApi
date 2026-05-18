//
//  WeatherItemCell.swift
//  WeatherApi
//
//  Created by Kalvin on 17/05/26.
//
import UIKit

class WeatherItemCell: UITableViewCell {
    
    static let identifier = "WeatherItemCell"
    
    private let timeLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()
    private let badgeStack = UIStackView()
    private let maxBadge = UILabel()
    private let minBadge = UILabel()
    private let deleteButton = UIButton(type: .system)
    
    var onDeleteItem: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
        
    }
    required init?(coder: NSCoder) {fatalError()}
    
}

extension WeatherItemCell {
    private func setupCellUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        timeLabel.font = .systemFont(ofSize: 16, weight: .black)
        timeLabel.textColor = .label
        
        tempLabel.font = .systemFont(ofSize: 24, weight: .black)
        tempLabel.textColor = .label
        
        [maxBadge, minBadge].forEach{
            $0.font = .systemFont(ofSize: 9, weight: .black)
            $0.textAlignment = .center
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
        }
        
        maxBadge.textColor = .systemRed
        maxBadge.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
        minBadge.textColor = .systemBlue
        minBadge.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .systemRed
        deleteButton.addTarget(self, action: #selector(deleteItemTapped), for: .touchUpInside)
        
        [deleteButton, timeLabel, iconView, tempLabel, maxBadge, minBadge].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 44),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            
            timeLabel.leadingAnchor.constraint(equalTo: deleteButton.trailingAnchor, constant: 8),
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            iconView.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 15),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 26),
            iconView.heightAnchor.constraint(equalToConstant: 26),
            
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            
            maxBadge.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 4),
            maxBadge.trailingAnchor.constraint(equalTo: minBadge.leadingAnchor, constant: -4),
            maxBadge.widthAnchor.constraint(equalToConstant: 42),
            maxBadge.heightAnchor.constraint(equalToConstant: 18),
            maxBadge.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            minBadge.trailingAnchor.constraint(equalTo: tempLabel.trailingAnchor),
            minBadge.centerYAnchor.constraint(equalTo: maxBadge.centerYAnchor),
            minBadge.widthAnchor.constraint(equalToConstant: 42),
            minBadge.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}

extension WeatherItemCell {
    @objc private func deleteItemTapped() {
        onDeleteItem?()
    }
    
    func configure(item: WeatherItemEntity) {
        timeLabel.text = item.time.isEmpty ? "--:--" : item.time
        
        tempLabel.text = item.temperature
        maxBadge.text = "▲ \(item.temperatureMax)"
        minBadge.text = "▼ \(item.temperatureMin)"
        
        let weather = item.mainWeather.lowercased()
        
        var iconStyle: Constant.WeatherIcon = .cloud
        var iconColor: UIColor = .systemGray
        
        switch weather {
        case _ where weather.contains("clear"):
            iconStyle = .sun
            iconColor = .systemOrange
            
        case _ where weather.contains("moon") || weather.contains("night"):
            iconStyle = .moon
            iconColor = .systemIndigo
            
        case _ where weather.contains("clouds") && (weather.contains("few") || weather.contains("scattered") || weather.contains("broken")):
            iconStyle = .cloudSun
            iconColor = .systemGray
            
        case _ where weather.contains("cloud"):
            iconStyle = .cloud
            iconColor = .systemGray
            
        case _ where weather.contains("rain") || weather.contains("drizzle"):
            iconStyle = .cloudRain
            iconColor = .systemBlue
            
        case _ where weather.contains("thunderstorm") || weather.contains("storm"):
            iconStyle = .storm
            iconColor = .systemYellow
            
        case _ where weather.contains("snow"):
            iconStyle = .snow
            iconColor = .systemTeal
            
        default:
            iconStyle = .cloud
            iconColor = .systemGray
        }
        
        iconView.image = UIImage(systemName: iconStyle.rawValue)
        iconView.tintColor = iconColor
    }
}
