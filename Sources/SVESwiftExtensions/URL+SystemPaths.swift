import Foundation

extension URL {

    public static func temporaryFileURL(withExtension fileExtension: String) -> URL {
        assert(!fileExtension.isEmpty, "file extension cannot be empty")
        let fileName = "\(ProcessInfo.processInfo.globallyUniqueString)_file.\(fileExtension)"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        return fileURL
    }

    public static func temporaryFileURL(withFilename filename: String) -> URL? {
        assert(!filename.isEmpty, "file name cannot be empty")
        let extraPath = "\(ProcessInfo.processInfo.globallyUniqueString)"
        let pathURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(extraPath)
        do {
            try FileManager.default.createDirectory(at: pathURL,
                                                    withIntermediateDirectories: true, attributes: nil)
        } catch {
            return nil
        }
        return pathURL.appendingPathComponent("/\(filename)")
    }

    public static var applicationSupportDirectory: URL? {
        let sharedFM = FileManager.default
        let possibleURLs = sharedFM.urls(for: .applicationSupportDirectory,
                                         in: [.userDomainMask])
        guard
            let appSupportDir = possibleURLs.first,
            let appBundleID = Bundle.main.bundleIdentifier
            else {
                return nil
        }

        let appDirectory = appSupportDir.appendingPathComponent(appBundleID)
        do {
            try FileManager.default.createDirectory(at: appDirectory,
                                                    withIntermediateDirectories: true, attributes: nil)
        } catch {
            return nil
        }
        return appDirectory
    }

    public static var documentDirectory: URL? {
        let possibleURLs = FileManager.default.urls(for: .documentDirectory,
                                                    in: [.userDomainMask])
        guard let documentsDirectory = possibleURLs.first
            else {
                return nil
        }

        return documentsDirectory
    }

}
