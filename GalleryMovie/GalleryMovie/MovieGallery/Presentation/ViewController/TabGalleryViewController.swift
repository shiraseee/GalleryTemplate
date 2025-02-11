//
//  ViewController.swift
//  GalleryMovie
//
//  Created by Michel Tan on 14/01/2025.
//

import UIKit

class TabGalleryViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupController()
    }
    
    func setupController() {
        // Onglet 1 : Galerie (Storyboard principal)
        let otherStoryboard = UIStoryboard(name: "MovieGallery", bundle: nil)
        let otherVC = otherStoryboard.instantiateViewController(withIdentifier: "MovieGallery")//MovieGalleryController
        otherVC.tabBarItem = UITabBarItem(title: "Gallery", image: UIImage(systemName: "photo.on.rectangle"), tag: 0)
        viewControllers = [
            UINavigationController(rootViewController: otherVC)]
        
       /* // Onglet 2 : Contrôleur chargé depuis un autre Storyboard
        let otherStoryboard = UIStoryboard(name: "OtherStoryboard", bundle: nil)
        let otherVC = otherStoryboard.instantiateViewController(withIdentifier: "OtherViewController")
        otherVC.tabBarItem = UITabBarItem(title: "Other", image: UIImage(systemName: "star"), tag: 1)
        
        // Ajout des contrôleurs à la Tab Bar
        viewControllers = [
            UINavigationController(rootViewController: galleryVC),
            UINavigationController(rootViewController: otherVC)
        ]*/
    }

}

