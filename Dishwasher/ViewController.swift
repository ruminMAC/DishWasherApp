//
//  ViewController.swift
//  Dishwasher
//
//  Created by mac on 5/14/18.
//  Copyright © 2018 mobileappscompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DishwasherCellDelegate {
    
    @IBOutlet weak var dishwasherCollectionView: UICollectionView!
    var indicator = UIActivityIndicatorView()

    var products: [Dishwasher] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        DishwasherCollectionViewCell.delegate = self
        
        ProductService.getProducts(){ [unowned self] dishwashers in
            self.products = dishwashers
            //print(self.products)
            DispatchQueue.main.async {
                self.dishwasherCollectionView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishLoading(string: Bool) {
        
        if string == true
        {
            indicator.stopAnimating()
            self.indicator.hidesWhenStopped = true
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/2), height: 400.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DishwasherCollectionViewCell.identifier,
            for: indexPath)
        
        guard let dishwasherCell = cell as? DishwasherCollectionViewCell else {
            return cell
        }
    
        let dishwasher = products[indexPath.row]
        dishwasherCell.configure(with: dishwasher)
        
        return dishwasherCell
    }
}
