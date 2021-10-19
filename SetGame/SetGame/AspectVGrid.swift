//
//  AspectVGrid.swift
//  SetGame
//
//  Created by Zachary Steinbrenner on 10/4/21.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView // Sort of dont care. ItemView must behave as view
    
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        // Increment column count until every card fits and then calulate width based off aspect ratio
        // 1. Calculate width based off current columnCount
        // 2. Calculate what the height should be to keep given aspect ratio
        // 3. Check if all are rows fit in the view space
        // 4. Otherwise increment columnt count
        // 5. Calculate new row count
        // Repeat
        repeat {
            let itemWidth = size.width / CGFloat(columnCount) // Width of view that we are given
            let itemHeight = itemWidth / itemAspectRatio // Aspect ratio is width / height.
            if CGFloat(rowCount) * itemHeight < size.height { // Check that all cards fit without scrolling
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
            
        } while columnCount < itemCount
        
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}

