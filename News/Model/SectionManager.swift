//
//  SectionManager.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/6/21.
//

import Foundation
struct SectionManager {
    static var data = [
        Section(tittle: "Trang Chủ", image: "home",type: .Home),
        Section(tittle: "Tin Nổi Bật", image: "popularity",type: .Trending),
        Section(tittle: "Thế giới", image: "world",type: .World),
        Section(tittle: "Thời sự", image: "newspaper",type: .News),
        Section(tittle: "Kinh Doanh", image: "bussiness",type: .Bussiness),
        Section(tittle: "Start Up", image: "startup",type: .StartUp),
        Section(tittle: "Giải Trí", image: "game", type: .Entertainment),
        Section(tittle: "Thể Thao", image: "soccer-ball", type: .Sport),
        Section(tittle: "Pháp Luật", image: "law" , type: .Law),
        Section(tittle: "Giáo Dục", image: "education" , type: .Education),
        Section(tittle: "Sức Khoẻ", image: "healthcare", type: .Health),
        Section(tittle: "Đời Sống", image: "life",type: .Family),
        Section(tittle: "Du lịch", image: "plane", type: .Travel),
        Section(tittle: "Khoa Học", image: "technology",type: .Science),
        Section(tittle: "Số Hoá", image: "science" , type: .Tech),
        Section(tittle: "Xe", image: "car",type: .Vehicle),
        Section(tittle: "Ý Kiến", image: "megaphone",type: .Convey),
        Section(tittle: "Tâm Sự", image: "opinion",type: .Confide),
        Section(tittle: "Cười", image: "laughing",type: .Laugh)
    ]
}
