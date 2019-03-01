//
//  MarsPhotoViewContoller.swift
//  MarsPhotoCatcher
//
//  Created by Han Dole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class MarsPhotoViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var rover: String = ""
    var date: Date = Date()
    
    var marsPhotos: [MarsPhoto]?
    var marsPhotoImageView: UIImageView?
    
    var dateBackButton: UIBarButtonItem?
    
    // variables for animation
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    
    
    private func dateToString(from date: Date, format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: date)
    }
    
    private func noPhotosFoundAlert() {
        DispatchQueue.main.async {
            let date = self.dateToString(from: self.date, format: "MMM d, yyyy")
            let alert = UIAlertController(title: "No Photos Found", message: "No photos were taken on \(date) by \(self.rover). Please choose another date.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @objc private func dateBackButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func backButtonTapped() {
        zoomOut()
    }
    
    @objc private func shareButtonTapped() {
        let activityController = UIActivityViewController(activityItems: [zoomImageView.image!], applicationActivities: nil)
        
        activityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        DispatchQueue.main.async {
            self.present(activityController, animated: true, completion: nil)
        }
    }
    
    // Fetch JSON object
    private func fetchMarsPhotos(rover: String, date: String) {
        
        let basePath = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
        let url = basePath + rover + "/photos?earth_date=" + date + "&api_key=8BVKWHbxisG8L4zgUTGEgjJisEmyeg3neYyAEdhZ"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Network Connection Fail", message: "There was a network connection problem. Please check your connection and try again.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
                
                //print("Failed to get data from url: ", error)
                return
            }
            
            guard let data = data else { return }
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                    
                    self.marsPhotos = [MarsPhoto]()
                    let dataArray = jsonResult["photos"] as! NSArray
                    for item in dataArray {
                        let obj = item as! NSDictionary
                        let id = obj["id"] as! Int
                        let camera = obj["camera"] as! NSDictionary
                        let cameraName = camera["full_name"] as! String
                        let imageSource = obj["img_src"] as! String
                        let marsPhoto = MarsPhoto(id: id, cameraName: cameraName, imageSource: imageSource)
                        self.marsPhotos?.append(marsPhoto)
                    }
                }
                // No Photos Found
                if self.marsPhotos?.count == 0 {
                    self.noPhotosFoundAlert()
                    return
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    @objc func zoomOut() {
        if let startingFrame = marsPhotoImageView!.superview?.convert(marsPhotoImageView!.frame, to: nil) {
            
            
            UIView.animate(withDuration: 0.75, animations: { () -> Void in
                self.zoomImageView.frame = startingFrame
                
                self.blackBackgroundView.alpha = 0
            }, completion: { (didComplete) -> Void in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.marsPhotoImageView?.alpha = 1
            })
        }
        // Pop Out Share Button
        self.navigationItem.rightBarButtonItem = nil
        // Push In Date Back Button
        self.navigationItem.leftBarButtonItem = dateBackButton
    }
    
    func animateImageView(marsPhotoImageView: UIImageView) {
        self.marsPhotoImageView = marsPhotoImageView
        
        if let startingFrame = marsPhotoImageView.superview?.convert(marsPhotoImageView.frame, to: nil) {
            
            marsPhotoImageView.alpha = 0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = .black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = marsPhotoImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75) { () -> Void in
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
            }
        }
        // Push In Share Button
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        self.navigationItem.rightBarButtonItem = shareButton
        // Push In Back Button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .Background
        
        // Navigation Bar Setup
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        let dateButtonString = dateToString(from: date, format: "MMM d, yyyy")
        dateBackButton = UIBarButtonItem(title: dateButtonString, style: .plain, target: self, action: #selector(dateBackButtonTapped))
        navigationItem.leftBarButtonItem = dateBackButton
        
        navigationItem.title = rover
        
        let dateString = dateToString(from: date, format: "yyyy-MM-dd")
        fetchMarsPhotos(rover: rover, date: dateString)
        
        collectionView.register(MarsPhotoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marsPhotos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MarsPhotoCell
        
        cell.marsPhoto = marsPhotos?[indexPath.item]
        cell.marsPhotoVC = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = collectionView.cellForItem(at: indexPath) as? MarsPhotoCell
    }
    
    // Disable Rotation of UIViewController
    override open var shouldAutorotate: Bool {
        return false
    }
}
