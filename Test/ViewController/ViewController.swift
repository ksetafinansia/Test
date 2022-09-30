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
    var page: Int = 5
    var loading = false
    
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
        loading = true
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "limit", value: "\(page)")]
        NetworkManager.shared.getProducts(queryItem: queryItems, path: "/products",page: page) { (result: Result<[Product], Error>) in
            self.loading = false
            switch result{
            case .success(let data):
                self.updateUI(product: data)
            case .failure(_):
                print()
            }
        }
    }
    
    func fetchMoreProduct(){
        if !loading{
            page += 4
            getProducts()
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
            height = 140 * 320 / width
        }else if device == "iPad"{
            height =  UIScreen.main.bounds.width * 711 / 466
            width = UIScreen.main.bounds.width * 466 / 711
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            fetchMoreProduct()
        }
    }
    
}
