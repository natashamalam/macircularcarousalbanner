//
//  LinkedList.swift
//  MACarousalBanner
//
//  Created by Mahjabin Alam on 2022/07/10.
//

import Foundation

class MAChainNode<T> {
    
    var item: T
    var next: MAChainNode?
    var prev: MAChainNode?
    
    init(item: T) {
        self.item = item
        self.next = nil
        self.prev = nil
    }
}

class MAChain<Item> {
    
    var head: MAChainNode<Item>?
    
    init() {
        self.head = nil
    }
    
    convenience init(items: [Item]) {
        self.init()
        for item in items {
            self.add(item: item)
        }
        makeCircular()
    }
    
    func makeCircular() {
        if count() > 0 {
            let tail = last()
            head?.prev = tail?.next
        }
    }
    
    func count() -> Int {
        if head == nil {
            return 0
        }
        var count = 1
        var current = head
        while current?.next != nil {
            current = current?.next
            count = count + 1
        }
        return count
    }
    
    func add(item: Item) {
        if head == nil {
            head = MAChainNode(item: item)
            return
        }
        let newNode = MAChainNode(item: item)
        
        var current = head
        while current?.next != nil {
            current = current?.next
        }
        
        let lastNode = current
        current?.next = newNode
        newNode.prev = lastNode
    }
    
    func removeLast() {
        if head?.next == nil {
            head = nil
        }
        var current = head
        while current?.next != nil {
            current = current?.next
        }
        let secondLast = current?.prev
        secondLast?.next = nil
    }
    
    func removeFirst() {
        if head == nil {
            return
        } else if head?.next == nil {
            head = nil
        } else {
            let secondToHead = head?.next
            secondToHead?.prev = nil
            head = secondToHead
        }
    }
    
    func first() -> MAChainNode<Item>? {
        guard let head = head else {
            return nil
        }
        return head
    }
    
    func last() -> MAChainNode<Item>? {
        if head == nil {
            return nil
        }
        var current = head
        while current?.next != nil {
            current = current?.next
        }
        return current
    }
    
    func itemAt(_ index: Int) -> Item? {
        if index == 0 {
            return head?.item
        }

        let targetIndex = targetIndex(index)
        var current = head
        var pos = 0
        while current?.next != nil && pos <= targetIndex {
            print("\(String(describing: current?.item))")
            current = current?.next
            pos += 1
        }
        print("\(String(describing: current?.item))")
        return current?.item
    }
    
    func targetIndex(_ index: Int) -> Int {
        return (count() % (index + 1)) - 1
    }
    
    func allItems() -> [Item] {
        var itemList = [Item]()
        if head == nil {
            return []
        }
        var current = head
        while current?.next != nil {
            if let item = current?.item {
                itemList.append(item)
            }
            current = current?.next
        }
        return itemList
    }
    
    func printForwards() {
        var current = head
        while current?.next != nil {
            print("\(String(describing: current?.item))")
            current = current?.next
        }
        print("\(String(describing: current?.item))")
    }
    
    func printBackwards() {
        var current = head
        while current?.next != nil {
            current = current?.next
        }
        while current?.prev != nil {
            print("\(String(describing: current?.item))")
            current = current?.prev
        }
        print("\(String(describing: current?.item))")
    }
}
