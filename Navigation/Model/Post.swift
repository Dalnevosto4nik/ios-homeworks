//
//  Post.swift
//  Navigation
//
//  Created by Сергей Завьялов on 27.04.2022.
//

import UIKit

struct PostModel {
    var author: String
    var description: String?
    var image: String
    var likes: Int
    var isLiked: Bool
    var views: Int
    
    static func makeMockModel() -> [PostModel] {
        var model = [PostModel]()
        
        model.append(PostModel(author: "Одинокий странник", description: "Я не стремлюсь стать бессмертным, мне не нужна мирская суета. Я хочу жить спокойной мирной жизнью. Но если небеса будут жестоки ко мне, а боги несправедливы, я пройду через бесконечную вселеленную и буду сражаться до последнего.", image: "01", likes: 122, isLiked: false, views: 3456))
        model.append(PostModel(author: "Chris Rea", description: ".. Oh no, this is the road. Said this is the road, this is the road to hell...", image: "02", likes: 234, isLiked: false, views: 2346))
        model.append(PostModel(author: "Белый Клык", description: "Цель жизни — добыча. Сущность жизни — добыча. Жизнь питается жизнью. Все живое в мире делится на тех, кто ест, и тех, кого едят. И закон этот говорил: ешь, или съедят тебя самого", image: "03", likes: 456, isLiked: false, views: 867))
        model.append(PostModel(author: "Джек Воробей", description: "Стоит разок умереть и приоритеты тут же меняются", image: "04", likes: 1345, isLiked: false, views: 1986))
        
        return model
    }
}


