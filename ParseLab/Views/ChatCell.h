//
//  ChatCell.h
//  ParseLab
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;


@end

NS_ASSUME_NONNULL_END
