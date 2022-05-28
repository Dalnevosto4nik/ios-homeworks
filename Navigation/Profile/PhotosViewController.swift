//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.05.2022.
//
// Экран с коллекцией фото.
// При однократном нажатии на ячейку с фото реализовать анимацию, по аналогии с анимацией из последнего задания.

import UIKit

class PhotosViewController: UIViewController {
    
    private let photosModel: [PhotosModel] = PhotosModel.makeMockModel()
    
    private lazy var imagePosition = imageView.layer.position
    private lazy var imageBounds = imageView.layer.bounds
    
    private lazy var backView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.isUserInteractionEnabled = false
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    private lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 55
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.isUserInteractionEnabled = true
        $0.alpha = 0.0
        return $0
    }(UIImageView())
    
    // private lazy var closeButton: UIButton = {
    // $0.translatesAutoresizingMaskIntoConstraints = false
    // $0.setImage(UIImage(systemName: "multiply.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(colorSet, renderingMode: .alwaysOriginal), for: .normal)
    // $0.alpha = 0.0
    // $0.clipsToBounds = false
    // $0.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    // $0.isUserInteractionEnabled = false
    // return $0
    // }(UIButton())
    
    private lazy var layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 8
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.dataSource = self
        $0.delegate = self
        $0.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: self.layout))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tintColor = UIColor(ciColor: .init(color: colorSet))
        self.view.backgroundColor = .systemGray6
        self.title = "Photo Gallery"
        self.navigationItem.backButtonTitle = "Back"
        self.navigationController?.navigationBar.isHidden = false
        setupLayout()
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        navigationController?.setNavigationBarHidden(false, animated: animated)
    //    }
    
    private func setupLayout() {
        // [collectionView, backView, imageView, closeButton].forEach { view.addSubview($0) }
        [collectionView, backView, imageView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            // collectionView
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // backView
            backView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            // imageView
            imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            // closeAvatarImageButton
            // closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            // closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
        ])
    }
    
    @objc func tapImageAction() {
        
        UIImageView.animate(withDuration: 0.5,
                            animations: {
            self.backView.alpha = 0.8
            self.imageView.alpha = 1
            self.imageView.layer.cornerRadius = 0
            self.imageView.layer.borderWidth = 0
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.clipsToBounds = false
            self.imageView.backgroundColor = .black
            self.collectionView.isScrollEnabled = false
            self.collectionView.isUserInteractionEnabled = false
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) { [self] in
                let rightBarItem = UIBarButtonItem(image: UIImage(systemName: "multiply.circle"), style: .plain, target: self, action: #selector(self.tapToCloseAction))
                navigationItem.rightBarButtonItem = rightBarItem
                self.layout.collectionView?.layoutIfNeeded()
            }
        })
    }
    
    @objc private func tapToCloseAction() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            self.navigationItem.rightBarButtonItem = .none
            // self.closeButton.alpha = 0
            // self.closeButton.isUserInteractionEnabled = false
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0) {
                self.backView.alpha = 0
                self.imageView.alpha = 0
                self.imageView.isUserInteractionEnabled = true
                
                self.collectionView.isScrollEnabled = true
                self.collectionView.isUserInteractionEnabled = true
                self.layout.collectionView?.layoutIfNeeded()
            }
        }
    }
    
    private func setupBarItems() {
        let rightBarItem = UIBarButtonItem(image: UIImage(systemName: "multiply.circle"), style: .plain, target: self, action: #selector(tapToCloseAction))
        navigationItem.rightBarButtonItem = rightBarItem
    }
}



// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setupCell(photosModel[indexPath.row])
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - sideInset * 4) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.item)
        imageView.image = UIImage(named: photosModel[indexPath.row].image)
        tapImageAction()
    }
}
