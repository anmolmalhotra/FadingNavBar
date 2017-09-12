//
//  ViewController.swift
//  NavBar
//
//  Created by Anmol Malhotra on 30/08/17.
//  Copyright © 2017 Anmol Malhotra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    let offsetThreshold: CGFloat = 64.0
    
    // MARK: - UI Components
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    // MARK: - View Will Appear
    // making nav bar transparent
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        makeNavBarTransparent()
    }
    
    // MARK: - View Will Disappear
    // checking if nav bar opacity is less than 1.0, if it is setting it to 1.0
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let offset = tableView.contentOffset.y / offsetThreshold
        
        if offset < 1.0 {
            setNavBarOpacity(alpha: 1.0)
        }
    }
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -64).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    // MARK: - Table View methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .red
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.width / 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = "I am \(indexPath.row + 1) cell."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let detailController = DetailController()
        detailController.navTitle = cell?.textLabel?.text
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: - Scroll View Did Scroll
    // trick for making a fading nav bar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        
        let alpha = offset / offsetThreshold
        
        if alpha > 0.0 {
            setNavBarOpacity(alpha: alpha)
        } else {
            makeNavBarTransparent()
        }
    }
    
    // MARK: - Making Nav Bar Transparent
    func makeNavBarTransparent() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Setting the opacity of nav bar image based on alpha
    func setNavBarOpacity(alpha: CGFloat) {
        
        let navBarColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alpha)
        let navBarSize = CGSize(width: view.frame.width, height: 64.0)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: navBarColor, size: navBarSize), for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
}

// MARK: - Generating UIImage from color - STACKOVERFLOW code
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






