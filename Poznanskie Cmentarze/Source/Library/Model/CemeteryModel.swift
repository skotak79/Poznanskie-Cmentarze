//
//  CemeteryModel.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

protocol CemeteryModelDelegate: AnyObject {
    func cemeteryModel(_ cemeteryModel: CemeteryModel, didFetchedCemeteries cemeteries: [Cemetery])
}

final class CemeteryModel {

    weak var delegate: CemeteryModelDelegate?

    private(set) var cemeteries: [Cemetery] = [] {
        didSet {
            delegate?.cemeteryModel(self, didFetchedCemeteries: cemeteries)
        }
    }

    private var task: URLSessionTask?
    private let engine: NetworkEngine

    init(engine: NetworkEngine = ApiSession.shared) {
        self.engine = engine
    }
    func fetchAll(completion: @escaping (Result<[Cemetery]>) -> Void) {
        if task != nil { return }
        let request = CemeteryRequest()

        self.task = engine.send(request) { [weak self] in
            guard let self = self else {
                return
            }
            switch $0 {
            case .success(let value):
                self.cemeteries = value?.features ?? []
                completion(.success(value?.features ?? []))
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }

            self.task = nil
        }
    }
}
