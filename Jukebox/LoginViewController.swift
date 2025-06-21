import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var jukeboxLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startButton: UIButton!

    private var buttonGradientLayer: CAGradientLayer?
    private var glowBorderLayer: CAShapeLayer?
    private var gradientLayer: CAGradientLayer?
    
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
            gradient.cornerRadius = startButton.bounds.height / 2

            let shape = CAShapeLayer()
            shape.lineWidth = 2
            shape.path = UIBezierPath(roundedRect: startButton.bounds, cornerRadius: startButton.layer.cornerRadius).cgPath
            shape.fillColor = UIColor.clear.cgColor
            shape.strokeColor = UIColor.white.withAlphaComponent(0.8).cgColor
            gradient.mask = shape
        }

        if let glow = glowBorderLayer {
            glow.path = UIBezierPath(roundedRect: startButton.bounds, cornerRadius: startButton.layer.cornerRadius).cgPath
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
        jukeboxLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 58) ?? UIFont.systemFont(ofSize: 48, weight: .bold)
        jukeboxLabel.layer.shadowColor = UIColor.white.cgColor
        jukeboxLabel.layer.shadowRadius = 10
        jukeboxLabel.layer.shadowOpacity = 3.0
        jukeboxLabel.layer.shadowOffset = .zero
    }

    func styleNeonTextField() {
        nameField.placeholder = "What's your name?"
        nameField.textColor = .white
        nameField.layer.cornerRadius = 30
        nameField.backgroundColor = UIColor.loginScreen.withAlphaComponent(CGFloat(0.8))
        nameField.layer.borderColor = UIColor.clear.cgColor
        nameField.layer.borderWidth = 1.5
        nameField.layer.shadowColor = UIColor.white.cgColor
        nameField.layer.shadowRadius = 4
        nameField.layer.shadowOpacity = 0.8
        nameField.layer.shadowOffset = .zero
        
        nameField.setLeftPaddingPoints(12)
    }


    
    func styleNeonButton() {
        startButton.setTitle("Start Listening", for: .normal)
         startButton.setTitleColor(.white, for: .normal)
         startButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)

         startButton.layer.cornerRadius = startButton.bounds.height / 2
         startButton.clipsToBounds = true

         gradientLayer = CAGradientLayer()
         gradientLayer?.colors = [UIColor.loginScreen.cgColor, UIColor.loginScreen.cgColor]
         gradientLayer?.startPoint = CGPoint(x: 0, y: 0.5)
         gradientLayer?.endPoint = CGPoint(x: 1, y: 0.5)

         glowBorderLayer = CAShapeLayer()
         glowBorderLayer?.fillColor = UIColor.clear.cgColor
         glowBorderLayer?.strokeColor = UIColor.white.cgColor
         glowBorderLayer?.lineWidth = 2
         glowBorderLayer?.shadowColor = UIColor.systemPink.cgColor
         glowBorderLayer?.shadowRadius = 8
         glowBorderLayer?.shadowOpacity = 1.0
         glowBorderLayer?.shadowOffset = .zero
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
