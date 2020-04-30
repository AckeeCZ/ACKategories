import Foundation

extension Int: Randomizable {
    public static func random() -> Int {
        Int.random(in: 20...1000)
    }
}
