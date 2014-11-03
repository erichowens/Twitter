//
//  TweetCell.h
//  Twitter
//
//  Created by Erich Owens on 11/2/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetsViewController.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) TweetsViewController *theViewController;
@property (nonatomic, strong) Tweet *tweet;

@end
