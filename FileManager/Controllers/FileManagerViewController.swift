//
//  FileManagerViewController.swift
//  FileManager
//
//  Created by Алексей Голованов on 30.10.2023.
//

import UIKit
import SnapKit

class FileManagerViewController: UIViewController {
    
    // MARK: - parametrs
    
    let coordinator: FileManagerCoordinator
    let fileManagerService: FileManagerServiceProtocol
    let settingsService = SettingsService.shared
    let directory: URL
    var documents: [Content] = []
    var imagePicker = ImagePicker()
    private lazy var documentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - initialization
    
    init(coordinator: FileManagerCoordinator, fileManagerService: FileManagerService, title: String = "", directory: URL) {
        self.coordinator = coordinator
        self.fileManagerService = fileManagerService
        self.directory = directory
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        getDocuments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDocuments()
    }
    
    // MARK: - targets
    
    @objc func addFilePressed(_ sender: UIBarButtonItem ) {
        imagePicker.show(coordinator: coordinator) { [weak self] imageURL in
            guard let self else { return }
            self.fileManagerService.copyItem(at: imageURL, to: self.directory)
            self.getDocuments()
        }
    }
    
    @objc func addFolderPressed(_ sender: UIBarButtonItem ) {
        coordinator.openNewFolder(viewController: self) { [weak self] nameFolder in
            guard let self else { return }
            self.fileManagerService.createDirectory(directory: self.directory, directoryName: nameFolder)
            self.getDocuments()
        }
    }
    
    // MARK: - functions
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItems = getRightBarButtonItems()
    }
    
    private func getRightBarButtonItems() -> [UIBarButtonItem] {
        let addFile = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addFilePressed(_:)))
        let addFolder = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addFolderPressed(_:)))
        return [addFile, addFolder]
    }
    
    private func addSubviews() {
        view.addSubview(documentsTableView)
    }
    
    private func setupConstraints() {
        documentsTableView.snp.makeConstraints { make in make.top.leading.trailing.bottom.equalToSuperview() }
    }
    
    private func getDocuments() {
        documents = fileManagerService.contentsOfDirectory(directory: directory)
        if settingsService.getSetting(setting: .sorting) {
            documents.sort { $0.name > $1.name }
        }
        documentsTableView.reloadData()
    }
}

extension FileManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()
        let document = documents[indexPath.row]
        content.text = document.name
        if !document.isDirectory && settingsService.getSetting(setting: .showPhotoSize) {
            content.secondaryText = document.size + " байт"
        }
        cell.contentConfiguration = content
        if documents[indexPath.row].isDirectory { cell.accessoryType = .disclosureIndicator }
        return cell
    }
}

extension FileManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let document = documents[indexPath.row]
        if !document.isDirectory { return }
        coordinator.openFolder(directory: directory, name: document.name)
    }
}
