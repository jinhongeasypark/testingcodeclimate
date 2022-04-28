//
//  ContentView.swift
//  testing
//
//  Created by jk on 2022-04-28.
//

import SwiftUI

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
    init(network: NetworkService = NetworkServiceImpl()) {
        self.network = network
    }

    func buttonTapped() {
        network.callNetwork { [weak self] result in
            switch result {
            case .success: self?.loaded = true
            case .failure(let error): print(error.localizedDescription); self?.loaded = false
            }
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Toggle("WOW", isOn: $viewModel.loaded)
        Button("TAP", action: viewModel.buttonTapped)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
