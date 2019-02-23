//
//  DateChoiceViewController.swift
//  MarsPhotoCatcher
//
//  Created by Handole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class DateChoiceViewController: UIViewController {
    
    var rover: String = ""
    
    private let topLabel: UILabel = {
        let lbl = BaseLabel(text: "Choose a Date", font: .Title, textAlignment: .center, textColor: .white, numberOfLines: 1)
        return lbl
    }()
    
    private let calendarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "calendar")
        return iv
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.timeZone = NSTimeZone.local
        dp.backgroundColor = .Accent
        dp.setValue(UIColor.white, forKey: "textColor")
        dp.layer.cornerRadius = 6
        dp.layer.masksToBounds = true
        dp.datePickerMode = .date
        let today = Calendar.current.startOfDay(for: Date())
        dp.maximumDate = today
        dp.date = today
        return dp
    }()
    
    private lazy var submitButton: BaseButton = {
        let btn = BaseButton(title: "Submit", titleColor: .white, backgroundColor: .red, font: .Semibold)
        btn.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private func setupTopLabel() {
        // Top Label Constraints
        view.add(subview: topLabel) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor, constant: 16)
            ]
        }
    }
    
    private func setupCalendarImage() {
        // Rover Image Constraints
        view.add(subview: calendarImageView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 24),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.3),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.3)
            ]
        }
    }
    
    private func setupDatePicker() {
        // Date Picker Constraints
        view.add(subview: datePicker) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.centerYAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 24),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -24),
            v.heightAnchor.constraint(equalToConstant: 180)
            ]
        }
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func submitButtonTapped() {
        let layout = UICollectionViewFlowLayout()
        let marsPhotoVC = MarsPhotoViewController(collectionViewLayout: layout)
        marsPhotoVC.rover = rover
        marsPhotoVC.date = datePicker.date
        let navigationMarsPhotoVC = UINavigationController(rootViewController: marsPhotoVC)
        present(navigationMarsPhotoVC, animated: true, completion: nil)
    }
    
    private func setupSubmitButton() {
        // Submit Button Constraints
        view.add(subview: submitButton) { (v, p) in [
            v.bottomAnchor.constraint(equalTo: p.bottomAnchor, constant: -36),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor, constant: 24),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor, constant: -24),
            v.heightAnchor.constraint(equalToConstant: 55)
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .Background
        
        // Navigation Bar Setup
        navigationController?.navigationBar.barStyle = .black
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: rover, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.title = "Date"
        
        setupTopLabel()
        
        setupCalendarImage()
        
        setupDatePicker()
        
        setupSubmitButton()
    }
    
    // Disable Rotation of UIViewController
    override open var shouldAutorotate: Bool {
        return false
    }
}
