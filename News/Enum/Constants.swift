//
//  Constants.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/5/21.
//

import Foundation
enum Constants : String {
    case BaseURL        = "https://vnexpress.net/rss/"
    case Home           = "tin-moi-nhat.rss"
    case World          = "the-gioi.rss"
    case News           = "thoi-su.rss"
    case Bussiness      = "kinh-doanh.rss"
    case StartUp        = "startup.rss"
    case Entertainment  = "giai-tri.rss"
    case Sport          = "the-thao.rss"
    case Law            = "phap-luat.rss"
    case Education      = "giao-duc.rss"
    case Health         = "suc-khoe.rss"
    case Family         = "gia-dinh.rss"
    case Travel         = "du-lich.rss"
    case Science        = "khoa-hoc.rss"
    case Tech           = "so-hoa.rss"
    case Vehicle        = "oto-xe-may.rss"
    case Convey         = "y-kien.rss"
    case Confide        = "tam-su.rss"
    case Laugh          = "cuoi.rss"
    case ReadALot       = "tin-xem-nhieu.rss"
    case Trending       = "tin-noi-bat.rss"
    func ConstructURL(type : Constants) -> String {
        switch type {
            case .Home,.World,.News,.StartUp,.Entertainment,
                 .Sport,.Law,.Education,.Health,.Family,.Travel,
                 .Science,.Tech,.Vehicle,.Bussiness,.Convey,.Confide,.Laugh,.ReadALot,.Trending:
                let url = Constants.BaseURL.rawValue + type.rawValue
                return url
            default :
                return ""
        }
    }
}
