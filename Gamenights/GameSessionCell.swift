//
//  GameSessionCell.swift
//  Gamenights
//
//  Created by Zhi Huang on 9/27/15.
//  Copyright (c) 2015 T-West. All rights reserved.
//

import UIKit

class GameSessionCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!

    var gameSession: GameSessionModel! {
        didSet {
            dateLabel.text = gameSession.date as String!
            gameSession.getPlayersWithCompletion({ (players: [PlayerModel]?) -> Void in
                self.participantsLabel.text = players?.map({ (player) -> String in
                    player.nickname
                }).joinWithSeparator(", ")
            })
            winnerLabel.text = "Winner: \(gameSession.winner as String!)"
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
