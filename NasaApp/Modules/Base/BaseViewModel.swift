//
//  BaseViewModel.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import RxSwift
import RxCocoa


struct Output <T> {
    let response: Driver<T>
    let errorMessage: Driver<String>
}
