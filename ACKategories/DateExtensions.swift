import Foundation

extension Date {
    /// Seconds from date
    public var second: Int { return Calendar.current.component(.second, from: self) }
    
    /// Minutes from date
    public var minute: Int { return Calendar.current.component(.minute, from: self) }
    
    /// Hours from date in 24-hour format
    public var hour: Int { return Calendar.current.component(.hour, from: self) }
    
    /// Days from date
    public var day: Int { return Calendar.current.component(.day, from: self) }
    
    /// Months from date
    public var month: Int { return Calendar.current.component(.month, from: self) }
    
    /// Year from date
    public var year: Int { return Calendar.current.component(.year, from: self) }
}
