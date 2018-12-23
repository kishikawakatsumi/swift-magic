//
//  Magic.swift
//  Magic
//
//  Created by Kishikawa Katsumi on 2018/12/23.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

import Foundation
import magic

public final class Magic {
    public static let shared = Magic()
    private let magic: magic_t

    public init() {
        guard let path = Bundle(for: Magic.self).path(forResource: "magic", ofType: "mgc") else {
            fatalError("'magic.mgc' is not found in bundle")
        }
        magic = magic_open(MAGIC_NONE)
        magic_load(magic, NSString(string: path).fileSystemRepresentation)
    }

    deinit {
        magic_close(magic)
    }

    public func file(_ path: URL) throws -> String {
        return try file(path, flags: .none)
    }

    public func file(_ path: URL, flags: Flags) throws -> String {
        magic_setflags(magic, flags.rawValue)

        guard FileManager().fileExists(atPath: path.path) else {
            throw Error.notFound
        }
        guard let description = magic_file(magic, (path as NSURL).fileSystemRepresentation) else {
            throw Error.unexpected
        }

        return String(cString: description)
    }

    public struct Flags: OptionSet {
        public let rawValue: Int32

        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        public static let none = Flags(rawValue: MAGIC_NONE) /* No flags */
        public static let debug = Flags(rawValue: MAGIC_DEBUG) /* Turn on debugging */
        public static let symlink = Flags(rawValue: MAGIC_SYMLINK) /* Follow symlinks */
        public static let compress = Flags(rawValue: MAGIC_COMPRESS) /* Check inside compressed files */
        public static let devices = Flags(rawValue: MAGIC_DEVICES) /* Look at the contents of devices */
        public static let mimeType = Flags(rawValue: MAGIC_MIME_TYPE) /* Return the MIME type */
        public static let preserveAtime = Flags(rawValue: MAGIC_PRESERVE_ATIME) /* Restore access time on exit */
        public static let mimeEncoding = Flags(rawValue: MAGIC_MIME_ENCODING) /* Return the MIME encoding */
        public static let mime: Flags = [mimeType, mimeEncoding]
        public static let apple = Flags(rawValue: MAGIC_APPLE) /* Return the Apple creator/type */
        public static let `extension` = Flags(rawValue: MAGIC_EXTENSION) /* Return a /-separated list of
         * extensions */
        public static let compressTransp = Flags(rawValue: MAGIC_COMPRESS_TRANSP) /* Check inside compressed files
         * but not report compression */
        public static let nodesc: Flags = [`extension`, mime, apple]
    }

    public enum Error: Swift.Error {
        case notFound
        case unexpected
    }
}
