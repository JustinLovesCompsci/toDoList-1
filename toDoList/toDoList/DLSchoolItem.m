//
//  DLSchoolItem.m
//  toDoList
//
//  Created by Justin (Zihao) Zhang on 11/11/14.
//  Copyright (c) 2014 Davis Gossage. All rights reserved.
//

#import "DLSchoolItem.h"

@implementation DLSchoolItem

-(id)initWithTitle:(NSString*)title andDescription:(NSString*)description{
    self = [super init];
    self.icon = [UIImage imageNamed:@"book"];//no need to worry about 1x or 2x, automatically configured
    self.backgroundColor = [UIColor greenColor];
    self.itemDescription = description;
    self.itemTitle = title;
    return self;
}

@end
