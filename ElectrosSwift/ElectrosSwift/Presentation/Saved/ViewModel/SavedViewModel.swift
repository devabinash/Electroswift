//
//  SavedViewModel.swift
//  ElectronicsStoreSwift
//
//  Created by Pinto Junior, William James on 27/07/22.
//

import Foundation
import RxRelay

class SavedViewModel {
    // MARK: - Constants
    let userDefaults = UserDefaultsManagemen()
    
    // MARK: - Variables
    var savedData = BehaviorRelay<[Product]>(value: [])
    
    // MARK: - Init
    public init() {
    }
    
    func getData() {
        let savedUD = userDefaults.getSaved()
        savedData.accept(savedUD)
    }
}
