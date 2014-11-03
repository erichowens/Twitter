//
//  TweetCell.m
//  Twitter
//
//  Created by Erich Owens on 11/2/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import "TweetCell.h"
#import "NewTweetViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *wasRetweetedImageView;
@property (weak, nonatomic) IBOutlet UILabel *whoRetweetedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)onReply:(id)sender {
  self.replyButton.imageView.image = [UIImage imageNamed:@"reply_hover.png"];
  NewTweetViewController *ntvc = [[NewTweetViewController alloc] init];
  ntvc.originalText = [NSString stringWithFormat:@"@%@: ", self.tweet.user.screenname];
  ntvc.sourceTweetText = self.tweet.text;

  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  NSLog(@"ID: %@", self.tweet.ID);
  params[@"in_reply_to_status_id"] = self.tweet.ID;
  ntvc.params = params;

  [self.theViewController.navigationController pushViewController:ntvc animated:YES];
}

- (IBAction)onRetweet:(id)sender {
  self.retweetButton.imageView.image = [UIImage imageNamed:@"retweet_hover.png"];
}

- (IBAction)onFavorite:(id)sender {
  self.favoriteButton.imageView.image = [UIImage imageNamed:@"favorite_hover.png"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
  _tweet = tweet;
  
  [self.profileImageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];

  self.wasRetweetedImageView.image = [UIImage imageNamed:@"retweet.png"];
  self.wasRetweetedImageView.hidden = self.tweet.retweeted;
  self.whoRetweetedLabel.hidden = self.tweet.retweeted;

  self.userNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenname];
  self.realNameLabel.text = self.tweet.user.name;
  self.tweetLabel.text = self.tweet.text;

  self.retweetCountLabel.text = [NSString stringWithFormat:@"%ld",self.tweet.retweetCount];
  self.favoriteCountLabel.text = [NSString stringWithFormat:@"%ld", self.tweet.favoriteCount];
  
  NSCalendar *gregorian = [[NSCalendar alloc]
                           initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDate *now = [NSDate date];
  NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
  NSDateComponents *components = [gregorian components:unitFlags
                                              fromDate:self.tweet.createdAt
                                                toDate:now options:0];
  NSInteger hoursAgo = [components hour];
  NSInteger minutesAgo = [components minute];
  self.timeAgoLabel.text = [NSString stringWithFormat:@"%ldh%ldm", hoursAgo, minutesAgo];
  }

@end
