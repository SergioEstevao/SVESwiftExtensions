import XCTest
@testable import SVESwiftExtensions

class URLFileMetadataTests: XCTestCase {

    let urlJPEGImageFile = BundleFiles.url(for: "Resources/test-image.jpg")!
    let urlGIFImageFile = BundleFiles.url(for: "Resources/test-animated.gif")!
    let urlMP4VideoFile = BundleFiles.url(for: "Resources/test-video.mp4")!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFileSize() {
        XCTAssertEqual(urlJPEGImageFile.fileSize, 233139)
        XCTAssertEqual(urlGIFImageFile.fileSize, 412992)
        XCTAssertEqual(urlMP4VideoFile.fileSize, 1495049)
    }

    func testIsImage() {
        XCTAssert(urlJPEGImageFile.isImage)
        XCTAssert(urlGIFImageFile.isImage)
        XCTAssertFalse(urlMP4VideoFile.isImage)
    }

    func testIsVideo() {
        XCTAssertFalse(urlJPEGImageFile.isVideo)
        XCTAssertFalse(urlGIFImageFile.isVideo)
        XCTAssert(urlMP4VideoFile.isVideo)
    }

    func testPixelSize() {
        XCTAssert(urlJPEGImageFile.pixelSize.equalTo(CGSize(width: 1024, height: 680)))
        XCTAssert(urlGIFImageFile.pixelSize.equalTo(CGSize(width: 660, height: 430)))
        XCTAssert(urlMP4VideoFile.pixelSize.equalTo(CGSize(width: 416, height: 240)))
    }

    func testMimeType() {
        XCTAssertEqual(urlJPEGImageFile.mimeType, "image/jpeg")
        XCTAssertEqual(urlGIFImageFile.mimeType, "image/gif")
        XCTAssertEqual(urlMP4VideoFile.mimeType, "video/mp4")
    }

    func testTypeIdentifier() {
        XCTAssertEqual(urlJPEGImageFile.typeIdentifier, "public.jpeg")
        XCTAssertEqual(urlGIFImageFile.typeIdentifier, "com.compuserve.gif")
        XCTAssertEqual(urlMP4VideoFile.typeIdentifier, "public.mpeg-4")

    }

    func testIsGif() {
        XCTAssertFalse(urlJPEGImageFile.isGIF)
        XCTAssert(urlGIFImageFile.isGIF)
    }
    
}
