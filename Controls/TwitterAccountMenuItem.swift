//
//  TwitterAccountMenuItem.swift
//  CodePiece
//
//  Created by Tomohiro Kumagai on H27/08/14.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import Cocoa
import Accounts

final class TwitterAccountMenuItem: NSMenuItem {

	private static let IdentifierCoderKey = "TwitterAccountMenuItemIdentifierKey"
	
	var account:TwitterAccount? {
		
		didSet {
			
			self.title = TwitterAccountMenuItem.titleOfAccount(self.account)
		}
	}
	
	static func menuItemCreator(action action:Selector, target:AnyObject?) -> (account:ACAccount?, keyEquivalent:String) -> TwitterAccountMenuItem {

		return { account, keyEquivalent in
			
			return TwitterAccountMenuItem(account: account, action: action, target: target, keyEquivalent: keyEquivalent)
		}
	}
	
	init(account:ACAccount?, action:Selector, target:AnyObject?, keyEquivalent:String) {
		
		super.init(title: TwitterAccountMenuItem.titleOfAccount(account), action: action, keyEquivalent: keyEquivalent)

		self.account = account.map(TwitterAccount.init)
		self.target = target
	}

	required init?(coder aDecoder: NSCoder) {

		if let accountIdentifier = aDecoder.decodeObjectForKey(TwitterAccountMenuItem.IdentifierCoderKey) as? String {
			
			self.account = TwitterAccount(identifier: accountIdentifier)
		}
		else {
			
			self.account = nil
		}
		
		super.init(coder: aDecoder)
	}
	
	func differentAccount(account:TwitterAccount) -> Bool {
	
		guard let myAccount = self.account else {
			
			return true
		}
		
		return myAccount.identifier != account.identifier
	}
	
	private static func titleOfAccount(account:TwitterAccount?) -> String {
		
		return self.titleOfAccount(account?.ACAccount)
	}
	
	private static func titleOfAccount(account:ACAccount?) -> String {
		
		return account?.username ?? "----"
	}
	
	override func encodeWithCoder(aCoder: NSCoder) {
		
		super.encodeWithCoder(aCoder)
		
		aCoder.encodeObject(self.account?.identifier, forKey: TwitterAccountMenuItem.IdentifierCoderKey)
	}
}
