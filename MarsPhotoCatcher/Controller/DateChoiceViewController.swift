//
//  DateChoiceViewController.swift
//  MarsPhotoCatcher
//
//  Created by Han Dole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class DateChoiceViewController: UIViewController {
    
    var rover: String = ""
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        return df
    }()
    
    private let topLabel: UILabel = {
        let lbl = BaseLabel(text: "Choose an Earth Date", font: .Title, textAlignment: .center, textColor: .white, numberOfLines: 1)
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
        let btn = BaseButton(title: "Submit", titleColor: .white, backgroundColor: .red, font: .Regular)
        btn.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
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
    
    private func setupCalendarImage() {
        // Rover Image Constraints
        view.add(subview: calendarImageView) { (v, p) in [
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.topAnchor.constraint(equalToSystemSpacingBelow: topLabel.bottomAnchor, multiplier: 4),
            v.heightAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.345),
            v.widthAnchor.constraint(equalTo: p.widthAnchor, multiplier: 0.345)
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
        if !dateRangeCheck() {
            return
        } else {
            let layout = UICollectionViewFlowLayout()
            let marsPhotoVC = MarsPhotoViewController(collectionViewLayout: layout)
            marsPhotoVC.rover = rover
            marsPhotoVC.date = datePicker.date
            let navigationMarsPhotoVC = UINavigationController(rootViewController: marsPhotoVC)
            present(navigationMarsPhotoVC, animated: true, completion: nil)
        }
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
    
    private func dateRangeCheck() -> Bool {
        let date = datePicker.date
        if rover == "Curiosity" {
            let dateMin = formatter.date(from: "2012-08-05 00:00")
            if dateMin! > date {
                noPhotoRangeAlert()
                return false
            }
        } else if rover == "Opportunity" {
            let dateMin = formatter.date(from: "2004-01-25 00:00")
            let dateMax = formatter.date(from: "2019-02-13 00:00")
            if (dateMin! > date) || (dateMax! < date) {
                noPhotoRangeAlert()
                return false
            }
        } else {
            let dateMin = formatter.date(from: "2004-01-04 00:00")
            let dateMax = formatter.date(from: "2010-03-22 00:00")
            if (dateMin! > date) || (dateMax! < date) {
                noPhotoRangeAlert()
                return false
            }
        }
        return true
    }
    
    private func noPhotoRangeAlert() {
        DispatchQueue.main.async {
            var message = ""
            if self.rover == "Curiosity" {
                message = " landed on Mars on August 5, 2012 and still active. "
            } else if self.rover == "Opportunity" {
                message = " landed on Mars on January 25, 2004 and ended mission on February 13, 2019. "
            } else {
                message = " landed on Mars on January 4, 2004 and stopped communicationg with Earth on March 22, 2010 after it got stuck in a sand trap. "
            }
            let alert = UIAlertController(title: "Date Out of Range", message: "\(self.rover)" + message + "Please choose another date.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                //self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .Background
        
        // Navigation Bar Setup
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: rover, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.title = "Earth Date"
        
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
