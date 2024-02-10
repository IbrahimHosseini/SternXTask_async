//
//  ReportViewController.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import UIKit
import Combine

class ReportViewController: UIViewController {

    // MARK: - properties

    private let viewModel: ReportViewModel?

    private var cancellable = Set<AnyCancellable>()

    // MARK: - initializer

    init(viewModel: ReportViewModel?) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle view

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        getPosts()
    }

    // MARK: - functions

    // fetch post from view model
    private func getPosts() {
        Task {
           await viewModel?.fetchPosts()
        }
    }

    // bind posts data and print it.
    private func bind() {

        // implement error message
        viewModel?.$error
            .compactMap { $0 }
            .sink(receiveValue: { error in
                print("Error: \(error)")
            })
            .store(in: &cancellable)

        viewModel?.$report
            .compactMap { $0 }
            .sink(receiveValue: { report in
                print("report", report)
            })
            .store(in: &cancellable)
    }
}

