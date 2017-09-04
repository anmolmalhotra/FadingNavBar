//
//  ViewController.swift
//  NavBar
//
//  Created by Anmol Malhotra on 30/08/17.
//  Copyright © 2017 Anmol Malhotra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let offsetThreshold:CGFloat = 64.0
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    func setNavBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func updateNavBarOpacity(alpha: CGFloat) {
        let navImage = UIImage(color: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alpha), size: CGSize(width: self.view.frame.width, height: 64))
        self.navigationController?.navigationBar.setBackgroundImage(navImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBarTransparent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateNavBarOpacity(alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -64).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        let alphaOffset = offset/offsetThreshold
        
        if alphaOffset > 1.0 && alphaOffset < 2.5 {
            let fadeTextAnimation = CATransition()
            fadeTextAnimation.duration = 0.5
            fadeTextAnimation.type = kCATransitionFade
            
            self.navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
            self.navigationItem.title = "Home"
        } else if alphaOffset < 1.0 {
            self.navigationItem.title = nil
        }
        
        if alphaOffset > 0.0 {
            updateNavBarOpacity(alpha: alphaOffset)
        } else {
            setNavBarTransparent()
        }
        
        if alphaOffset > 0.4 {
            self.navigationController?.navigationBar.shadowImage = nil
        } else {
            self.navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Office"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        header.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.width / 1.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = "Cell: \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailController = DetailController()
        detailController.controllerTitle = "Cell: \(indexPath.row)"
        navigationController?.pushViewController(detailController, animated: true)
    }

}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}







