//
//  NewTweetViewController.h
//  Twitter
//
//  Created by Erich Owens on 11/2/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTweetViewController : UIViewController
@property (strong, nonatomic) NSDictionary* params;
@property (strong, nonatomic) NSString* originalText;
@property (strong, nonatomic) NSString* sourceTweetText;

@end
