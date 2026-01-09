import UIKit
import LiquidGlassKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = DemoTabViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

class DemoTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup tab bar
        tabBar.backgroundColor = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.15, alpha: 1) : UIColor(white: 0.95, alpha: 1) }

        // Create view controllers
        let sliderVC = UINavigationController(rootViewController: SliderDemoViewController())
        sliderVC.tabBarItem = UITabBarItem(title: "滑块", image: UIImage(systemName: "slider.horizontal.3"), selectedImage: UIImage(systemName: "slider.horizontal.3.fill"))

        let switchVC = UINavigationController(rootViewController: SwitchDemoViewController())
        switchVC.tabBarItem = UITabBarItem(title: "开关", image: UIImage(systemName: "switch.2"), selectedImage: UIImage(systemName: "switch.2"))

        let effectVC = UINavigationController(rootViewController: EffectDemoViewController())
        effectVC.tabBarItem = UITabBarItem(title: "效果", image: UIImage(systemName: "sparkles"), selectedImage: UIImage(systemName: "sparkles"))

        let lensVC = UINavigationController(rootViewController: LensDemoViewController())
        lensVC.tabBarItem = UITabBarItem(title: "镜头", image: UIImage(systemName: "circle.fill"), selectedImage: UIImage(systemName: "circle.fill"))

        viewControllers = [sliderVC, switchVC, effectVC, lensVC]
    }
}

// MARK: - Slider Demo
class SliderDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "液态玻璃滑块"
        view.backgroundColor = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])

        // Demo 1: Basic Slider
        addSectionTitle("基础滑块", to: stackView)
        let slider1 = LiquidGlassSlider()
        slider1.minimumValue = 0
        slider1.maximumValue = 100
        slider1.value = 50
        slider1.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        stackView.addArrangedSubview(slider1)
        NSLayoutConstraint.activate([
            slider1.heightAnchor.constraint(equalToConstant: 44),
        ])

        // Demo 2: Slider with Tint Color
        addSectionTitle("自定义颜色", to: stackView)
        let slider2 = LiquidGlassSlider()
        slider2.minimumValue = 0
        slider2.maximumValue = 100
        slider2.value = 50
        slider2.minimumTrackTintColor = .systemBlue
        stackView.addArrangedSubview(slider2)
        NSLayoutConstraint.activate([
            slider2.heightAnchor.constraint(equalToConstant: 44),
        ])

        // Demo 3: Slider with Min/Max Images
        addSectionTitle("带图标的滑块", to: stackView)
        let slider3 = LiquidGlassSlider()
        slider3.minimumValue = 0
        slider3.maximumValue = 100
        slider3.value = 50
        slider3.minimumValueImage = UIImage(systemName: "volume.1")
        slider3.maximumValueImage = UIImage(systemName: "volume.3")
        stackView.addArrangedSubview(slider3)
        NSLayoutConstraint.activate([
            slider3.heightAnchor.constraint(equalToConstant: 44),
        ])

        // Demo 4: Disabled Slider
        addSectionTitle("禁用滑块", to: stackView)
        let slider4 = LiquidGlassSlider()
        slider4.minimumValue = 0
        slider4.maximumValue = 100
        slider4.value = 50
        slider4.isEnabled = false
        stackView.addArrangedSubview(slider4)
        NSLayoutConstraint.activate([
            slider4.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    @objc private func sliderChanged(_ slider: UISlider) {
        print("Slider value: \(slider.value)")
    }

    private func addSectionTitle(_ title: String, to stackView: UIStackView) {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        stackView.addArrangedSubview(label)
    }
}

// MARK: - Switch Demo
class SwitchDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "液态玻璃开关"
        view.backgroundColor = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])

        // Demo 1: Basic Switch
        let switch1 = LiquidGlassSwitch()
        addSectionWithSwitch("基础开关", switch: switch1, initialState: false, to: stackView)

        // Demo 2: Switch - Enabled
        let switch2 = LiquidGlassSwitch()
        addSectionWithSwitch("启用状态", switch: switch2, initialState: true, to: stackView)

        // Demo 3: Custom Tint Color
        let titleLabel3 = UILabel()
        titleLabel3.text = "自定义颜色"
        titleLabel3.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel3.textColor = .label
        stackView.addArrangedSubview(titleLabel3)

        let switch3 = LiquidGlassSwitch()
        switch3.isOn = false
        switch3.onTintColor = .systemPurple
        switch3.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        let hStack3 = UIStackView()
        hStack3.axis = .horizontal
        hStack3.addArrangedSubview(switch3)
        hStack3.addArrangedSubview(UIView()) // Spacer
        stackView.addArrangedSubview(hStack3)

        // Demo 4: Disabled Switch
        let switch4 = LiquidGlassSwitch()
        let titleLabel4 = UILabel()
        titleLabel4.text = "禁用开关"
        titleLabel4.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel4.textColor = .label
        stackView.addArrangedSubview(titleLabel4)

        switch4.isOn = true
        switch4.isEnabled = false
        let hStack4 = UIStackView()
        hStack4.axis = .horizontal
        hStack4.addArrangedSubview(switch4)
        hStack4.addArrangedSubview(UIView()) // Spacer
        stackView.addArrangedSubview(hStack4)
    }

    private func addSectionWithSwitch(
        _ title: String,
        switch switchView: LiquidGlassSwitch,
        initialState: Bool,
        to stackView: UIStackView
    ) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .label
        stackView.addArrangedSubview(titleLabel)

        switchView.isOn = initialState
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)

        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.addArrangedSubview(switchView)
        hStack.addArrangedSubview(UIView()) // Spacer
        stackView.addArrangedSubview(hStack)
    }

    @objc private func switchChanged(_ switchView: LiquidGlassSwitch) {
        print("Switch changed to: \(switchView.isOn)")
    }
}

// MARK: - Effect Demo
class EffectDemoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "液态玻璃效果"

        // Setup background image view
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.insertSubview(backgroundImageView, at: 0)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        // Set default background color
        view.backgroundColor = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100 + 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])

        // Add import background button
        let importButton = UIButton(type: .system)
        importButton.translatesAutoresizingMaskIntoConstraints = false
        importButton.setTitle("📷 导入背景图片", for: .normal)
        importButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        importButton.backgroundColor = .systemBlue
        importButton.setTitleColor(.white, for: .normal)
        importButton.layer.cornerRadius = 10
        importButton.addTarget(self, action: #selector(importBackgroundImage), for: .touchUpInside)
        stackView.addArrangedSubview(importButton)
        NSLayoutConstraint.activate([
            importButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        // Demo 1: Regular Glass Effect
        addSectionTitle("常规玻璃效果", to: stackView)
        let effectView1 = VisualEffectView(effect: LiquidGlassEffect(style: .regular, isNative: false)) as! UIView
        effectView1.translatesAutoresizingMaskIntoConstraints = false

        let container1 = UIView()
        container1.translatesAutoresizingMaskIntoConstraints = false
        container1.addSubview(effectView1)
        container1.layer.cornerRadius = 16
        container1.clipsToBounds = true

        NSLayoutConstraint.activate([
            effectView1.topAnchor.constraint(equalTo: container1.topAnchor),
            effectView1.bottomAnchor.constraint(equalTo: container1.bottomAnchor),
            effectView1.leadingAnchor.constraint(equalTo: container1.leadingAnchor),
            effectView1.trailingAnchor.constraint(equalTo: container1.trailingAnchor),
        ])

        stackView.addArrangedSubview(container1)
        NSLayoutConstraint.activate([
            container1.heightAnchor.constraint(equalToConstant: 120),
        ])

        // Add some content inside the effect view
        let label1 = UILabel()
        label1.text = "玻璃效果"
        label1.textAlignment = .center
        label1.font = .systemFont(ofSize: 16, weight: .semibold)
        label1.translatesAutoresizingMaskIntoConstraints = false

        if let effectView = effectView1 as? LiquidGlassEffectView {
            effectView.contentView.addSubview(label1)
            NSLayoutConstraint.activate([
                label1.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
                label1.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
            ])
        }

        // Demo 2: Clear Glass Effect (using regular for now)
        addSectionTitle("清晰玻璃效果", to: stackView)
        let effectView2 = VisualEffectView(effect: LiquidGlassEffect(style: .clear, isNative: false)) as! UIView
        effectView2.translatesAutoresizingMaskIntoConstraints = false

        let container2 = UIView()
        container2.translatesAutoresizingMaskIntoConstraints = false
        container2.addSubview(effectView2)
        container2.layer.cornerRadius = 16
        container2.clipsToBounds = true

        NSLayoutConstraint.activate([
            effectView2.topAnchor.constraint(equalTo: container2.topAnchor),
            effectView2.bottomAnchor.constraint(equalTo: container2.bottomAnchor),
            effectView2.leadingAnchor.constraint(equalTo: container2.leadingAnchor),
            effectView2.trailingAnchor.constraint(equalTo: container2.trailingAnchor),
        ])

        stackView.addArrangedSubview(container2)
        NSLayoutConstraint.activate([
            container2.heightAnchor.constraint(equalToConstant: 120),
        ])

        let label2 = UILabel()
        label2.text = "清晰效果"
        label2.textAlignment = .center
        label2.font = .systemFont(ofSize: 16, weight: .semibold)
        label2.translatesAutoresizingMaskIntoConstraints = false

        if let effectView = effectView2 as? LiquidGlassEffectView {
            effectView.contentView.addSubview(label2)
            NSLayoutConstraint.activate([
                label2.centerXAnchor.constraint(equalTo: effectView.contentView.centerXAnchor),
                label2.centerYAnchor.constraint(equalTo: effectView.contentView.centerYAnchor),
            ])
        }
    }

    @objc private func importBackgroundImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            backgroundImageView.image = image
        }
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    private func addSectionTitle(_ title: String, to stackView: UIStackView) {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        stackView.addArrangedSubview(label)
    }
}

// MARK: - Lens Demo
class LensDemoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "液态透镜"

        // Setup background image view
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.insertSubview(backgroundImageView, at: 0)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        // Set default background color
        view.backgroundColor = UIColor { $0.userInterfaceStyle == .dark ? UIColor(white: 0.1, alpha: 1) : .white }

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100 + 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])

        // Add import background button
        let importButton = UIButton(type: .system)
        importButton.translatesAutoresizingMaskIntoConstraints = false
        importButton.setTitle("📷 导入背景图片", for: .normal)
        importButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        importButton.backgroundColor = .systemBlue
        importButton.setTitleColor(.white, for: .normal)
        importButton.layer.cornerRadius = 10
        importButton.addTarget(self, action: #selector(importBackgroundImage), for: .touchUpInside)
        stackView.addArrangedSubview(importButton)
        NSLayoutConstraint.activate([
            importButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        // Demo 1: Static Lens
        addSectionTitle("液态透镜 - 静止状态", to: stackView)
        let lens1 = LiquidLensView()
        lens1.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(lens1)
        NSLayoutConstraint.activate([
            lens1.heightAnchor.constraint(equalToConstant: 60),
            lens1.widthAnchor.constraint(equalToConstant: 60),
        ])

        // Demo 2: Lifted Lens
        addSectionTitle("液态透镜 - 浮起状态", to: stackView)
        let lens2 = LiquidLensView()
        lens2.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(lens2)
        NSLayoutConstraint.activate([
            lens2.heightAnchor.constraint(equalToConstant: 60),
            lens2.widthAnchor.constraint(equalToConstant: 60),
        ])

        // Animate lens2 to lifted state
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            lens2.setLifted(true, animated: true, alongsideAnimations: nil, completion: nil)
        }

        // Demo 3: Multiple Lenses
        addSectionTitle("多个液态透镜", to: stackView)
        let multiLensContainer = UIView()
        multiLensContainer.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(multiLensContainer)
        NSLayoutConstraint.activate([
            multiLensContainer.heightAnchor.constraint(equalToConstant: 80),
        ])

        for i in 0..<3 {
            let lens = LiquidLensView()
            lens.translatesAutoresizingMaskIntoConstraints = false
            multiLensContainer.addSubview(lens)

            NSLayoutConstraint.activate([
                lens.heightAnchor.constraint(equalToConstant: 60),
                lens.widthAnchor.constraint(equalToConstant: 60),
                lens.leadingAnchor.constraint(equalTo: multiLensContainer.leadingAnchor, constant: CGFloat(i * 70)),
                lens.topAnchor.constraint(equalTo: multiLensContainer.topAnchor),
            ])

            // Stagger the lift animations
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 + Double(i) * 0.2) {
                lens.setLifted(true, animated: true, alongsideAnimations: nil) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        lens.setLifted(false, animated: true, alongsideAnimations: nil, completion: nil)
                    }
                }
            }
        }
    }

    @objc private func importBackgroundImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            backgroundImageView.image = image
        }
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    private func addSectionTitle(_ title: String, to stackView: UIStackView) {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        stackView.addArrangedSubview(label)
    }
}

