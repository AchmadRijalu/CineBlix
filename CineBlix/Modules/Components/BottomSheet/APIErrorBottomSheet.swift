//
//  APIErrorBottomSheet.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 19/08/25.
//

import UIKit

class APIErrorBottomSheet: UIViewController {

    var onDismiss: (() -> Void)?
    private var didUpdatePreferredContentSize = false

    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "PrimaryColor") ?? .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return stackView
    }()

    init(image: UIImage?, title: String?, message: String?) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        titleLabel.text = title
        messageLabel.text = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updatePreferredContentSizeIfNeeded()
    }

    @objc private func dismissTapped() {
        onDismiss?()
        dismiss(animated: true)
    }

    private func updatePreferredContentSizeIfNeeded() {
        guard !didUpdatePreferredContentSize else { return }
        didUpdatePreferredContentSize = true

        let width = UIScreen.main.bounds.width
        view.bounds.size = CGSize(width: width, height: 1)
        view.setNeedsLayout()
        view.layoutIfNeeded()

        let height = view.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height

        preferredContentSize = CGSize(width: width, height: height)
    }
}

extension APIErrorBottomSheet {
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true

        view.addSubview(dismissButton)
        view.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(messageLabel)

        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            dismissButton.widthAnchor.constraint(equalToConstant: 32),
            dismissButton.heightAnchor.constraint(equalToConstant: 32),

            imageView.widthAnchor.constraint(equalToConstant: 72),
            imageView.heightAnchor.constraint(equalToConstant: 72),

            verticalStackView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
        ])
    }
}
