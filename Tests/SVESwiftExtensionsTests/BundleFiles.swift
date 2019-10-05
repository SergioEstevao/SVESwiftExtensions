
import Foundation

class BundleFiles {

    static func url(for filename: String) -> URL? {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent(filename)

        return resourceURL

    }

    static func url(for filename: String, inClassBundle classBundle: AnyClass) -> URL? {
        let bundle = Bundle(for: classBundle)
        return url(for: filename, in: bundle)
    }

    static func url(for filename: String, in bundle: Bundle) -> URL? {
        return bundle.url(forResource: (filename as NSString).deletingPathExtension , withExtension: (filename as NSString).pathExtension)
    }
}
