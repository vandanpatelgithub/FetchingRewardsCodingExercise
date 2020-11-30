//
//  HomePageBuilder.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/30/20.
//

import UIKit

final class HomePageBuilder {
    static func buildHomePageVC() -> HomePageVC {
        let vc = HomePageVC()
        let presenter = HomePagePresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
}
