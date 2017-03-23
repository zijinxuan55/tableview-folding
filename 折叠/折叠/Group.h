//
//  Group.h
//  xtSet
//
//  Created by zr on 16/3/1.
//  Copyright © 2016年 zr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  组
 */
@interface Group : NSObject

/**
 组的名字
 */
@property (nonatomic,copy) NSString *groupName;


/**
 打开或者闭合状态
 */
@property (nonatomic,assign) BOOL isOpen;

@end
