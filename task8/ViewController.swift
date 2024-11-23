//
//  ViewController.swift
//  task8
//
//  Created by aeroclub on 22.11.2024.
//
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView() // Контейнер для пустого содержимого
    private var largeTitleImageView: UIImageView? // Для хранения ссылки на ваш imageView

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Avatar"

        setupScrollView()
        setupEmptyContent()

        // Теперь вызываем getLargeTitleView для получения изображения
        largeTitleImageView = getLargeTitleView()

        // Проверьте, что navigationBar не nil
        if let largeTitleImageView = largeTitleImageView, let navigationBar = navigationController?.navigationBar {
            navigationBar.addSubview(largeTitleImageView)

            // Устанавливаем constraints для largeTitleImageView
            NSLayoutConstraint.activate([
                largeTitleImageView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16),
                largeTitleImageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -10),
                largeTitleImageView.widthAnchor.constraint(equalToConstant: 36),
                largeTitleImageView.heightAnchor.constraint(equalToConstant: 36)
            ])
        }
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self // Устанавливаем делегат

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Добавляем пустое содержимое в UIScrollView
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Обеспечивает ширину, равную UIScrollView
            contentView.heightAnchor.constraint(equalToConstant: 1200) // Устанавливаем высоту для возможности прокрутки
        ])
    }

    private func setupEmptyContent() {
        // Здесь можно настроить любое пустое содержимое, если нужно
        let emptyView = UIView()
        emptyView.backgroundColor = .clear

        // Добавьте дополнительные настройки или элементы, если нужно
        contentView.addSubview(emptyView)
    }

    private func getLargeTitleView() -> UIImageView {
        let imageView = UIImageView()

        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular, scale: .default)
        let image = UIImage(systemName: "person.crop.circle.fill")?.withConfiguration(symbolConfiguration)

        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false // Обязательно

        return imageView
    }

    // UIScrollViewDelegate метод
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Проверяем, нужно ли скрыть изображение
        if scrollView.contentOffset.y > 0 {
            largeTitleImageView?.isHidden = true // Скрываем изображение
        } else {
            largeTitleImageView?.isHidden = false // Показываем изображение
        }
    }
}
