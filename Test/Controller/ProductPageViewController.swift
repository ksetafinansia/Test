//
//  ViewController.swift
//  Test
//
//  Created by Reyhan on 30/09/22.
//

import UIKit

class ProductPageViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Variable
    var products: [Product] = []
    var page: Int = 5
    var loading = false
    var alreadyGotAllDataFromAPI = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getProducts()
    }
    
    //MARK: Initial Setup
    func setupUI(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let cell = UINib(nibName: "CatalogCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "cell")
    }
    
    func updateUI(product: [Product]){
        if self.products.count == product.count{
            alreadyGotAllDataFromAPI = true
        }
        products = product
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ProductPageViewController{
    
    //MARK: Networking
    func getProducts(){
        loading = true
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "limit", value: "\(page)")]
        let path = APIEndpoint.Product.product
        NetworkManager.shared.fetch(queryItem: queryItems, path: path) { (result: Result<[Product], Error>) in
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
        //Check if there is no API call in progress and make sure there is still data to fetch
        if !loading && !alreadyGotAllDataFromAPI{
            page += 4
            getProducts()
        }
    }
}

extension ProductPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //MARK: UICollectionViewDelegate, DataSource, Implementation
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatalogCollectionViewCell
        let product = products[indexPath.row]
        cell.setupUI(product: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let device = UIDevice.current.localizedModel
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0
        if device == "iPhone"{
            width =  UIScreen.main.bounds.width - 40
            height = (140 / 320) * width
        }else if device == "iPad"{
            //Size below is gotten from Figma's iPad prototype adjusted to whatever iPad is used by  the user
            width = UIScreen.main.bounds.width *  0.62
            height =  width * (204 / 466)
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    //Infinite Scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            fetchMoreProduct()
        }
    }
    
}
