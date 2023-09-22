//
//  UserDetailsViewController.swift
//  RandomUser
//
//  Created by Emin Emini on 22.09.2023..
//

import UIKit

class UserDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var genderAgeLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityCountryLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var registeredDateLabel: UILabel!
    
    //MARK: - Properties
    //User data
    var user: User? {
        didSet {
            //updateViews()
        }
    }
    
    //Gestures
    private var pan: UIPanGestureRecognizer!
    let darknessThreshold: CGFloat = 0.2
    let dismissThreshold: CGFloat = 60.0 * UIScreen.main.nativeScale
    var dismissFeedbackTriggered = false

    //MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpPanGesture()
        setUpCardView()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
        guard let user = user else { return }
        configureUserDetailsView(with: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0.2, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        })
    }

    //MARK: - Actions
    @IBAction func goBack() {
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "modalIsDimissed"), object: nil)
        }
    }

}

//MARK: - Functions
extension UserDetailsViewController {
    
    /*
    This function adds shadow to Card View  */
    func setUpCardView() {
        cardView.layer.shadowColor = UIColor.darkGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 8
    }
    
    /*
    This function updates Labels and Images from selected Table View Cell  */
    func configureUserDetailsView(with user: User) {
        if let photoString = user.picture?.large,
           let photoURL = URL(string: photoString) {
            profilePicture.kf.setImage(with: photoURL)
        }
        
        // Handling Name
        if let firstName = user.name?.first, let lastName = user.name?.last {
            nameLabel.text = "\(firstName) \(lastName)"
        } else {
            nameLabel.text = "Name not available"
        }
        
        // Handling Username
        if let username = user.login?.username {
            usernameLabel.text = "@\(username)"
        } else {
            usernameLabel.text = "Username not available"
        }
        
        // Handling Gender and Age
        if let age = user.dob?.age {
            genderAgeLabel.text = "\(user.gender) \(age)"
        } else {
            genderAgeLabel.text = "\(user.gender)"
        }
        
        // Handling Birthdate
        if let dob = user.dob?.date {
            birthdateLabel.text = formatDate(date: dob, withTime: false)
        } else {
            birthdateLabel.text = "Birthdate not available"
        }
        
        // Handling Street
        if let streetNumber = user.location?.street?.number, let streetName = user.location?.street?.name {
            streetLabel.text = "\(streetNumber) \(streetName)"
        } else {
            streetLabel.text = "Street not available"
        }
        
        // Handling City and Country
        if let city = user.location?.city, let state = user.location?.state, let country = user.location?.country {
            cityCountryLabel.text = "\(city), \(state), \(country)"
        } else {
            cityCountryLabel.text = "Location not available"
        }
        
        phoneLabel.text = user.phone
        emailLabel.text = user.email
        
        // Handling Registered Date
        if let registeredDate = user.registered?.date {
            registeredDateLabel.text = "Registered on \(formatDate(date: registeredDate, withTime: true))"
        } else {
            registeredDateLabel.text = "Registration date not available"
        }
    }

    
    /*
    This function formats date in the way you select.
    For instance:
    The received date is "1951-03-25T19:11:03.083Z",
    It will format it to "25 March 1951, 7:11pm"    */
    func formatDate(date: String, withTime: Bool) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        if withTime {
            dateFormatter.dateFormat = "dd MMMM yyyy, HH:mma"
            dateFormatter.amSymbol = "am"
            dateFormatter.pmSymbol = "pm"
            
        } else {
            dateFormatter.dateFormat = "dd MMMM yyyy"
        }
       let dateObj: Date? = dateFormatterGet.date(from: date)

       return dateFormatter.string(from: dateObj!)
    }
}

//MARK: - Gesture Recognizers Functions
extension UserDetailsViewController {
    
    func setUpPanGesture() {
        self.pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction))
        self.pan.delegate = self
        self.pan.maximumNumberOfTouches = 1
        self.pan.cancelsTouchesInView = true

        cardView.addGestureRecognizer(self.pan)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.pan {
            return limitPanAngle(self.pan, degreesOfFreedom: 45.0, comparator: .greaterThan)
        }

        return true
    }
    
    private func updatePresentedViewForTranslation(_ yTranslation: CGFloat) {
        let translation: CGFloat = rubberBandDistance(yTranslation, dimension: cardView.frame.height, constant: 0.55)

        cardView.transform = CGAffineTransform(translationX: 0, y: max(translation, 0.0))
    }
    
    @objc private func panAction(gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.isEqual(self.pan) else {
            return
        }

        switch gestureRecognizer.state {
        case .began:
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: cardView)

        case .changed:
            let translation = gestureRecognizer.translation(in: cardView)

            self.updatePresentedViewForTranslation(translation.y)

            if translation.y > self.dismissThreshold, !self.dismissFeedbackTriggered {
                self.dismissFeedbackTriggered = true
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
        case .ended, .failed:
            let translation = gestureRecognizer.translation(in: cardView)

            if translation.y > self.dismissThreshold {
                self.goBack()
                return
            }

            self.dismissFeedbackTriggered = false

            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           usingSpringWithDamping: 0.75,
                           initialSpringVelocity: 1.5,
                           options: .preferredFramesPerSecond60,
                           animations: {
                            self.cardView.transform = .identity
            })
            
        case .cancelled:
            UIView.animate(withDuration: 0.1, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(1.0)
            })

        default: break
        }
    }
    
}
