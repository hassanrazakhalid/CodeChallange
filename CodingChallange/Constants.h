//
//  Constants.h
//  CodingChallange
//
//  Created by Pro on 04/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Constants_h
#define Constants_h


typedef NS_ENUM(NSInteger, MenuRow){

    MenuRowTweets,
    MenuRowOldTweets
};

typedef NS_ENUM(NSInteger, ImageStatus){

    ImageStatusNone,
    ImageStatusInProgress,
    ImageStatusDone
};

typedef void(^FetchTweets)(NSArray *parsedList);
typedef void(^ImageCallback)(id obj);

#define _kUserName @"userName"

#endif /* Constants_h */
