//
//  ViewController.swift
//  ScrollViewImager
//
//  Created by Romain Menke on 29/09/15.
//  Copyright © 2015 menke dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {    
    var collectionView: UICollectionView!
    var cellsInSection : Int = 0
    var numberOfSections : Int = 0
    
    var screenshotView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func viewDidAppear(_ animated: Bool) {
        collectionVIewSetup()
    }
    
    // SCREENSHOT
    @IBAction func captureScreenshot(sender: AnyObject) {
        
        // check if collectionview is showing
        if collectionView.superview == nil {
            
            // if not -> add it and remove the screenshotView
            self.view.addSubview(collectionView)
            self.screenshotView.removeFromSuperview()
            
        } else {
            
            // set up screenshotView and add mockUp
            self.screenshotView = UIImageView(frame: self.collectionView.frame)
            self.screenshotView.image = collectionView.mockup
            self.view.addSubview(self.screenshotView)
            
            // remove collectionview from super
            collectionView.removeFromSuperview()
            
            
//            self.screenshotView.image = self.collectionView.screenshot(0.1)
//            self.screenshotView.contentMode = UIViewContentMode.ScaleAspectFit
            
            
            // generate screenshot
            self.collectionView.screenshot(scale: 0.1) { (screenshot) -> Void in
                
                // display screenshot
                self.screenshotView.image = screenshot // this apparently has no trouble accepting an optional : Hooray!
                self.screenshotView.contentMode = UIViewContentMode.scaleAspectFit
                
            }

        }
    }
    
    private func collectionVIewSetup() {
        let collWidth = self.view.bounds.size.width
        let cellWidth : CGFloat = 50 + 5
        
        cellsInSection = Int(collWidth / cellWidth)
        numberOfSections = Int(256 / cellsInSection)
        
        collectionView = UICollectionView(frame: CGRect(x: 0.0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 100), collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(collectionView)
        
        collectionView.reloadData()
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellsInSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as? CollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath)
            return cell
        }
        
        let cellNumber = indexPath.section * cellsInSection + indexPath.row + 1
        
        let blue : CGFloat = CGFloat(cellNumber) / 256
        
        cell.backgroundColor = .red
        
        return cell
    }
    
}
