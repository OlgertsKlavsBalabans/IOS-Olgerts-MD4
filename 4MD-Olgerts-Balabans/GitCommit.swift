// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gitCommit = try? newJSONDecoder().decode(GitCommit.self, from: jsonData)

import Foundation

// MARK: - GitCommit
struct GitCommit: Codable {
    let files: [File]?

    enum CodingKeys: String, CodingKey {
        case files
    }
}


// MARK: - File
struct File: Codable {
    let sha, filename: String?
    let status: Status?
    let additions, deletions, changes: Int?
    let blobURL, rawURL, contentsURL: String?

    enum CodingKeys: String, CodingKey {
        case sha, filename, status, additions, deletions, changes
        case blobURL = "blob_url"
        case rawURL = "raw_url"
        case contentsURL = "contents_url"
    }
}

enum Status: String, Codable {
    case added = "added"
}


