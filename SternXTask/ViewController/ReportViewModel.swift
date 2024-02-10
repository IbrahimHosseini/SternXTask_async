//
//  ReportViewModel.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/7/24.
//

import Foundation
import Combine

class ReportViewModel: ObservableObject {
    @Published var error: String?
    @Published var report: [Report]?

    private let serviceHandler: PostsService
    private let reportService: ReportService

    init(
        serviceHandler: PostsService,
        reportService: ReportService
    ) {
        self.serviceHandler = serviceHandler
        self.reportService = reportService
    }

    func fetchPosts(order: Order = .DES, countOfUser: Int = 5) async {

        let result = await serviceHandler.getPosts()

        switch result {
        case .success(let posts):
            report = await getReport(with: posts, order: order, countOfUser: countOfUser)
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }

    private func getReport(with posts: [Post], order: Order, countOfUser: Int) async -> [Report] {
        reportService.getReport(posts: posts, order: order, countOfUser: countOfUser)
    }
}

