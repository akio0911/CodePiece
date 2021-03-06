//
//  ViewController+Repliable.swift
//  CodePiece
//
//  Created by Tomohiro Kumagai on 1/19/16.
//  Copyright © 2016 EasyStyle G.K. All rights reserved.
//

import Cocoa
import ESTwitter

protocol ViewControllerSelectable : class {
	
	var selectedStatuses: Array<ESTwitter.Status> { get }
}

protocol ViewControllerRepliable : class {
	
	var statusForReplyTo: ESTwitter.Status? { get }
	
	var canReplyTo: Bool { get }
}

protocol ViewControllerSelectionAndRepliable : ViewControllerSelectable, ViewControllerRepliable {
	
	func setReplyToBySelectedStatuses()
}

protocol LatestTweetReplyable : LatestTweetManageable {
	
	func setReplyToByLatestTweet()
}

extension ViewControllerSelectable {
	
	var canReplyToSelectedStatuses: Bool {
		
		return selectedStatuses.count == 1
	}
}

extension ViewControllerRepliable {
	
	var hasStatusForReplyTo: Bool {
		
		return statusForReplyTo.isExists
	}
}

extension LatestTweetReplyable {
	
	var canReplyToLatestTweet: Bool {
		
		return hasLatestTweet
	}
}

extension ViewControllerRepliable where Self : FieldsController {

}

extension ViewController {

	var canReplyTo: Bool {
	
		return canReplyToLatestTweet || canReplyToSelectedStatuses
	}
	
	@IBAction func setReplyTo(sender: AnyObject) {
		
		guard canReplyTo else {
			
			clearReplyTo()
			return
		}

		switch nextReplyToType {
			
		case .LatestTweet:
			setReplyToByLatestTweet()
			
		case .SelectedStatus:
			setReplyToBySelectedStatuses()
			
		case .None:
			fatalError()
		}

		if let status = self.statusForReplyTo where !twitterController.isMyTweet(status) {

			descriptionTextField.readyForReplyTo(status.user.screenName)
		}

		focusToDescription()
		updateControlsDisplayText()
	}
}


extension MenuController {
	
	var canReplyTo: Bool {
		
		return mainViewController?.canReplyTo ?? false
	}
	
	@IBAction func replyTo(sender:NSMenuItem) {
		
		mainViewController?.setReplyTo(sender)
	}
}
