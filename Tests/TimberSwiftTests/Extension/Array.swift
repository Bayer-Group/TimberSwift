extension Array {
    func isAccessible(at index: Int) -> Bool {
        return index >= 0 && index <= count - 1
    }
    
    func at(_ index: Int) -> Element? {
        return self.isAccessible(at: index) ? self[index] : nil
    }
}
