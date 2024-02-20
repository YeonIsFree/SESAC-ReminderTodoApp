//
//  AddViewController.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit
import PhotosUI

class AddViewController: BaseViewController {
    
    let repository = TodoTableRepository()
    
    var todoTitle: String = ""
    var todoMemo: String = ""
    
    // 다른 화면에서 클로저로 받아온 값들을 담아두는 배열 (Textfield Memo, date는 제외)
    // AddCellType Enum의 rawValue 순서로 저장.
    var changedValues: [String] = Array(repeating: "", count: AddCellType.allCases.count)
    
    var photo: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.addTableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Property
    
    let addTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationBar()
    }
    
    // MARK: - selector
    
    @objc func addButtonTapped() {
        // 제목 작성 됐는지 검사
        if todoTitle == "" {
            self.view.makeToast("제목을 입력해주세요", duration: 2.0, position: .top)
        } else {
            let todo = TodoTable(todoTitle: todoTitle,
                                 todoMemo: todoMemo,
                                 date: DateFormatter.convertToDate(changedValues[AddCellType.todoDate.rawValue]) ?? Date(),
                                 tag: changedValues[AddCellType.todoTag.rawValue],
                                 priority: changedValues[AddCellType.priority.rawValue])
            
            repository.createTodo(todo)
            
            if let photo {
                saveImageToDocument(image: photo, filename: "\(todo.todoID)")
            }
            
            // todoList가 변경됐음을 post
            NotificationCenter.default.post(name: AddViewController.todoListDidChanged, object: nil)
            
            dismiss(animated: true)
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    // MARK: - UI Configuration Method
    
    func showPickerView() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "새로운 할 일"
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.image = UIImage(systemName: "multiply")
        leftBarButton.action = #selector(cancelButtonTapped)
        leftBarButton.target = self
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.title = "추가"
        rightBarButton.action = #selector(addButtonTapped)
        rightBarButton.target = self
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func configureTableView() {
        addTableView.delegate = self
        addTableView.dataSource = self
        addTableView.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        addTableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.identifier)
    }
    
    override func render() {
        view.addSubview(addTableView)
        addTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableView Delegate

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AddCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddCellType.allCases[indexPath.section].cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = AddCellType.allCases[indexPath.section]
        
        switch cellType {
        case .todoMemo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            // TextField Delegate
            cell.titleTextField.delegate = self
            cell.memoTextField.delegate = self
            
            // MemoCell에 있는 TextField에 tag 부여
            cell.titleTextField.tag = 100
            cell.memoTextField.tag = 101
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as? AddTableViewCell else { return UITableViewCell() }
            
            // 이미지
            cell.cellImageView.image = photo
            
            cell.configureCell(indexPath.section)
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            
            // 다음 화면에서 현재 화면으로 역 값 전달
            cell.cellSubTitleLabel.text = changedValues[indexPath.section]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = AddCellType.allCases[indexPath.section]
        switch cellType {
        case .todoMemo:
            break
        case .addImage:
            // show action sheet
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default)
            let showAlbum = UIAlertAction(title: "앨범에서 선택", style: .default) { _ in
                self.showPickerView()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(takePhotoAction)
            alert.addAction(showAlbum)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        default:
            if let vc = cellType.viewController {
                vc.changedValue = { value in
                    self.changedValues[indexPath.section] = value
                    self.addTableView.reloadData()
                }
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

// MARK: - PHPickerViewController Delegate

extension AddViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                self.photo = image as? UIImage
            }
        }
    }
}

// MARK: - TextField Delegate

extension AddViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            todoTitle = textField.text!
        } else {
            todoMemo = textField.text!
        }
    }
}

// MARK: - Notification

extension AddViewController {
    static let todoListDidChanged = Notification.Name(rawValue: "todoListChanged")
}
