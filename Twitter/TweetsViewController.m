//
//  TweetsViewController.m
//  Twitter
//
//  Created by Erich Owens on 11/2/14.
//  Copyright (c) 2014 Erich Owens. All rights reserved.
//

#import "TweetsViewController.h"
#import "NewTweetViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetCell.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) TweetCell *prototypeTweetCell;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell"
                                             bundle:nil] forCellReuseIdentifier:@"TweetCell"];
  self.tableView.rowHeight = UITableViewAutomaticDimension;

  // pull to refresh
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(pullNewTimeline) forControlEvents:UIControlEventValueChanged];
  [self.tableView insertSubview:self.refreshControl atIndex:0];
  
  UIColor *twitterBlue = [UIColor colorWithRed:85.0/255.0 green:172.0/255.0 blue:238.0/255.0 alpha:1.0];
  self.navigationController.navigationBar.barTintColor = twitterBlue;
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
  self.navigationItem.title = @"Home";
  
  // wow, pulling all my tweets is now super easy.
  [self pullNewTimeline];
}

- (void)pullNewTimeline {
  [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *pulledTweets, NSError *error) {
    NSLog(@"Pulled Tweets: %@", pulledTweets);
    self.tweets = pulledTweets;
    [self.tableView reloadData];
  }];
  [self.refreshControl endRefreshing];
}

- (IBAction)onLogout {
  [User logout];
}

- (IBAction)onNewTweet {
  NSLog(@"Hey, making a new tweet!");
  
  NewTweetViewController *ntvc = [[NewTweetViewController alloc] init];
  [self.navigationController pushViewController:ntvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods!

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];

  cell.theViewController = self;
  cell.tweet = self.tweets[indexPath.row];
  return cell;
}

/*
- (TweetCell *)prototypeTweetCell {
  if (_prototypeTweetCell == nil) {
    _prototypeTweetCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
  }
  return _prototypeTweetCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  self.prototypeTweetCell.tweet = self.tweets[indexPath.row];
  CGSize size = [self.prototypeTweetCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
  NSLog(@"Size: %.4f by %.4f", size.width, size.height);
  return size.height + 1;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
