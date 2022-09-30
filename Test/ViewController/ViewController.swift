//
//  ViewController.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getProducts()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        var cell = UINib(nibName: "CatalogCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "cell")
    }
    
    func updateUI(product: [Product]){
        products = product
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ViewController{
    func getProducts(){
        NetworkManager.shared.getProducts { (result: Result<[Product], Error>) in
            switch result{
            case .success(let data):
                self.updateUI(product: data)
            case .failure(_):
                print()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatalogCollectionViewCell
        var product = products[indexPath.row]
        cell.setupUI(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var device = UIDevice.current.localizedModel
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0
        print(device)
        if device == "iPhone"{
            width =  UIScreen.main.bounds.width - 40
            height = 204
        }else if device == "iPad"{
            height =  UIScreen.main.bounds.width * 711 / 466
            width = UIScreen.main.bounds.width * 466 / 711
        }
        return CGSize(width: width, height: height)
    }
}
