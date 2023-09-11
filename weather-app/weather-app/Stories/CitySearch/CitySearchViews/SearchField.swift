//
//  SearchField.swift
//  weather-app
//
//  Created by Dima Worożbicki on 11/09/2023.
//

import UIKit

protocol SearchTextFieldDelegate: AnyObject {
    func textForSearchReceived(_ text: String)
}

final class SearchField: UITextField {
    private let searchingDelay: CGFloat = 0.8
    private var updateViewDataTask: DispatchWorkItem?
    private let verticalPadding: CGFloat = 8
    private let horizontalPadding: CGFloat = 16
    private let imageSize: CGFloat = 24
    private let deleteTextButton = UIButton(type: .system)
            
    weak var searchFieldDelegate: SearchTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareView()
    }
    
    private func prepareView() {
        delegate = self
        rightViewMode = UITextField.ViewMode.always
        let rightSubviewFrame = CGRect(x: horizontalPadding, y: horizontalPadding,
                                       width: imageSize, height: imageSize)
        deleteTextButton.frame = rightSubviewFrame
        deleteTextButton.addTarget(self, action: #selector(clearTextAction(_:)), for: .touchUpInside)
        deleteTextButton.setTitle("✖", for: .normal)
        deleteTextButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        rightView = UIView(frame: CGRect(x: 0, y: 0,
                                         width: imageSize + horizontalPadding * 2,
                                         height: imageSize + horizontalPadding * 2))
        rightView?.addSubview(deleteTextButton)
        let isTextEmpty = text?.isEmpty ?? true
        deleteTextButton.isHidden = isTextEmpty
        placeholder = "SearchPlaceholder".localized
        returnKeyType = .done
    }
    
    private func isValid(text: NSMutableString) -> Bool {
        return text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .range(of: AppConstants.searchRegex, options: .regularExpression) != nil
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                             bottom: verticalPadding, right: horizontalPadding * 2 + imageSize))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                             bottom: verticalPadding, right: horizontalPadding * 2 + imageSize))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                             bottom: verticalPadding, right: horizontalPadding * 2 + imageSize))
    }
    
    @objc private func clearTextAction(_ button: UIButton) {
        text = ""
        deleteTextButton.isHidden = true
        DispatchQueue.main.async {
            self.searchFieldDelegate?.textForSearchReceived(self.text ?? "")
        }
    }
}

extension SearchField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let replacementString = string.count > 1 ? string.trimmingCharacters(in: .whitespaces) : string
        updateViewDataTask?.cancel()
        updateViewDataTask = DispatchWorkItem { [weak self] in
            guard let text = self?.text else { return }
            NSLog("Search for: \(text)")
            self?.deleteTextButton.isHidden = text.isEmpty
            DispatchQueue.main.async {
                self?.searchFieldDelegate?.textForSearchReceived(text)
            }
        }
        let resultText = NSMutableString(string: text)
        resultText.replaceCharacters(in: range, with: replacementString)
        let isTextEmpty = resultText.trimmingCharacters(in: .whitespaces).isEmpty
        guard isTextEmpty || isValid(text: resultText) else { return false }
        NSLog("TextField Value Changed: \(resultText)")
        if let task = updateViewDataTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + searchingDelay, execute: task)
        }
        if string.count > 1 {
            self.text = resultText as String
            return false
        }
        return true
    }
}
