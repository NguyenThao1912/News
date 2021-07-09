//
//  XMLModel.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/5/21.
//

import Foundation
import XMLMapper
//MARK: - rss tag

class rss: XMLMappable {
    var nodeName: String!
    var channel :Channel?
    required init?(map: XMLMap) {
    }
    func mapping(map: XMLMap) {
        channel <- map["channel"]
    }
    
    
}
//MARK: - Channel tag

class Channel: XMLMappable {
    var nodeName    : String!
    
    var title       : String!
    var description : String!
    var image       : Image!
    var pubDate     : String!
    var generator   : String!
    var link        : String!
    var item        : [Item]?
    required init?(map: XMLMap) {
    }
    func mapping(map: XMLMap) {
        title       <- map["title"]
        description <- map["description"]
        image       <- map["image"]
        pubDate     <- map["pubDate"]
        generator   <- map["generator"]
        link        <- map["link"]
        item        <- map["item"]
    }
}
//MARK: - Image tag

class Image : XMLMappable{
    var url     : String!
    var title   : String!
    var link    : String!
    required init?(map: XMLMap) {

    }
    var nodeName: String!
    func mapping(map: XMLMap) {
        url     <- map["url"]
        title   <- map["title"]
        link    <- map["link"]
    }
}
//MARK: - Item tag

class Item : XMLMappable{
    var nodeName: String!
    
    var title        : String!
    var description  : String?
    var pubDate      : String!
    var link         : String!
    var guid         : String!
    var slashcomment : String!
    
    required init?(map: XMLMap) {
    }
    
    func mapping(map: XMLMap) {
        title        <- map["title"]
        description  <- map["description"]
        pubDate      <- map["pubDate"]
        link         <- map["link"]
        guid         <- map["guid"]
        slashcomment <- map["slash:comments"]
    }
}
