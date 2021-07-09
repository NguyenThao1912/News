//
//  XMLRequest.swift
//  News
//
//  Created by Nguyen Huu Thao on 7/5/21.
//

import Foundation
import XMLMapper
import SwiftSoup
class XMLRequest{
    static func RequestXML(url : String,  completion : @escaping (_ data : [Item]) ->()) {
        guard let url = URL(string: url) else {
            print("INVALID URL REQUEST XML")
            return
        }
        let session = URLSession(configuration: .default)
        let downloadXMLFile = session.dataTask(with: url){ data,response,error in
            if let error = error{
                print("Error download XML file \(error.localizedDescription)")
                return
            }
            guard let data = data else{
                print("No XML Data")
                return
            }
            let xmlfile = String(data: data, encoding: .utf8)
            guard let xmlString = xmlfile else{
                return
            }
            let responseData = self.parser(XMLString: xmlString)
            completion(responseData)
        }
        downloadXMLFile.resume()
        
    }
    
    static private func parser(XMLString : String) -> [Item] {
        let data = Data(XMLString.utf8)
        do{
            let xml = try XMLSerialization.xmlObject(with: data, options: [.default, .cdataAsString])
            guard let News = XMLMapper<rss>().map(XMLObject: xml) else { return [] }
            
            guard let result  = News.channel?.item else { return [] }
            return result
        } catch{
            print("No Data")
            return []
        }
    }
    static  func getLinkHtml(data : String) -> String
    {
        do{
            let doc      : Document = try SwiftSoup.parse(data)
            let link     : Element = try doc.select("a").first()!
            let linkHref : String = try link.attr("href");
            return linkHref
        }
        catch Exception.Error( _, let message) {
            print(message)
            return ""
        } catch {
            print("error")
            return ""
        }
    }
    static  func getImgHtml(data : String) -> String {
        do{
            let doc : Document   = try SwiftSoup.parse(data)
            guard let link = try doc.select("img").first() else {
                return "No IMG"
            }
            let linkIMG : String = try link.attr("src")
            return linkIMG
        }
        catch Exception.Error( _, let message) {
            print(message)
            return ""
        } catch {
            print("error")
            return ""
        }
    }
    static func getDescription(data : String) -> String{
        guard let startindex = data.lastIndex(of: ">") else{
            return "\(data)"
        }
        let start = data.index(startindex, offsetBy: 1)
        let des = String(data.suffix(from: start))
        return des
    }
    static func downloadImage(url : String, completion : @escaping (_ data :Data)->()){
        guard let myurl = URL(string: url) else {
            print("INVALID URL DOWNLOAD IMAGE ERROR : \(url)")
            return
        }
        let session = URLSession(configuration: .default)
        let downloadFile = session.dataTask(with: myurl){ data,response,error in
            if let error = error{
                print("Error download IMG file \(error.localizedDescription)")
                return
            }
            guard let data = data else{
                print("No IMG Data")
                return
            }
       
            completion(data)
        }
        downloadFile.resume()
    }
}
