//
//  CollectionView.swift
//  PaginationWithCollectionViewandTableView
//
//  Created by Muhammad Abdullah Al Mamun on 11/10/20.
//

import UIKit

class CollectionView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var itemsArray = [String]()

    var loadingView: LoadingReusableView?

    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        //Register Item Cell
        let itemCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(itemCellNib, forCellWithReuseIdentifier: "CollectionViewCell")

        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingresuableviewid")

      
        loadData()
    }


    func loadData() {
        isLoading = false
        collectionView.collectionViewLayout.invalidateLayout()
        for i in 1...30 {
            //Add random color in the array
            self.itemsArray.append("Item \(i)")
        }
        self.collectionView.reloadData()
    }

}
extension CollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.itemLabel.text = self.itemsArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == itemsArray.count - 10 && !self.isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            let start = itemsArray.count
            let end = start + 10
            DispatchQueue.global().async {
                // fake background loading task
                sleep(2)
                for i in start...end {
                    self.itemsArray.append("Item \(i)")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width/3, height: 135)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! LoadingReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}
