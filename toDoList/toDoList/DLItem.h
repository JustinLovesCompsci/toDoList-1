//
//  DLItem.h
//  toDoList
//
//  Created by Justin (Zihao) Zhang on 11/11/14.
//  Copyright (c) 2014 Davis Gossage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DLItem : NSObject

//make public
@property NSString *itemDescription;
@property NSString *itemTitle;
@property UIImage *icon;
@property UIColor *backgroundColor;

@end
