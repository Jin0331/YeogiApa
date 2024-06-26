//
//  Category.swift
//  JustBoard
//
//  Created by JinwooLee on 4/22/24.
//

import UIKit

protocol CustomStringConvertibleEnum: CustomStringConvertible {}

extension CustomStringConvertibleEnum {
    var description: String {
        return "\(self)"
    }
}
enum TabmanCategory : CaseIterable {
    case best
    case user
    case profile
}

//MARK: - 실시간 베스트 목록
enum BestCategory : String, CaseIterable,CustomStringConvertibleEnum  {
    case commentSort = "댓글"
    case likeSort = "공감"
    case unlikeSort = "비공감"
    
    var productId : String {
        switch self {
        default :
            return ""
        }
    }
}

//MARK: - 실시간 유저 베스트 목록
enum BestUserCategory : String, CaseIterable,CustomStringConvertibleEnum  {
    case user = "유저"
    case board = "게시판"
    
    var productId : String {
        switch self {
        default :
            return ""
        }
    }
}

//MARK: - 프로필 내가 작성한 글
enum ProfilePostCategory : String, CaseIterable,CustomStringConvertibleEnum {
    case myPost = "작성글"
    case myComment = "댓글"
    case myFavorite = "좋아요"
    
    var productId : String {
        switch self {
        default :
            return ""
        }
    }
}

//MARK: - Follow
enum FollowCategory : String, CaseIterable {
    case followers = "팔로워"
    case following = "팔로잉"
    
    var followers : Bool {
        switch self {
        case .followers:
            return true
        case .following:
            return false
        }
    }
    
    var following : Bool {
        switch self {
        case .followers:
            return false
        case .following:
            return true
        }
    }
}

//MARK: - BoardList
enum BoardListCategory : String, CaseIterable {
    case all = "전체"
    case my = "내 게시판"
    
    var productId : String {
        switch self {
        default :
            return ""
        }
    }
    
    var specificBoard : [String] {
        switch self {
        case .my:
            return ["생활꿀팁", "아무거나올리는짤방게시판","이게시판은뭐지"]
            
        default:
            return []
        }
    }
}


func getTammanCategoryList(for tabmanCategory: TabmanCategory) -> [CustomStringConvertibleEnum] {
    switch tabmanCategory {
    case .best:
        return BestCategory.allCases
    case .user:
        return BestUserCategory.allCases
    case .profile:
        return ProfilePostCategory.allCases
    }
}

//MARK: - 게시판 목록
// questionVC에서 게시판 목록 선택
enum CategorySection : CaseIterable {
    case main
}

enum Category : String, CaseIterable {
    
    case all_test = "전체_테스트"
    case all = "전체"
    case life = "생활꿀팁"
    case concerns = "고민상담"
    case develop = "개발"
    case premises = "부동산"
    case medical = "의료"
    case pill = "약료"
    case law = "법률"
    case pet = "반려동물"
    
    var name : String {
        switch self {
        case .all_test:
            return "all"
        case .all:
            return "all"
        case .life:
            return "life"
        case .concerns:
            return "concerns"
        case .develop:
            return "develop"
        case .premises:
            return "premises"
        case .medical:
            return "medical"
        case .pill:
            return "pill"
        case .law:
            return "law"
        case .pet:
            return "pet"
        }
    }
    
    var productId : String {
        switch self {
        case .all_test:
            return ""
        default :
            return "gyjw_" + self.name
        }
    }
}
