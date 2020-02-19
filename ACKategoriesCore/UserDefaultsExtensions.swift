import Foundation

extension UserDefaults {
    private enum Keys {
        static let deviceID = "ud_device_id_b8cb6644-43fa-4bc4-a4f3-23f9e5d25c8f"
    }

    /// Once generated `UUID` which can be used as device identificator
    public var deviceID: String {
        if let result = string(forKey: Keys.deviceID) {
            return result
        }

        let newDeviceID = NSUUID().uuidString

        set(newDeviceID, forKey: Keys.deviceID)
        synchronize()

        return newDeviceID
    }
}
