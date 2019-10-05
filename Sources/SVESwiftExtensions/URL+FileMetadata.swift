
import Foundation
import MobileCoreServices
import AVFoundation

public extension URL {

    /// The fileSize of the file at the URL in bytes, if available.
    var fileSize: Int64? {
        guard isFileURL else {
            return nil
        }
        let values = try? resourceValues(forKeys: [.fileSizeKey])
        guard let fileSize = values?.allValues[.fileSizeKey] as? NSNumber else {
            return nil
        }
        return fileSize.int64Value
    }

    /// The resource's uniform type identifier for the file at the URL, if available.
    var typeIdentifier: String? {
        let values = try? resourceValues(forKeys: [.typeIdentifierKey])
        return values?.typeIdentifier
    }

    /// The expected file extension string for the URL type identifier
    var typeIdentifierFileExtension: String? {
        guard let type = typeIdentifier else {
            return nil
        }
        return URL.fileExtensionForUTType(type)
    }

    /// Returns a URL with an incremental file name, if a file already exists at the given URL.
    func incrementalFilename() -> URL {
        var url = self
        let pathExtension = url.pathExtension
        let filename = url.deletingPathExtension().lastPathComponent
        var index = 1
        let fileManager = FileManager.default
        while fileManager.fileExists(atPath: url.path) {
            let incrementedName = "\(filename)-\(index)"
            url.deleteLastPathComponent()
            url.appendPathComponent(incrementedName, isDirectory: false)
            url.appendPathExtension(pathExtension)
            index += 1
        }
        return url
    }

    /// The expected file extension string for a given UTType identifier string.
    ///
    /// - param type: The UTType identifier string.
    /// - returns: The expected file extension or nil if unknown.
    ///
    static func fileExtensionForUTType(_ type: String) -> String? {
        let fileExtension = UTTypeCopyPreferredTagWithClass(type as CFString, kUTTagClassFilenameExtension)?.takeRetainedValue()
        return fileExtension as String?
    }

    /// The mime type of the file this URL points to
    var mimeType: String {
        guard let uti = typeIdentifier,
            let mimeType = UTTypeCopyPreferredTagWithClass(uti as CFString, kUTTagClassMIMEType)?.takeUnretainedValue() as String?
            else {
                return "application/octet-stream"
        }

        return mimeType
    }

    /// Returns true if the file points to a video resource
    var isVideo: Bool {
        guard let uti = typeIdentifier else {
            return false
        }

        return UTTypeConformsTo(uti as CFString, kUTTypeMovie)
    }

    /// Returns true if the file points to a image resource
    var isImage: Bool {
        guard let uti = typeIdentifier else {
            return false
        }

        return UTTypeConformsTo(uti as CFString, kUTTypeImage)
    }

    /// Returns true if the file points to a gif file
    var isGIF: Bool {
        if let uti = typeIdentifier {
            return UTTypeConformsTo(uti as CFString, kUTTypeGIF)
        } else {
            return pathExtension.lowercased() == "gif"
        }
    }

    /// Returns the pixel size of the resource pointed by the URL if it's an image or a video file.
    /// If the resource is not a video or a image an size zero will be returned
    var pixelSize: CGSize {
        get {
            if isVideo {
                let asset = AVAsset(url: self as URL)
                if let track = asset.tracks(withMediaType: .video).first {
                    return track.naturalSize.applying(track.preferredTransform)
                }
            } else if isImage {
                let options: [NSString: NSObject] = [kCGImageSourceShouldCache: false as CFBoolean]
                if
                    let imageSource = CGImageSourceCreateWithURL(self as NSURL, nil),
                    let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, options as CFDictionary?) as NSDictionary?,
                    let pixelWidth = imageProperties[kCGImagePropertyPixelWidth as NSString] as? Int,
                    let pixelHeight = imageProperties[kCGImagePropertyPixelHeight as NSString] as? Int
                {
                    return CGSize(width: pixelWidth, height: pixelHeight)
                }
            }
            return CGSize.zero
        }
    }
}

extension NSURL {
    @objc var isVideo: Bool {
        return (self as URL).isVideo
    }

    @objc var fileSize: NSNumber? {
        guard let fileSize = (self as URL).fileSize else {
            return nil
        }
        return NSNumber(value: fileSize)
    }
}
