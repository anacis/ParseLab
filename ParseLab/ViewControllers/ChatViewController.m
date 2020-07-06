//
//  ChatViewController.m
//  ParseLab
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"
#import <Parse/Parse.h>

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getMessages];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getMessages) userInfo:nil repeats:true];
    // Do any additional setup after loading the view.
}

- (IBAction)sendMessage:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2020"];
    chatMessage[@"text"] = self.messageField.text;
    chatMessage[@"user"] = PFUser.currentUser;
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
            [self getMessages];
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
    self.messageField.text = @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    cell.messageLabel.text = self.messages[indexPath.row][@"text"];
    
    PFUser *user = self.messages[indexPath.row][@"user"];
    if (user != nil) {
        // User found! update username label with username
        cell.usernameLabel.text = user.username;
    } else {
        // No user found, set default username
        cell.usernameLabel.text = @"🤖";
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (void)getMessages {
    PFQuery *query = [PFQuery queryWithClassName:@"Message_fbu2020"];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.messages = posts;
            NSLog(@"posts: %@", posts[0][@"text"]);
            NSLog(@"messages: %@", self.messages[0][@"text"]);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


@end
