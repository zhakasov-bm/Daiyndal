//
//  Quiz+Ext.swift
//  DayindalApp
//
//  Created by Bekzhan on 22.12.2022.
//

import UIKit

extension QuizViewController {
    
    func fetchData() -> [QuestionAnswerModel] {
        let question1 = QuestionAnswerModel(
            question: "Баласағүни Қүтадғу білік кітабын аяқтаған қала?",
            answer: "Қашғар"
        )
        let question2 = QuestionAnswerModel(
            question: "Әбілмансұрдың атасы Абылай билік құрған қала",
            answer: "Түркістан"
        )
        let question3 = QuestionAnswerModel(
            question: "Түрік этнонимі алғаш рет қай жылы кездесті?",
            answer: "542ж"
        )
        let question4 = QuestionAnswerModel(
            question: "1960ж трансформатор зауыты салынған қала",
            answer: "Кентау"
        )
        let question5 = QuestionAnswerModel(
            question: "Қола дәуіріне тән емес ерекшелік?",
            answer: "Еңбек бөлінісі пайда болды"
        )
        let question6 = QuestionAnswerModel(
            question: "1975ж Алматыда шыққан Аз и Я кітабының авторы?",
            answer: "Сүлейменов"
        )
        let question7 = QuestionAnswerModel(
            question: "Сақтарды Әлемдегі ең әділ,ең шыншыл xалық деп есептегендер",
            answer: "Гректер"
        )
        let question8 = QuestionAnswerModel(
            question: "Әбілмансұрдың атасы Абылай билік құрған қала",
            answer: "Түркістан"
        )
        let question9 = QuestionAnswerModel(
            question: "Түріктердің жазба әдебиеті дүниеге келген уақыт",
            answer: "YІІғ"
        )
        let question10 = QuestionAnswerModel(
            question: "Ғүн мемлекетінің саяси күшейген кезі?",
            answer: "Б.З.Б ІІғ-б.з.б Іғ аралығы"
        )
        
        return [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]
    }
}
