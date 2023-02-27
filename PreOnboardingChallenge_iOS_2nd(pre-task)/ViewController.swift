//
//  ViewController.swift
//  PreOnboardingChallenge_iOS_2nd(pre-task)
//
//  Created by Kennadi on 2023/02/27.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        for i in 1...5 {
            stackView.addArrangedSubview(addLoadImageContainerView(tag: i))
        }
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0).isActive = true
        
        let loadAllButton = UIButton()
        loadAllButton.setTitle("Load All Images", for: .normal)
        loadAllButton.backgroundColor = .systemBlue
        loadAllButton.layer.cornerRadius = 6
        loadAllButton.clipsToBounds = true
        loadAllButton.addTarget(self, action: #selector(didTapLoadAllButton), for: .touchUpInside)
        
        view.addSubview(loadAllButton)
        loadAllButton.translatesAutoresizingMaskIntoConstraints = false
        loadAllButton.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        loadAllButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        loadAllButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        loadAllButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20.0).isActive = true
    }

    func addLoadImageContainerView(tag: Int) -> UIView {
        let containerView = UIView()
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.tag = tag
        
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progress = 0.5
        
        let loadButton = UIButton()
        loadButton.setTitle("Load", for: .normal)
        loadButton.backgroundColor = .systemBlue
        loadButton.layer.cornerRadius = 6
        loadButton.clipsToBounds = true
        loadButton.tag = tag
        loadButton.addTarget(self, action: #selector(didTapLoadButton), for: .touchUpInside)
        
        containerView.addSubview(imageView)
        containerView.addSubview(progressBar)
        containerView.addSubview(loadButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5.0).isActive = true
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2.0).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: loadButton.leadingAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        loadButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        loadButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        loadButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        return containerView
    }
    
    @objc func didTapLoadButton(sender: UIButton!) {
        for targetView in stackView.arrangedSubviews {
            
            for subView in targetView.subviews {
                guard var imageView = subView as? UIImageView else { continue }
                
                if imageView.tag == sender.tag {
                    if let url = URL(string: "https://mblogthumb-phinf.pstatic.net/20160212_41/jung0744_1455253447323fwhR8_JPEG/11101008_40.jpg?type=w800") {
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                          // Error handling...
                          guard let imageData = data else { return }
                            
                            print(imageData, "...download completed")
                            
                          DispatchQueue.main.async {
                              imageView.image = nil
                              imageView.image = UIImage(data: imageData, scale: 40.0)
                          }
                        }.resume()
                      }
                    
                    break
                }
            }
        }
    }
    
    @objc func didTapLoadAllButton(sender: UIButton!) {
        for targetView in stackView.arrangedSubviews {
            
            for subView in targetView.subviews {
                guard var imageView = subView as? UIImageView else { continue }
                
                if let url = URL(string: "https://mblogthumb-phinf.pstatic.net/20160212_41/jung0744_1455253447323fwhR8_JPEG/11101008_40.jpg?type=w800") {
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                      // Error handling...
                      guard let imageData = data else { return }
                        
                        print("imageView tag: ", imageView.tag, " ", imageData, "...download completed")
                        
                      DispatchQueue.main.async {
                          imageView.image = UIImage(data: imageData, scale: 40.0)
                      }
                    }.resume()
                  }
            }
        }
    }

}

