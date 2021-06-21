//
//  ViewController.swift
//  ConcentrationTask1
//
//  Created by OSX 12 on 6/14/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var theme: [[String]] = []
    
    private var themeColorButton: UIColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
    private var themeColorBackground: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private var randomTheme: [String] = []
    
    private var randomThemeColor: [UIColor] = [#colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1),#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
    private var randomThemeColorBackground: [UIColor] = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
    
    private var animals: [String] = []
    private var sports: [String] = []
    private var faces: [String] = []
    private var cars: [String] = []
    private var flags: [String] = []
    private var foods: [String] = []
    
    @IBOutlet var buttonsArr: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        
        setupTheme()
        setupThemeColor()
        
        game.reset_game()
        
        emojiDictionary = [:]
        
        
        for index in buttonsArr.indices{
            updateUiFor(index:index)
        }
    }
    
    @IBOutlet weak var scoreLbl: UILabel!{
        didSet{
            scoreLbl.text = "Score : \(game.score)"
        }
    }
    @IBOutlet weak var flipsCountLbl: UILabel!{
        didSet{
            flipsCountLbl.text = "Flips : \(flips_count)"
        }
    }
    
    private(set) var flips_count : Int = 0{
        didSet{
            flipsCountLbl.text = "Flips : \(flips_count)"
        }
    }
    private(set) var score : Int = 0{
        didSet{
            scoreLbl.text = "Score : \(game.score)"
        }
    }
    lazy var game = Concentration(numberOfCards: buttonsArrCount)
    
    var buttonsArrCount : Int{
        return (buttonsArr.count + 1) / 2
    }
    
    
    @IBAction func clickCardBtn(_ sender: UIButton) {
        
        
        if let index = buttonsArr.index(of:sender) {
            // update model
            game.chooseCard(index:index)
            // update ui
            updateUiFor(index:index)
        }else{
            print("sorry index not exist")
        }
       
    }
    
    func updateUiFor(index:Int){

        for index in buttonsArr.indices{
            var card = game.cards[index]
            var btn = buttonsArr[index]
            if card.isFaceUp{
                btn.backgroundColor = UIColor.white
                btn.setTitle(getEmojiiFor(card : card), for: .normal)
            }else{
                btn.backgroundColor = card.isMatched ? UIColor.clear : themeColorButton
                btn.setTitle("", for: .normal)
            }
        }
        
        flips_count = game.flips_count
        score = game.score
        
    }
    
    var emojiDictionary : [Int:String] =  [Int:String]()
    //var data_source = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"]
    
    func getEmojiiFor(card : Card)->String{
        
        
        if  emojiDictionary[card.identifier] == nil && randomTheme.count > 0{
        
            var random_emoji_index = randomTheme.count.arc4random
            emojiDictionary[card.identifier] = randomTheme.remove(at: random_emoji_index)
        }
        
        return emojiDictionary[card.identifier] ?? "??"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTheme()
    }


}


extension Int{
    var arc4random:Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}


extension ViewController{
    
    private func setupTheme() {
        animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
        sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅", "🏒"]
        faces = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂"]
        cars = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛"]
        flags = ["🇹🇼", "🇯🇵", "🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇱🇷", "🎌", "🇨🇦", "🇳🇵", "🇬🇪"]
        foods = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"]
        
        theme = [animals, sports, faces, cars, flags, foods]
        randomTheme = getRandomTheme
    }
    
    var getRandomTheme:[String]{
        theme.shuffle()
        return theme[theme.count.arc4random]
    }
    var getRandomThemeColorBackground:UIColor{
        randomThemeColorBackground.shuffle()
        return randomThemeColorBackground[randomThemeColorBackground.count.arc4random]
    }
    var getRandomColrTheme:UIColor{
        randomThemeColor.shuffle()
        return randomThemeColor[randomThemeColor.count.arc4random]
    }

    private func setupThemeColor() {
        themeColorButton = getRandomColrTheme
        themeColorBackground = getRandomThemeColorBackground
        
        for btn in buttonsArr{
            btn.backgroundColor = themeColorButton
        }
        self.view.backgroundColor = themeColorBackground
    }
}
