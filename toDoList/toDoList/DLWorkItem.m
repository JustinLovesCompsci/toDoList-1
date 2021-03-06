//
//  DLWorkItem.m
//  toDoList
//
//  Created by Davis Gossage on 11/10/14.
//  MIT License
//

#import "DLWorkItem.h"
#import "UIColor+DLPalette.h"

@implementation DLWorkItem

- (id)initWithTitle:(NSString*)title andDescription:(NSString *)description{
    self = [super init];
    self.icon = [UIImage imageNamed:@"book"];
    self.backgroundColor = [UIColor DLBlue];
    self.itemDescription = description;
    self.itemTitle = title;
    return self;
}

@end
