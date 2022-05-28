//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Сергей Завьялов on 05.04.2022.
//
// Экран с профилем:
// При нажатии на кнопку Set status необходимо реализовать проверку на пустой UITextFiled с установкой статуса, по аналогии с логинкой.
// При нажатии на UILabel с лайками количество лайков должно увеличиваться.
// При нажатии на картинку с постом должна презентоваться View с детальным описанием этого поста. При этом в UILabel с количеством
// просмотров должен быть увеличен счетчик просмотром на 1.
// Задача со ★:
// Реализовать возможность удаления ячейки с постом по свайпу.

import UIKit

class ProfileViewController: UIViewController {
    
    var delegate: ProfileViewControllerDataSource?
    
    private var postModel: [PostModel] = PostModel.makeMockModel()
    private var postLikes: Int = 0
    private var postViewes: Int = 0
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        $0.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.identifier)
        $0.backgroundColor = .systemBackground
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupLayout() {
        [tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : postModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier,
                                                     for: indexPath) as! PhotosTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier,
                                                     for: indexPath) as! PostTableViewCell
            cell.setupCell(index: indexPath.row, post: postModel[indexPath.row])
            cell.selectionStyle = .none
            cell.delegate = self
            self.delegate = cell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Тап по ячейке убран по просьбе проверяющего
        // if indexPath.section == 0 {
        //    self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        //    return
        // } else {
        if indexPath.section == 1 {
            let detailPostViewController = DetailPostViewController()
            detailPostViewController.setupVC(index: indexPath.row, post: postModel[indexPath.row])
            navigationController?.pushViewController(detailPostViewController, animated: true)
            detailPostViewController.delegate = self
            return
        }
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.identifier) as! ProfileHeaderView
        header.delegate = self
        return section == 0 ? header : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 220 : 0
    }
}

// MARK: - PhotosViewDelegate

extension ProfileViewController: PhotosTableViewDelegate {
    func rightArrowImagePressed() {
        self.navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
}

// MARK: - PostTableViewCellDelegate

extension ProfileViewController: PostTableViewCellDelegate {
    func likePostPressed(index: Int, likes: Int, isLike: Bool) {
        postModel[index].isLiked = isLike
        postModel[index].likes = likes
    }
}

// MARK: - DetailPostViewDelegate

extension ProfileViewController: DetailPostViewDelegate {
    
    func postViewed(index: Int, viewes: Int) {
        postModel[index].views = viewes
        self.delegate?.postViewed(viewes: viewes)
        tableView.reloadData()
    }
    func likeDetailPostPressed(index: Int, likes: Int, isLike: Bool) {
        postModel[index].isLiked = isLike
        postModel[index].likes = likes
        self.delegate?.postLiked(likes: postModel[index].likes, isLike: postModel[index].isLiked)
        tableView.reloadData()
    }
}

// MARK: - ProfileHeaderViewDelegate

extension ProfileViewController: ProfileHeaderViewDelegate {
    
    func userInteractionEnabled() {
        tableView.isScrollEnabled = true
        tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
        tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = true
    }
    
    func userInteractionDisabled() {
        tableView.isScrollEnabled = false
        tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
        tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = false
    }
}


