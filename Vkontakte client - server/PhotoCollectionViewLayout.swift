//
//  PhotoCollectionViewLayout.swift
//  Vkontakte
//
//  Created by Сергей on 28.11.2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit

class PhotoCollectionViewLayout: UICollectionViewLayout {
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes] ()
    var columnsCount = 2
    var cellHeight: CGFloat = 146
    private var totalCellsHeight: CGFloat = 0
    
    override func prepare() {
        self.cacheAttributes = [:]
        
        guard let collectionView = self.collectionView else { return }
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }
        
        let cellWidth = collectionView.frame.width / CGFloat(self.columnsCount)
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
        
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let isCell = (index + 1) % (self.columnsCount + 1) == 0
            attributes.frame = CGRect(x: lastX, y: lastY, width: cellWidth, height: self.cellHeight)
            
            let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
            
            if isLastColumn {
                lastX = 0
                lastY += self.cellHeight
            } else {
                lastX += cellWidth
            }
            
        }
    }
    
}
