import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var jukeboxLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startButton: UIButton!

    private var buttonGradientLayer: CAGradientLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientBackground()
        styleJukeboxLabel()
        styleNeonTextField()
        styleNeonButton()
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            tabBarVC.selectedIndex = 0

            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
           if let gradient = buttonGradientLayer {
               gradient.frame = startButton.bounds
               let shape = CAShapeLayer()
               shape.lineWidth = 2
               shape.path = UIBezierPath(roundedRect: startButton.bounds, cornerRadius: startButton.layer.cornerRadius).cgPath
               shape.fillColor = UIColor.clear.cgColor
               shape.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
               gradient.mask = shape
           }
    }

    func setupGradientBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.systemPurple.withAlphaComponent(0.4).cgColor,
            UIColor.black.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.insertSublayer(gradient, at: 0)
    }

    func styleJukeboxLabel() {
        jukeboxLabel.text = "Jukebox"
        jukeboxLabel.textColor = UIColor.systemPink
        jukeboxLabel.font = UIFont(name: "SnellRoundhand-Bold", size: 58) ?? UIFont.systemFont(ofSize: 48, weight: .bold)
        jukeboxLabel.layer.shadowColor = UIColor.systemPink.cgColor
        jukeboxLabel.layer.shadowRadius = 8
        jukeboxLabel.layer.shadowOpacity = 1.0
        jukeboxLabel.layer.shadowOffset = .zero
    }

    func styleNeonTextField() {
        nameField.placeholder = "What's your name?"
        nameField.textColor = .white
        nameField.tintColor = .systemPink
        nameField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        nameField.layer.cornerRadius = 30
        nameField.layer.borderColor = UIColor.systemPink.cgColor
        nameField.layer.borderWidth = 1.5
        nameField.layer.shadowColor = UIColor.systemPink.cgColor
        nameField.layer.shadowRadius = 4
        nameField.layer.shadowOpacity = 0.8
        nameField.layer.shadowOffset = .zero
        
        nameField.setLeftPaddingPoints(12)
    }


    
    func styleNeonButton() {
        startButton.setTitle("Start Listening", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        startButton.layer.cornerRadius = 30
        startButton.clipsToBounds = true

        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.systemPink.cgColor,
            UIColor.systemPurple.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 30
        buttonGradientLayer = gradient
        startButton.layer.insertSublayer(gradient, at: 0)

        startButton.layer.shadowColor = UIColor.white.cgColor
        startButton.layer.shadowRadius = 12
        startButton.layer.shadowOpacity = 1
        startButton.layer.shadowOffset = .zero
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
