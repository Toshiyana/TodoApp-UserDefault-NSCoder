//
//  Item.swift
//  Todoey
//
//  Created by Toshiyana on 2021/03/16.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

//自作plistファイルを作成するために．encoder, decoderを用いる場合，encode,decodeするobjectはそれぞれEncodable,Decodableプロトコルに従わせる必要あり
//Encodable,Decodableに従わせる場合，propertyの型は標準の型のみ利用可能
//Codable: Encodable & Decodable
struct Item: Codable {
    var title: String = ""
    var isChecked: Bool = false
}
