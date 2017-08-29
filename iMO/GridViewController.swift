//
//  GridViewController.swift
//  iMO
//
//  Created by Ken Van den Enden on 25/8/17.
//  Copyright © 2017 Ken Van den Enden. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var itemsPerRow: CGFloat = 3
    fileprivate let reuseIdentifier = "work"
    
    var works: [Work]? {
        didSet {
            updateUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            if self.works != nil {
                self.spinner?.stopAnimating()
            }
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource protocol
extension GridViewController: UICollectionViewDataSource {
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = works?.count {
            return count
        } else {
            return 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! WorkCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if works != nil && indexPath.item <= works!.count {
            cell.work = works![indexPath.item]
        } else {
            cell.work = nil
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout protocol
extension GridViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

// MARK: - UICollectionViewDelegate protocol
extension GridViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as? WorkCollectionViewCell
        if let work = cell?.work {
            gotoWork(work)
        }
        
    }

    func gotoWork(_ work: Work) {
        if let vc = (self.storyboard?.instantiateViewController(withIdentifier: "detail")) as? WorkViewController {
            vc.work = work
            if let nav = self.navigationController {
                if nav.viewControllers.count > 20 {
                    nav.viewControllers.remove(at: 0)
                }
                nav.pushViewController(vc, animated: true)
            } else {
                present(vc, animated: true)
            }
        }
    }
}
