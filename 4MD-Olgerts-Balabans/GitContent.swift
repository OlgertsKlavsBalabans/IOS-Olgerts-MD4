// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gitContent = try? newJSONDecoder().decode(GitContent.self, from: jsonData)

import Foundation

// MARK: - GitContentElement
struct GitContentElement: Codable {
    let name, path, sha: String?
    let size: Int?
    let url, htmlURL: String?
    let gitURL: String?
    let downloadURL: String?
    let type: TypeEnum?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case name, path, sha, size, url
        case htmlURL = "html_url"
        case gitURL = "git_url"
        case downloadURL = "download_url"
        case type
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String?
    let git: String?
    let html: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case git, html
    }
}

enum TypeEnum: String, Codable {
    case file = "file"
}

typealias GitContent = [GitContentElement]
