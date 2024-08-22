//
//  SavedViewController.swift
//  ElectronicsStoreSwift
//
//  Created by Pinto Junior, William James on 19/07/22.
//

import UIKit
import RxSwift

class SavedViewController: UIViewController {
    // MARK: - Constrants
    private let disposeBag = DisposeBag()
    private let reuseIdentifierHeader = "SavedHeader"
    private let reuseIdentifierFooter = "SavedFooter"
    
    // MARK: - Variables
    fileprivate var viewModel: SavedViewModel = {
        return SavedViewModel()
    }()
    fileprivate var savedData: [Product] = []
    
    // MARK: - Components
    fileprivate let stackBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    fileprivate let topBar: ScreenHeader = {
        let screenHeader = ScreenHeader()
        screenHeader.title = "Saved Items"
        return screenHeader
    }()
    
    fileprivate let emptyView: EmptyView = {
        let view = EmptyView()
        view.title = "Your have no saved item"
        view.isHidden = true
        return view
    }()
        
    fileprivate let collectionViewSaved: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getData()
    }
    
    // MARK: - Setup
    fileprivate func setupVC() {
        view.backgroundColor = UIColor(named: "Backgroud")
        
        self.viewModel.savedData.subscribe(onNext: { data in
            self.savedData = data
            self.collectionViewSaved.reloadData()
            self.setView()
        }).disposed(by: disposeBag)
        
        setView()  
        buildHierarchy()
        buildConstraints()
        setupCollection()
    }
    
    fileprivate func setupCollection() {
        collectionViewSaved.dataSource = self
        collectionViewSaved.delegate = self
        
        collectionViewSaved.register(SavedCollectionViewCell.self, forCellWithReuseIdentifier: SavedCollectionViewCell.resuseIdentifier)
        
        collectionViewSaved.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifierHeader)
        collectionViewSaved.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifierFooter)
    }

    // MARK: - Methods
    fileprivate func setView() {
        if self.savedData.count == 0 {
            self.collectionViewSaved.isHidden = true
            self.emptyView.isHidden = false
            return
        }
        self.collectionViewSaved.isHidden = false
        self.emptyView.isHidden = true
    }
    
    fileprivate func buildHierarchy() {
        view.addSubview(stackBase)
        stackBase.addArrangedSubview(topBar)
        stackBase.addArrangedSubview(collectionViewSaved)
        
        stackBase.addArrangedSubview(emptyView)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            stackBase.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackBase.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackBase.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackBase.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}


// MARK: - extension UICollectionViewDelegate
extension SavedViewController: UICollectionViewDelegate {
}

// MARK: - extension CollectionViewDataSource
extension SavedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.savedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedCollectionViewCell.resuseIdentifier, for: indexPath) as! SavedCollectionViewCell
        cell.settingCell(self.savedData[indexPath.row])
        return cell
    }
    
    // Header & Footer
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifierHeader, for: indexPath)
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifierFooter, for: indexPath)
            return footer
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

// MARK: - extension CollectionViewDelegateFlowLayout
extension SavedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
//        let height = collectionView.frame.height
        return CGSize(width: width, height: 150)
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 16)
    }
    
    // Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 32)
    }
}

