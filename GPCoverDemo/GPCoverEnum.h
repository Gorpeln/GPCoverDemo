//
//  GPCoverEnum.h
//  GPCoverDemo
//
//  Created by chen on 2016/10/2.
//  Copyright © 2016年 Gorpeln. All rights reserved.
//


#ifndef GPCoverEnum_h
#define GPCoverEnum_h

#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height
/** 默认动画时间 */
#define kAnimDuration 0.25
/** 默认透明度 */
#define kAlpha 0.75

/** 遮罩类型 */
typedef NS_ENUM(NSUInteger, GPCoverStyle) {
    /** 半透明 */
    GPCoverStyleTranslucent,  // 半透明
    /** 全透明 */
    GPCoverStyleTransparent,  // 全透明
    /** 高斯模糊 */
    GPCoverStyleBlur          // 高斯模糊
};

/** 视图显示类型 */
typedef NS_ENUM(NSUInteger, GPCoverShowStyle) {
    /** 显示在上面 */
    GPCoverShowStyleTop,     // 显示在上面
    /** 显示在中间 */
    GPCoverShowStyleCenter,  // 显示在中间
    /** 显示在底部 */
    GPCoverShowStyleBottom   // 显示在底部
};

/** 动画类型 */
typedef NS_ENUM(NSUInteger, GPCoverAnimStyle) {
    GPCoverAnimStyleTop,      // 从上弹出 (上，中可用)
    GPCoverAnimStyleCenter,   // 中间弹出 (中可用)
    GPCoverAnimStyleBottom,   // 底部弹出,底部消失 (中，下可用)
    GPCoverAnimStyleNone      // 无动画
};


#pragma mark - v2.4.0新增
/** 弹窗显示时的动画类型 */
typedef NS_ENUM(NSUInteger, GPCoverShowAnimStyle) {
    /** 从上弹出 */
    GPCoverShowAnimStyleTop,     // 从上弹出
    /** 中间弹出 */
    GPCoverShowAnimStyleCenter,  // 中间弹出
    /** 底部弹出 */
    GPCoverShowAnimStyleBottom,  // 底部弹出
    /** 无动画 */
    GPCoverShowAnimStyleNone     // 无动画
};

/** 弹窗隐藏时的动画类型 */
typedef NS_ENUM(NSUInteger, GPCoverHideAnimStyle) {
    /** 从上隐藏 */
    GPCoverHideAnimStyleTop,     // 从上隐藏
    /** 中间隐藏（直接消失） */
    GPCoverHideAnimStyleCenter,  // 中间隐藏（直接消失）
    /** 底部隐藏 */
    GPCoverHideAnimStyleBottom,  // 底部隐藏
    /** 无动画 */
    GPCoverHideAnimStyleNone     // 无动画
};

#endif /* GPCoverEnum_h */
