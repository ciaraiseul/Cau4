import UIKit

class ViewController: UIViewController {
    
    var resultLabel: UILabel!
    var userChoiceImageView: UIImageView!
    var computerChoiceImageView: UIImageView!
    var userLabel: UILabel!
    var computerLabel: UILabel!
    
    let userChoices = ["buaYou", "giayYou", "keoYou"]
    let computerChoices = ["buaComputer", "giayComputer", "keoComputer"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        resultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        resultLabel.center = view.center
        resultLabel.text = "Let's Play!"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.boldSystemFont(ofSize: 50) // In đậm và lớn hơn
        view.addSubview(resultLabel)
        
        userChoiceImageView = UIImageView(frame: CGRect(x: 50, y: 200, width: 100, height: 100))
        userChoiceImageView.contentMode = .scaleAspectFit
        userChoiceImageView.isHidden = true
        view.addSubview(userChoiceImageView)
        
        computerChoiceImageView = UIImageView(frame: CGRect(x: view.frame.width - 150, y: 200, width: 100, height: 100))
        computerChoiceImageView.contentMode = .scaleAspectFit
        computerChoiceImageView.isHidden = true
        view.addSubview(computerChoiceImageView)
        
        userLabel = UILabel(frame: CGRect(x: 50, y: 310, width: 100, height: 30))
        userLabel.text = "You"
        userLabel.textAlignment = .center
        userLabel.font = UIFont.systemFont(ofSize: 20)
        userLabel.isHidden = true
        view.addSubview(userLabel)
        
        computerLabel = UILabel(frame: CGRect(x: view.frame.width - 150, y: 310, width: 100, height: 30))
        computerLabel.text = "Computer"
        computerLabel.textAlignment = .center
        computerLabel.font = UIFont.systemFont(ofSize: 20)
        computerLabel.isHidden = true
        view.addSubview(computerLabel)
        
        let buttonImages = ["bua", "giay", "keo"]
        let buttonWidth: CGFloat = 80
        let buttonHeight: CGFloat = 80
        let spacing: CGFloat = 30
        let totalWidth = buttonWidth * 3 + spacing * 2
        
        for (index, imageName) in buttonImages.enumerated() {
            let button = UIButton(frame: CGRect(x: (view.frame.width - totalWidth) / 2 + CGFloat(index) * (buttonWidth + spacing), y: view.frame.height - 150, width: buttonWidth, height: buttonHeight))
            button.setImage(UIImage(named: imageName), for: .normal)
            button.layer.cornerRadius = buttonWidth / 2
            button.layer.masksToBounds = true
            button.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0.4, alpha: 1.0)
            button.tag = index
            button.addTarget(self, action: #selector(userDidSelect(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    @objc func userDidSelect(_ sender: UIButton) {
        let userChoice = sender.tag
        let computerChoice = Int.random(in: 0...2)
        
        userChoiceImageView.image = UIImage(named: userChoices[userChoice])
        computerChoiceImageView.image = UIImage(named: computerChoices[computerChoice])
        
        userChoiceImageView.isHidden = false
        computerChoiceImageView.isHidden = false
        userLabel.isHidden = false
        computerLabel.isHidden = false
        
        let result = determineResult(userChoice: userChoice, computerChoice: computerChoice)
        
        resultLabel.text = result
        
        UIView.animate(withDuration: 0.5) {
            self.resultLabel.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50)
        }
    }
    
    func determineResult(userChoice: Int, computerChoice: Int) -> String {
        if userChoice == computerChoice {
            return "DRAW"
        } else if (userChoice == 0 && computerChoice == 2) ||
                  (userChoice == 1 && computerChoice == 0) ||
                  (userChoice == 2 && computerChoice == 1) {
            return "WIN"
        } else {
            return "LOSE"
        }
    }
}
