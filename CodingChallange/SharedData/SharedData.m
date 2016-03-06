//
//  SharedData.m
//  CodingChallange
//
//  Created by Pro on 05/03/2016.
//  Copyright © 2016 Pro. All rights reserved.
//

#import "SharedData.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "Tweet.h"
#import "User.h"
#import "NSString+_.h"

static SharedData *instance = nil;

@implementation SharedData

+ (SharedData *)sharedInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        if(!instance)
            instance = [SharedData new];
    });
    return instance;
}

- (void)loginTwiiterUser{

    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                NSString *userName = twitterAccount.username;
                self.currentUser = [User insertUser:@{_kUserName:userName,
                                                      @"name":twitterAccount.userFullName}];
                self.currentUser.twitterAccount = twitterAccount;
            }
        } else {
            NSLog(@"No access granted");
        }
    }];

    
}

#pragma Get Tweets

- (void) getTweetsInfo:(NSString *)text callback:(FetchTweets)callback
{

    NSString *urlString = [NSString stringWithFormat:@"https://api.twitter.com/1.1/search/tweets.json"];    
    NSString * encodedText = [[NSString stringWithFormat:@"%@",text] urlencode];

    // count is currently hard coded but can also be passed through function
    NSDictionary *parameters = @{@"result_type":@"mixed",
                                               @"q":encodedText,
                                                 @"count":@"4"};
    
    SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:urlString] parameters:parameters];
    [twitterInfoRequest setAccount:self.currentUser.twitterAccount];
    
    // Making the request
    
    [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
       
        if ([urlResponse statusCode] == 429) {
            NSLog(@"Rate limit reached");
            return;
        }
        
        // Check if there was an error
        
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
            return;
        }
        
        NSMutableArray *tweetsList = [NSMutableArray array];
        if (responseData) {
            
            NSError *error = nil;
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
            NSArray *tweets = responseDict[@"statuses"];
            
            for (NSDictionary * tweetInfo in tweets) {
                
                [tweetsList addObject:[Tweet insertTweet:tweetInfo]];
            }
        }
        if(callback)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            
                callback(tweetsList);
            });
            
        }

    }];
}
@end
