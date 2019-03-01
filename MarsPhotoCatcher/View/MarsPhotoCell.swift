//
//  MarsPhotoCell.swift
//  MarsPhotoCatcher
//
//  Created by Han Dole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class MarsPhotoCell: UICollectionViewCell {
    
    var marsPhoto: MarsPhoto? {
        didSet {
            idLabel.text = "id: " + String(marsPhoto!.id)
            cameraNameLabel.text = marsPhoto?.cameraName
            setupMarsPhotoImage()
        }
    }
    
    var marsPhotoVC: MarsPhotoViewController?
    
    lazy var marsPhotoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .Accent
        return v
    }()
    
    let idLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textColor = .white
        lbl.font = .Regular
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cameraNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .clear
        lbl.textColor = .gray
        lbl.font = .Footnote
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    @objc private func animate() {
        marsPhotoVC?.animateImageView(marsPhotoImageView: marsPhotoImageView)
    }
    
    private func setupViews() {
        addSubview(marsPhotoImageView)
        addSubview(separatorView)
        addSubview(idLabel)
        addSubview(cameraNameLabel)
        
        // Image Animation
        marsPhotoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: marsPhotoImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1]-0-[v2]-16-[v3(1)]|", views: marsPhotoImageView, idLabel, cameraNameLabel, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // idLabel Top Constraints
        addConstraint(NSLayoutConstraint(item: idLabel, attribute: .top, relatedBy: .equal, toItem: marsPhotoImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // idLabel Left Constraints
        addConstraint(NSLayoutConstraint(item: idLabel, attribute: .left, relatedBy: .equal, toItem: marsPhotoImageView, attribute: .left, multiplier: 1, constant: 0))
        // idLabel Right Constraints
        addConstraint(NSLayoutConstraint(item: idLabel, attribute: .right, relatedBy: .equal, toItem: marsPhotoImageView, attribute: .right, multiplier: 1, constant: 0))
        // idLabel Height Constraints
        addConstraint(NSLayoutConstraint(item: idLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        // cameraNameLabel Top Constraints
        addConstraint(NSLayoutConstraint(item: cameraNameLabel, attribute: .top, relatedBy: .equal, toItem: idLabel, attribute: .bottom, multiplier: 1, constant: 0))
        // cameraNameLabel Left Constraints
        addConstraint(NSLayoutConstraint(item: cameraNameLabel, attribute: .left, relatedBy: .equal, toItem: marsPhotoImageView, attribute: .left, multiplier: 1, constant: 0))
        // cameraNameLabel Right Constraints
        addConstraint(NSLayoutConstraint(item: cameraNameLabel, attribute: .right, relatedBy: .equal, toItem: marsPhotoImageView, attribute: .right, multiplier: 1, constant: 0))
        // cameraNameLabel Height Constraints
        addConstraint(NSLayoutConstraint(item: cameraNameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
    
    private func setupMarsPhotoImage() {
        if let imgSrc = marsPhoto?.imageSource {
            marsPhotoImageView.loadImageUsingUrlString(urlString: imgSrc)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
