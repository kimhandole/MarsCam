//
//  RoverChoiceViewController.swift
//  MarsPhotoCatcher
//
//  Created by Han Dole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class RoverChoiceViewController: UIViewController {
    
    private let topLabel: UILabel = {
        let lbl = BaseLabel(text: "Choose a Mars Rover", font: .Title, textAlignment: .center, textColor: .white, numberOfLines: 1)
        return lbl
    }()
    
    private let roverImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "mars-rover")
        return iv
    }()
    
    private lazy var curiosityButton: BaseButton = {
        let btn = BaseButton(title: "Curiosity", titleColor: .white, backgroundColor: .Accent, font: .Regular)
        btn.addTarget(self, action: #selector(roverButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var opportunityButton: BaseButton = {
        let btn = BaseButton(title: "Opportunity", titleColor: .white, backgroundColor: .Accent, font: .Regular)
        btn.addTarget(self, action: #selector(roverButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var spiritButton: BaseButton = {
        let btn = BaseButton(title: "Spirit", titleColor: .white, backgroundColor: .Accent, font: .Regular)
        btn.addTarget(self, action: #selector(roverButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private func setupTopLabel() {
        // Top Label Constraints
        view.add(subview: topLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: 20)
            ]
        }
    }
    
    private func setupRoverImage() {
        // Rover Image Constraints
        view.add(subview: roverImageView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.topAnchor.constraint(equalToSystemSpacingBelow: topLabel.bottomAnchor, multiplier: 4),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.36),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.36)
            ]
        }
    }
    
    private func setupCuriosityButton() {
        // Curiosity Button Constraints
        view.add(subview: curiosityButton) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 24),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -24),
            v.heightAnchor.constraint(equalToConstant: 55)
            ]
        }
    }
    
    private func setupOpportunityButton() {
        // Opportunity Button Constraints
        view.add(subview: opportunityButton) { (v, p) in [
            v.topAnchor.constraint(equalTo: curiosityButton.bottomAnchor, constant: 30),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 24),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -24),
            v.heightAnchor.constraint(equalToConstant: 55)
            ]
        }
    }
    
    private func setupSpiritButton() {
        // Spirit Button Constraints
        view.add(subview: spiritButton) { (v, p) in [
            v.topAnchor.constraint(equalTo: opportunityButton.bottomAnchor, constant: 30),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 24),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -24),
            v.heightAnchor.constraint(equalToConstant: 55)
            ]
        }
    }
    
    @objc private func roverButtonTapped(_ sender: BaseButton) {
        let dateChoiceVC = DateChoiceViewController()
        dateChoiceVC.rover = (sender.titleLabel?.text)!
        let navigationDateChoiceVC = UINavigationController(rootViewController: dateChoiceVC)
        present(navigationDateChoiceVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Mars Rover"
        self.view.backgroundColor = .Background
        
        setupTopLabel()
        
        setupRoverImage()
        
        setupCuriosityButton()
        
        setupOpportunityButton()
        
        setupSpiritButton()
    }
    
    // Disable Rotation of UIViewController
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
