

import SpriteKit
import AudioToolbox

struct WorkCategory {
    static let Bunny: UInt32 = 0x1 << 1
    static let Ground: UInt32 = 0x2 << 2
    static let Carrot: UInt32 = 0x3 << 3
    static let Block: UInt32 = 0x4 << 4
    static let RBlock: UInt32 = 0x5 << 5
    
    
}





class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var Bunny = SKSpriteNode()
    var Ground = SKSpriteNode()
    var Carrot = SKSpriteNode()
    var Block = SKSpriteNode()
    var gameBegin = Bool()
    var Score = NSInteger()
    var RBlock = SKSpriteNode()
    var ScoreLabel = SKLabelNode()
    var Strike = Int()
    var StrikeLabel = String()
    var StrikeShow = SKLabelNode()
    var Hard = SKLabelNode()
    var Medium = SKLabelNode()
    var Easy = SKLabelNode()
    var Background = SKSpriteNode()
    var levelLabel = SKLabelNode()
    var Replay = SKSpriteNode()
    var bigCarrot = SKSpriteNode()
    var highScore = SKLabelNode()
    var higher = Int()
    var Instruction = SKLabelNode()
    var Info = SKLabelNode()
    var fenceWarning = SKLabelNode()
    var LFenceWarning = SKLabelNode()
    var base = SKSpriteNode()
    var details = SKLabelNode()
    var d2 = SKLabelNode()
    var d3 = SKLabelNode()
    var d4 = SKLabelNode()
    var d5 = SKLabelNode()
    var d6 = SKLabelNode()
    var mic = SKSpriteNode()
    var mute = SKSpriteNode()
    var muteOn = Bool()
    func startScene() {
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, -4)
        
        
        Background = SKSpriteNode(imageNamed: "neha")
        Background.anchorPoint = CGPointZero
        self.addChild(Background)

        Ground = SKSpriteNode(imageNamed: "grass")
        Ground.size = CGSize(width: self.frame.width, height: self.frame.height/7)
        Ground.position = CGPoint(x: self.frame.width/2, y: Ground.size.height)
        Ground.physicsBody = SKPhysicsBody(rectangleOfSize: Ground.size)
        Ground.physicsBody?.categoryBitMask = WorkCategory.Ground
        Ground.physicsBody?.collisionBitMask = WorkCategory.Carrot
        Ground.physicsBody?.contactTestBitMask = WorkCategory.Carrot
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.dynamic = false
        Ground.zPosition = 3
        
        self.addChild(Ground)
        
        base = SKSpriteNode(imageNamed: "grass")
        base.size = CGSize(width: self.frame.width, height: self.frame.height/7)

        base.position = CGPoint(x: self.frame.width/2, y: 0)
        base.zPosition = 3
        self.addChild(base)
        
        
        
        //shows levels
        
        Hard.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 - 105)
        Hard.fontName = "Marker Felt"
        Hard.text = "Hard"
        Hard.zPosition = 10
        Hard.fontColor = UIColor.blackColor()
        Hard.fontSize = 60
        self.addChild(Hard)
        
        Easy.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 185)
        Easy.fontName = "Marker Felt"
        Easy.text = "Easy"
        Easy.fontSize = 60
        Easy.zPosition = 10
        Easy.fontColor = UIColor.blackColor()
        self.addChild(Easy)
        
        
        Medium.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 40)
        Medium.fontName = "Marker Felt"
        Medium.fontSize = 60
        Medium.text = "Medium"
        Medium.zPosition = 10
        Medium.fontColor = UIColor.blackColor()
        self.addChild(Medium)
        
        Info.position = CGPoint(x: self.frame.width - 100 , y: self.frame.height - 150)
        Info.fontName = "Marker Felt"
        Info.fontSize = 60
        Info.text = "Info"
        Info.zPosition = 10
        Info.fontColor = UIColor.blackColor()
        self.addChild(Info)
        
        
        
        //restart button
        Replay = SKSpriteNode(imageNamed: "Replay")
        Replay.position = CGPoint(x: 100, y: self.frame.height - 150)
        Replay.size = CGSize(width: 100, height: 100)
        Replay.zPosition = 12
        self.addChild(Replay)
        
        
        
        //big carrot next to score label
        
        bigCarrot = SKSpriteNode(imageNamed: "Carrot")
        bigCarrot.position = CGPoint(x: self.frame.width/2 + 60, y: self.frame.height - 175)
        bigCarrot.size = CGSize(width:75, height:75)
        bigCarrot.zPosition = 12
        
        ScoreLabel.text = "\(Score)"
        ScoreLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 200)
        ScoreLabel.fontName = "Marker Felt"
        ScoreLabel.fontSize = 80
        ScoreLabel.zPosition = 12
        ScoreLabel.fontColor = UIColor.blackColor()
        
        StrikeLabel = "Strikes:"+"\(Strike)"
        StrikeShow.text = StrikeLabel
        StrikeShow.position = CGPoint(x: self.frame.width/2 + 300, y: self.frame.height - 200 )
        StrikeShow.fontName = "Marker Felt"
        StrikeShow.fontSize = 60
        StrikeShow.zPosition = 12
        StrikeShow.fontColor = UIColor.blackColor()
        
        
        levelLabel.text = ""
        levelLabel.position = CGPoint(x: self.frame.width/2 + 300, y: self.frame.height - 300)
        levelLabel.fontName = "Marker Felt"
        levelLabel.fontSize = 40
        levelLabel.zPosition = 12
        levelLabel.fontColor = UIColor.blackColor()
        self.addChild(levelLabel)
        // game instructions
        Instruction.text = "Tap the screen to make the bunny hop"
        Instruction.position = CGPoint(x: 500, y: Ground.size.height)
        Instruction.zPosition = 12
        Instruction.fontSize = 40
        Instruction.fontColor = UIColor.blackColor()
        Instruction.fontName = "Marker Felt"
        
        
        
        fenceWarning.text = "Hop over fence"
        fenceWarning.position = CGPoint(x: self.frame.width - 150, y: Ground.frame.height + 100)
        fenceWarning.fontName = "Marker Felt"
        fenceWarning.fontSize = 30
        fenceWarning.zPosition = 12
        fenceWarning.fontColor = UIColor.blackColor()
       
        
        
        LFenceWarning.text = "Fences come from both sides"
        LFenceWarning.position = CGPoint(x: 220, y: Ground.frame.height + 100)
        LFenceWarning.fontName = "Marker Felt"
        LFenceWarning.fontSize = 30
        LFenceWarning.zPosition = 12
        LFenceWarning.fontColor = UIColor.blackColor()
        
        
        details.text = "Help Buster the bunny catch carrots to earn points"
        details.position = CGPoint(x: self.frame.width/2 , y: self.frame.height - 150)
        details.fontName = "Marker Felt"
        details.fontSize = 30
        details.zPosition = 12
        details.fontColor = UIColor.blackColor()
        
        

        d2.text = "1. Buster hops to the position of your touch"
        d2.position = CGPoint(x: self.frame.width/2 , y: self.frame.height - 200)
        d2.fontName = "Marker Felt"
        d2.fontSize = 30
        d2.zPosition = 12
        d2.fontColor = UIColor.blackColor()
        
        d3.text = "2. Each time Buster misses a carrot is one strike"
        d3.position = CGPoint(x: self.frame.width/2 + 27, y: self.frame.height - 250)
        d3.fontName = "Marker Felt"
        d3.fontSize = 30
        d3.zPosition = 12
        d3.fontColor = UIColor.blackColor()

        d4.text = "3. The game is over when Buster hits the fence"
        d4.position = CGPoint(x: self.frame.width/2 + 17, y: self.frame.height - 300)
        d4.fontName = "Marker Felt"
        d4.fontSize = 30
        d4.zPosition = 12
        d4.fontColor = UIColor.blackColor()
        
        d5.text = "5. Three strikes and the game is over"
        d5.position = CGPoint(x: self.frame.width/2 - 45, y: self.frame.height - 350)
        d5.fontName = "Marker Felt"
        d5.fontSize = 30
        d5.zPosition = 12
        d5.fontColor = UIColor.blackColor()
        
        
        d6.text = "6. Avoid all fences and catch carrots. Good luck!"
        d6.position = CGPoint(x: self.frame.width/2 + 25, y: self.frame.height - 400)
        d6.fontName = "Marker Felt"
        d6.fontSize = 30
        d6.zPosition = 12
        d6.fontColor = UIColor.blackColor()


        
        
        
        mic = SKSpriteNode(imageNamed: "mic")
        mic.size = CGSize(width: 100, height: 100)
        mic.position = CGPoint(x: 200, y: self.frame.height - 150)
        mic.zPosition = 12
        self.addChild(mic)
        
        

        
        
        Bunny = SKSpriteNode(imageNamed: "Bunnyblush")
        Bunny.size = CGSize(width: 100, height: 100)
        Bunny.position = CGPoint(x: self.frame.width/2, y: Ground.frame.height + Bunny.frame.height)
        Bunny.name = "Bunny"
        Bunny.physicsBody = SKPhysicsBody(circleOfRadius: Bunny.size.height/2)
        Bunny.physicsBody?.categoryBitMask = WorkCategory.Bunny
        Bunny.physicsBody?.collisionBitMask = WorkCategory.Carrot | WorkCategory.Block | WorkCategory.RBlock
        Bunny.physicsBody?.contactTestBitMask = WorkCategory.Carrot | WorkCategory.Block | WorkCategory.RBlock
        Bunny.physicsBody?.affectedByGravity = true
        Bunny.physicsBody?.dynamic = true
        Bunny.physicsBody?.allowsRotation = false
        Bunny.zPosition = 2
        
        
        self.addChild(Bunny)
    }
    
    
    override func didMoveToView(view: SKView){
        self.startScene()
       

    }
    
    
    //my collision code
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        if firstBody.categoryBitMask == WorkCategory.Carrot && secondBody.categoryBitMask == WorkCategory.Bunny || firstBody.categoryBitMask == WorkCategory.Bunny && secondBody.categoryBitMask == WorkCategory.Carrot{
            
            if firstBody == Carrot{
                Bunny.physicsBody?.dynamic = false
                
                removeNode("Carrot")
                Score += 1
                ScoreLabel.text = "\(Score)"
                Bunny.texture = SKTexture(imageNamed: "Bunnycarrotblush")
                if Bunny.physicsBody?.dynamic == false{
                    Bunny.physicsBody?.dynamic = true
                }
            }else {
                Bunny.physicsBody?.dynamic = false
                
                removeNode("Carrot")
               
                Score += 1
                ScoreLabel.text = "\(Score)"
                Bunny.texture = SKTexture(imageNamed: "Bunnycarrotblush")
                if Bunny.physicsBody?.dynamic == false{
                    Bunny.physicsBody?.dynamic = true
                }
            }
        }else if firstBody.categoryBitMask == WorkCategory.Carrot && secondBody.categoryBitMask == WorkCategory.Ground || firstBody.categoryBitMask == WorkCategory.Ground && secondBody.categoryBitMask == WorkCategory.Carrot{
            if firstBody == Carrot{
                
                removeNode("Carrot")
                
                self.showStrikes()
                if Strike == 3{
                    self.stopScene()
                    
                }
            }else {
                removeNode("Carrot")
                self.showStrikes()
                if Strike == 3{
                    self.stopScene()
                    
                }
                
                
            }
            
        }else if firstBody.categoryBitMask == WorkCategory.Bunny && secondBody.categoryBitMask == WorkCategory.Block || firstBody.categoryBitMask == WorkCategory.Block && secondBody.categoryBitMask == WorkCategory.Bunny{
            self.stopScene()
            if muteOn == false{
                SystemSoundID.playSound("crash")
            }
            
        }else if firstBody.categoryBitMask == WorkCategory.Bunny && secondBody.categoryBitMask == WorkCategory.RBlock || firstBody.categoryBitMask == WorkCategory.RBlock && secondBody.categoryBitMask == WorkCategory.Bunny{
            self.stopScene()
            if muteOn == false{
                SystemSoundID.playSound("crash")
            }
            
        }
    }
    

    func showStrikes(){
        Strike += 1
        StrikeShow.text = "Strikes:"+"\(Strike)"
        
    }
    func showLabels(){
        self.addChild(bigCarrot)
        self.addChild(StrikeShow)
        self.addChild(ScoreLabel)
    }
    func stopScene(){
        removeActionForKey("CreateForever")
        removeActionForKey("moveForever")
        removeActionForKey("RmoveForever")
        Block.removeFromParent()
        RBlock.removeFromParent()
        removeCarrot()
        StrikeShow.text = "Game Over!"
        self.highScoreShow()
        Replay.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        Replay.size = CGSize(width: 200, height: 200)
    
        
        
        
    }
    
    func removeCarrot(){
        enumerateChildNodesWithName("Carrot"){
            node, stop in
            node.removeFromParent()
        }
    }
    func removeNode(name: String){
        enumerateChildNodesWithName(name){
            node, stop in
            node.removeFromParent()
        }
    }
        

    
    
    func removeLevel(){
        Hard.removeFromParent()
        Hard.position = CGPoint(x: self.frame.width*2, y: self.frame.height*2)
        
        Easy.removeFromParent()
        Easy.position = CGPoint(x: self.frame.width*2, y: self.frame.height*2)
        
        Medium.removeFromParent()
        Medium.position = CGPoint(x: self.frame.width*2, y: self.frame.height*2)
        
        Info.removeFromParent()
        Info.position = CGPoint(x: self.frame.width*2, y: self.frame.height*2)
        
        
        
        
    }
    
    func restart(){
        self.removeAllActions()
        self.removeAllChildren()
        Strike = 0
        StrikeShow.text = "Strikes:"+"\(Strike)"
        Score = 0
        startScene()
        gameBegin = false
        if muteOn == true{
            mic.texture = SKTexture(imageNamed: "mute")
        }
        
    }
    func highScoreShow(){
        highScore.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 275)
        highScore.zPosition = 12
        highScore.fontSize = 50
        highScore.fontColor = UIColor.blackColor()
        highScore.fontName = "Marker Felt"
        self.calculateHigh()
        self.addChild(highScore)
        
    
    }
    
    
    //shows highscore
    func calculateHigh() {
         let defaults = NSUserDefaults.standardUserDefaults()
        if levelLabel.text == "Easy" {
            let maxEasy = defaults.integerForKey("maxEasy")
            
            if Score > maxEasy{
                highScore.text = "New Highscore:" + "\((Score))"
                defaults.setInteger(Score, forKey: "maxEasy")
                
            } else{
                highScore.text = "Highscore:" + "\(maxEasy)"
            }

        }else if levelLabel.text == "Medium"{
            let maxMedium = defaults.integerForKey("maxMedium")
            
            if Score > maxMedium{
                highScore.text = "New Highscore:" + "\((Score))"
                defaults.setInteger(Score, forKey: "maxMedium")
                
            } else{
                highScore.text = "Highscore:" + "\(maxMedium)"
               
            }
        
            
        }else {
            let maxHard = defaults.integerForKey("maxHard")

                if Score > maxHard{
                highScore.text = "New Highscore:" + "\((Score))"
                defaults.setInteger(Score, forKey: "maxHard")
                
            } else{
                highScore.text = "Highscore:" + "\(maxHard)"
            }
            

           
        }
    }
        //creates carrots and fences
    func createCarrots() {
        Carrot = SKSpriteNode(imageNamed: "Carrot")
        Carrot.size = CGSize(width: 45, height: 60)
        Carrot.position = CGPoint(x: self.frame.width/2, y: self.frame.height + 200)
        
        Carrot.physicsBody = SKPhysicsBody(rectangleOfSize: Carrot.size)
        Carrot.physicsBody?.categoryBitMask = WorkCategory.Carrot
        Carrot.physicsBody?.collisionBitMask = WorkCategory.Bunny | WorkCategory.Ground
        Carrot.physicsBody?.contactTestBitMask = WorkCategory.Bunny | WorkCategory.Ground
        Carrot.physicsBody?.affectedByGravity = true
        Carrot.physicsBody?.dynamic = true
        Carrot.zPosition = 1
        Carrot.name = "Carrot"
        let diffPosition = CarrotRandom(-500, max: 500)
        Carrot.position.x = Carrot.position.x + diffPosition
        self.addChild(Carrot)
        
    }
    
    

    
    func createBlock(){
        
        Block = SKSpriteNode(imageNamed: "Block")
        Block.size = CGSize(width: 100, height: 50)
        Block.position = CGPoint(x: -100, y: Ground.size.height + Block.size.height + 30)
        Block.zPosition = 1.25
        
        Block.physicsBody = SKPhysicsBody(rectangleOfSize: Block.size)
        
        Block.physicsBody?.categoryBitMask = WorkCategory.Block
        Block.physicsBody?.affectedByGravity = false
        Block.physicsBody?.dynamic = false
        Block.physicsBody?.contactTestBitMask = WorkCategory.Bunny
        Block.physicsBody?.collisionBitMask = WorkCategory.Bunny
        
        self.addChild(Block)
        
    }
    func createRBlocks(){
        RBlock = SKSpriteNode(imageNamed: "Block")
        RBlock.size = CGSize(width: 100, height: 50)
        RBlock.position = CGPoint(x: self.frame.width + 100, y: Ground.size.height + RBlock.size.height + 30)
        RBlock.zPosition = 1.5
        RBlock.physicsBody = SKPhysicsBody(rectangleOfSize: RBlock.size)
        RBlock.physicsBody?.categoryBitMask = WorkCategory.RBlock
        RBlock.physicsBody?.affectedByGravity = false
        RBlock.physicsBody?.dynamic = false
        RBlock.physicsBody?.contactTestBitMask = WorkCategory.Bunny
        RBlock.physicsBody?.collisionBitMask = WorkCategory.Bunny
        self.addChild(RBlock)

    }
    
    
    //speeds of carrots and fences
    func speedCarrots(timeDuration: NSTimeInterval) {
        let create = SKAction.runBlock({
            () in
            self.createCarrots()
        })
        let wait = SKAction.waitForDuration(timeDuration)
        let CreateWait = SKAction.sequence([create,wait])
        let CreateForever = SKAction.repeatActionForever(CreateWait)
        self.runAction(CreateForever, withKey: "CreateForever")
        
        
        
    }
    func speedFence(time: NSTimeInterval, secondTime: NSTimeInterval){
        //self.createBlock()
        let leftFence = SKAction.moveByX(self.frame.width, y: 0, duration: time)
        let leftWait = SKAction.waitForDuration(secondTime)
        let rightFence = SKAction.moveByX(-self.frame.width, y: 0, duration: time)
        let leftRight = SKAction.sequence([leftFence, leftWait, rightFence])
        let moveForever = SKAction.repeatActionForever(leftRight)
        Block.runAction(moveForever, withKey: "moveForever")
        
        
        
    }
    func speedRFence(time: NSTimeInterval, secondTime: NSTimeInterval){
        //self.createRBlocks()
        let leftFence = SKAction.moveByX(self.frame.width - 50, y: 0, duration: time)
        let rightWait = SKAction.waitForDuration(secondTime)
        let rightFence = SKAction.moveByX(-self.frame.width, y: 0, duration: time)
        let rightLeft = SKAction.sequence([rightFence, rightWait, leftFence])
        let moveForever = SKAction.repeatActionForever(rightLeft)
        RBlock.runAction(moveForever, withKey: "RmoveForever")
    }
        //for when you touch the screen
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if gameBegin == false{
            for touch in touches {
                
                let location = touch.locationInNode(self)
                if Hard.containsPoint(location){
                    createRBlocks()
                    createBlock()
                    physicsWorld.gravity = CGVectorMake(0, -7)
                    self.removeLevel()
                    levelLabel.text = "Hard"
                    self.showLabels()
                    speedCarrots(0.8)
                    self.speedFence(2,secondTime: 1)
                    self.speedRFence(4, secondTime: 2)
                    Instruction.removeFromParent()
                    fenceWarning.removeFromParent()
                    LFenceWarning.removeFromParent()
                    if muteOn == false{
                         SystemSoundID.playSound("click")
                    }
                   
                    
                }else if Medium.containsPoint(location){
                    createBlock()
                    createRBlocks()
                    physicsWorld.gravity = CGVectorMake(0, -5)
                    self.removeLevel()
                    self.showLabels()
                    levelLabel.text = "Medium"
                    speedCarrots(0.9)
                    self.speedFence(3,secondTime: 1.5)
                    self.speedRFence(5,secondTime:  2.5)
                    Instruction.removeFromParent()
                    fenceWarning.removeFromParent()
                    LFenceWarning.removeFromParent()
                    if muteOn == false{
                        SystemSoundID.playSound("click")
                    }
                }else if Easy.containsPoint(location){
                    //createBlock()
                    self.removeLevel()
                    self.showLabels()
                    levelLabel.text = "Easy"
                    speedCarrots(1)
                    Instruction.removeFromParent()
                    fenceWarning.removeFromParent()
                    LFenceWarning.removeFromParent()
                    self.speedFence(2.5, secondTime: 1)
                    if muteOn == false{
                        SystemSoundID.playSound("click")

                    }
                        
                    
                    
                    
                }else if Info.containsPoint(location){
                    self.addChild(Instruction)
                    self.addChild(fenceWarning)
                    self.addChild(LFenceWarning)
                    self.removeLevel()
                    self.addChild(details)
                    self.addChild(d2)
                    self.addChild(d3)
                    self.addChild(d4)
                    self.addChild(d5)
                    self.addChild(d6)
                    mic.position = CGPoint(x: 100, y: self.frame.height - 275)
                    if muteOn == false{
                        SystemSoundID.playSound("click")
                    }
                    
                    
                    
                }else if Replay.containsPoint(location){
                    self.restart()
                    if muteOn == false{
                         SystemSoundID.playSound("click")
                    }
                    
                } else if mic.containsPoint(location){
                    if muteOn == false {
                        mic.texture = SKTexture(imageNamed: "mute")
                        muteOn = true
                        SystemSoundID.playSound("click")
                    } else if muteOn == true{
                        mic.texture = SKTexture(imageNamed: "mic")
                        muteOn = false
                        SystemSoundID.playSound("click")
                    }
                   
                }else {
                    
                    let location = touch.locationInNode(self)
                    let moveAction = SKAction.moveByX(location.x - Bunny.position.x , y: 100, duration: 0.02)
                    Bunny.runAction(moveAction)
                    if muteOn == false{
                        SystemSoundID.playSound("hop")
                    }
                    
                    
                    
                    
                }
            }
        }
        
    }
    
    
    //Called when a touch begins
    
    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
       }
    
}
