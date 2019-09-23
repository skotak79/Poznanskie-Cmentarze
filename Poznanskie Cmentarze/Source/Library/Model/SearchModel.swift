//
//  SearchModel.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

protocol SearchModelDelegate: AnyObject {
    func searchModel(_ searchModel: SearchModel, didReceive error: LoadingError)
    func searchModel(_ searchModel: SearchModel, didChange isFetchingGraves: Bool)
    func searchModel(_ searchModel: SearchModel, didFetched graves: [Grave])
}

final class SearchModel {

    weak var delegate: SearchModelDelegate?

    let debouncer = Debouncer(delay: 1)
    private(set) var query: String = ""
    private(set) var graves: [Grave] = [] {
        didSet {
            print("didSet graves delegate ...")
            delegate?.searchModel(self, didFetched: graves)
        }
    }

    private(set) var isFetchingGraves = false {
        didSet {
            delegate?.searchModel(self, didChange: isFetchingGraves)
        }
    }

    private var tasks: [URLSessionTask?] = []
    private let engine: NetworkEngine

    init(engine: NetworkEngine = ApiSession.shared) {
        self.engine = engine
    }

    func fetchGraves() {

        if !tasks.isEmpty { return }
        isFetchingGraves = true
        let requests = GraveRequest.makeRequests(for: query)

        var storedError: LoadingError?
        let errorSyncQueue = DispatchQueue(label: "FetchGraves.ErrorSync")
        let downloadGroup = DispatchGroup()
        let graveCollection = GraveCollection()

        for request in requests {
            downloadGroup.enter()
            self.tasks.append(engine.send(request, completion: { result in
                switch result {
                case .success(let value):
                    let graves = value?.features ?? []
                        graveCollection.add(graves: graves)
                case .failure(let error):
                    errorSyncQueue.sync {
                        storedError = error
                    }
                }
                downloadGroup.leave()
            }))
        }

        downloadGroup.notify(queue: DispatchQueue.main) {
            if let storedError = storedError {
                self.delegate?.searchModel(self, didReceive: storedError)
            } else {
                self.graves = graveCollection.graves
                print("Graves in searchModel: \(self.graves.count)")
            }
        }
        isFetchingGraves = false
        tasks.removeAll()
    }

    func fetchGraves(with query: String) {

        debouncer.schedule { [weak self] in
            guard let self = self else { return }

        let oldValue = self.query
        self.query = query
        if query != oldValue {
            if !self.graves.isEmpty { self.graves.removeAll() }
            } else {
                debugPrint("old value = query, return")
                return
            }
        self.tasks.forEach {
            $0?.cancel()
        }
        self.tasks.removeAll()
        self.fetchGraves()
        }
    }
}
