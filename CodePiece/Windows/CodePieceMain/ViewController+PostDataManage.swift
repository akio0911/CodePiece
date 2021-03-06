//
//  ViewController+PostDataManage.swift
//  CodePiece
//
//  Created by Tomohiro Kumagai on 1/19/16.
//  Copyright © 2016 EasyStyle G.K. All rights reserved.
//

import Foundation

protocol PostDataManageable {
	
	func makePostData() -> PostData
}

extension ViewController : PostDataManageable {
	
	func makePostData() -> PostData {
		
		let code = codeTextView.codeText
		let description = descriptionTextField.twitterText
		let language = self.selectedLanguage
		let hashtags = self.hashTagTextField.hashtags
		let replyTo = self.statusForReplyTo
		
		#if DEBUG
			let usePublicGists = false
		#else
			let usePublicGists = true
		#endif
		
		let appendAppTagToTwitter = false
		
		return PostData(code: code, description: description, language: language, hashtags: hashtags, usePublicGists: usePublicGists, replyTo: replyTo, appendAppTagToTwitter: appendAppTagToTwitter)
	}
}

extension PostDataManageable {
	
	func makePostDataContainer() -> PostDataContainer {
		
		return PostDataContainer(makePostData())
	}
}
