//
//  Tweet.m
//  Twitter
//
//  Created by Erich Owens on 11/1/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (self) {
    NSLog(@"Your tweet: %@", dictionary);
    self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
    self.text = dictionary[@"text"];
    
    NSString *createdAtString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    self.createdAt = [formatter dateFromString:createdAtString];
    
    self.ID = dictionary[@"id"];
    self.retweeted = dictionary[@"retweeted"];
    self.favorited = dictionary[@"favorited"];
    self.retweetCount =  [dictionary[@"retweet_count"] intValue];
    self.favoriteCount =  [dictionary[@"favorite_count"] intValue];
    
  }
  return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
  NSMutableArray *tweets = [NSMutableArray array];
  
  for (NSDictionary *dictionary in array) {
    [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
  }
  
  return tweets;
}

@end
