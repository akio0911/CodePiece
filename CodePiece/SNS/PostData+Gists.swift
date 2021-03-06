//
//  PostData+Gists.swift
//  CodePiece
//
//  Created by Tomohiro Kumagai on H27/11/24.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import ESGists
import ESTwitter

extension PostData {

}

extension PostDataContainer.GistsState {
	
	var isPosted: Bool {
		
		return gist.isExists
	}	
}

extension PostDataContainer {
	
	private var basenameForGists: String { return "CodePiece" }
	
	var isPostedToGists: Bool {
		
		return gistsState.isPosted
	}
	
	var hasGist: Bool {
		
		return gistsState.gist.isExists
	}
	
	var appendAppTagToGists: Bool {
		
		return true
	}
	
	var appendLangTagToGists: Bool {
		
		return false
	}

	var gistPageUrl: String? {
		
		return gistsState.gist?.urls.htmlUrl.description
	}
	
	var filenameForGists: String {
		
		return basenameForGists.appendStringIfNotEmpty(data.language.extname, separator: ".")
	}
	
	var descriptionLengthForGists: Int {
		
		return descriptionForGists().utf16.count
	}
	
	func descriptionForGists() -> String {
	
		let hashtags = effectiveHashtagsForGists
		let appendString = String?()
		
		return makeDescriptionWithEffectiveHashtags(hashtags, appendString: appendString)
	}

	var effectiveHashtagsForGists: ESTwitter.HashtagSet {
		
		return effectiveHashtags(withAppTag: true, withLangTag: false)
	}
}
