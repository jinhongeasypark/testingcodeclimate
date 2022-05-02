//
//  ContentView.swift
//  testing
//
//  Created by jk on 2022-04-28.
//

import SwiftUI

protocol StorageService {
    func fetch<T>(key: String) -> T? where T: Hashable
}

class StorageServiceImpl: StorageService {
    func fetch<T>(key: String) -> T? where T : Hashable {
        UserDefaults.standard.object(forKey: key) as? T
    }
}

protocol NetworkService {
    func callNetwork(completion: @escaping (Result<Void, Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    func callNetwork(completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(.success(()))
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var loaded = false

    let network: NetworkService
    let storage: StorageService
    init(
        network: NetworkService = NetworkServiceImpl(),
        storage: StorageService = StorageServiceImpl()
    ) {
        self.network = network
        self.storage = storage
    }

    func buttonTapped() {
        network.callNetwork { [weak self] result in
            switch result {
            case .success: self?.loaded = true
            case .failure(let error): print(error.localizedDescription); self?.loaded = false
            }
        }
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }

    func wowo() {
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }

    func yoyo() {
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }

    func wawa() {
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }

    func hihi() {
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }

    func momo() {
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }

    func mama() {
        let value: Int? = storage.fetch(key: "hi")
        print(value ?? "?")
    }
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Toggle("WOW", isOn: $viewModel.loaded)
        Button("TAP", action: {
            viewModel.buttonTapped()
            viewModel.wowo()
            viewModel.yoyo()
            viewModel.wawa()
            viewModel.hihi()
            viewModel.momo()
            viewModel.mama()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
