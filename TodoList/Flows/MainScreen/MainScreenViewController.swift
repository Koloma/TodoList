//
//  MainScreenViewController.swift
//  TodoList
//
//  Created by Коломенский Александр on 12.02.2023.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {

	private let tableView: UITableView = UITableView()
	private let mainScreenViewModel: MainScreenViewModel


	init(mainScreenViewModel: MainScreenViewModel) {
		self.mainScreenViewModel = mainScreenViewModel
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		initView()
	}


	private func initView() {

		view.addSubview(tableView)
		tableView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		tableView.backgroundColor = .blue
	}

}

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mainScreenViewModel.taskList.count
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}


}

