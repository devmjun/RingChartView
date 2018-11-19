//
//  ViewController.swift
//  Trigonometry
//
//  Created by Minjun Ju on 18/11/2018.
//  Copyright © 2018 Minjun Ju. All rights reserved.
import UIKit
class MainViewController: UIViewController {
    lazy var coordinate = PlaneCoordinates(bounds: view.bounds)
    
    var addDataButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("Add Data", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        return btn
    }()
    
    var changeAttributeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Attribute", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        return btn
    }()
    
    var stackView: UIStackView = {
        let stv = UIStackView()
        stv.axis = .vertical
        stv.distribution = .fillEqually
        stv.alignment = .fill
        stv.spacing = 10
        return stv
    }()
    
    lazy var ringChart = RingChartView(
        frame: view.bounds,
        data: [
            .dataAndColor(data: 10.0, color: .randomColor()),
            .dataAndColor(data: 20.0, color: .randomColor()),
            .dataAndColor(data: 30.0, color: .randomColor()),
            .dataAndColor(data: 40.0, color: .randomColor()),
            .dataAndColor(data: 50.0, color: .randomColor()),
            .dataAndColor(data: 60.0, color: .randomColor())
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ringChart)
        view.addSubview(stackView)
        stackView.addArrangedSubview(addDataButton)
        stackView.addArrangedSubview(changeAttributeButton)
        view.layer.addSublayer(coordinate)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addDataButton.addTarget(self, action: #selector(addDataButtonAction), for: .touchUpInside)
        changeAttributeButton.addTarget(self, action: #selector(changeAttributeButtonAction), for: .touchUpInside)
    }
    
    @objc func addDataButtonAction(_ sender: UIButton) {
        ringChart.data.append(.dataAndColor(data: 10.0, color: UIColor.black))
    }
    
    @objc func changeAttributeButtonAction(_ sender: UIButton) {
        ringChart.attributes = [NSAttributedString.Key.foregroundColor: UIColor.randomColor()]
    }
}

