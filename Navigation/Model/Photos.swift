//
//  Photos.swift
//  Navigation
//
//  Created by Сергей Завьялов on 04.05.2022.
//

import UIKit

struct PhotosModel {
    var author: String
    var image: String
    
    static func makeMockModel() -> [PhotosModel] {
        var model = [PhotosModel]()
        model.append(PhotosModel(author: "Santa Cat", image: "1"))
        model.append(PhotosModel(author: "Santa Cat", image: "2"))
        model.append(PhotosModel(author: "Santa Cat", image: "3"))
        model.append(PhotosModel(author: "Santa Cat", image: "4"))
        model.append(PhotosModel(author: "Santa Cat", image: "5"))
        model.append(PhotosModel(author: "Santa Cat", image: "6"))
        model.append(PhotosModel(author: "Santa Cat", image: "7"))
        model.append(PhotosModel(author: "Santa Cat", image: "8"))
        model.append(PhotosModel(author: "Santa Cat", image: "9"))
        model.append(PhotosModel(author: "Santa Cat", image: "10"))
        model.append(PhotosModel(author: "Santa Cat", image: "11"))
        model.append(PhotosModel(author: "Santa Cat", image: "12"))
        model.append(PhotosModel(author: "Santa Cat", image: "13"))
        model.append(PhotosModel(author: "Santa Cat", image: "14"))
        model.append(PhotosModel(author: "Santa Cat", image: "15"))
        model.append(PhotosModel(author: "Santa Cat", image: "16"))
        model.append(PhotosModel(author: "Santa Cat", image: "17"))
        model.append(PhotosModel(author: "Santa Cat", image: "18"))
        model.append(PhotosModel(author: "Santa Cat", image: "19"))
        model.append(PhotosModel(author: "Santa Cat", image: "20"))
        model.append(PhotosModel(author: "Santa Cat", image: "21"))
   return model
    }
}
