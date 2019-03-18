//
//  MLMacroColor.h
//  Mateline
//
//  Created by sprite on 2018/7/18.
//

#pragma mark - 颜色
// 颜色的定义
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0)
#define HEX_COLOR(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#define HEX_COLOR_A(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:a]
// Android使用的8位颜色，如#4c2daaf3，其中4c表示透明度为30%，2daaf3表示RGB颜色
#define HEX_COLOR_Android_8(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:((float)((hexValue & 0xFF000000) >> 24)) / 255.0]
#define BgGradientColorWithFrame(frame) [UIColor colorWithGradientStyle:UIGradientStyleOblique withFrame:frame andColors:@[HEX_COLOR(0x373A6F), HEX_COLOR(0x101329)]];
#define BtnGradientColorWithFrame(frame) [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:frame andColors:@[HEX_COLOR(0x5D7CEF), HEX_COLOR(0x7FD4F1)]];
#define MATELINE_MAIN_COLOR                     HEX_COLOR(0x373A6F)
#define MATELINE_MAIN_COLOR_DARK                HEX_COLOR(0x101329)
#define MATELINE_GREEN_COLOR                    HEX_COLOR(0x29AB91)
#define MATELINE_YELLOW_COLOR                   HEX_COLOR(0xF39826)
#define MATELINE_RED_COLOR                      HEX_COLOR(0xF15A4A)
#define NAVIGATIONBAR_BG_COLOR                  MATELINE_MAIN_COLOR
#define TABBAR_TINT_COLOR                       HEX_COLOR(0xFFFFFF)
#define VIEW_BG_COLOR                           HEX_COLOR(0xF2F2F2)
#define TEXT_COLOR_DEFAULT                      HEX_COLOR_A(0x000000, 0.87)
#define TEXT_COLOR_LIGHT                        HEX_COLOR_A(0x000000, 0.54)
#define TEXT_COLOR_LIGHTER                      HEX_COLOR_A(0x000000, 0.38)
#define TEXT_COLOR_BLUE                         HEX_COLOR(0x1783DA)
#define TABLEVIEW_CELL_BG_COLOR                 HEX_COLOR(0xFFFFFF)
#define TABLEVIEW_CELL_SEPARATOR_COLOR          HEX_COLOR_A(0x00000, 0.08)
#define BUTTON_TEXT_COLOR_BLUE                  HEX_COLOR(0x5CACEE)
#define BUTTON_TEXT_COLOR_WHITE                 HEX_COLOR(0xFFFFFF)
#define BUTTON_BORDER_COLOR_DARK                HEX_COLOR(0x999999)
#define BUTTON_PRECESSED_COLOR_DARK             HEX_COLOR(0xd3d3d3)

#define TEXT_FONT_CONTENT                       [UIFont systemFontOfSize:14]

//设置导航栏为渐变色
#define Gradient_Color_NavigationBar \
UINavigationBar *bar = self.navigationController.navigationBar; \
bar.barTintColor = color_brand_secondary; \
[bar setTranslucent:NO]; \
bar.tintColor = [UIColor whiteColor]; \
bar.titleTextAttributes = @{ \
NSForegroundColorAttributeName:[UIColor whiteColor], \
NSFontAttributeName:[UIFont boldSystemFontOfSize:18] \
}; \
UIImage *indicatorImage = IMAGE_BY_NAME(@"nav_back_white"); \
bar.backIndicatorImage = indicatorImage; \
bar.backIndicatorTransitionMaskImage = indicatorImage; \

#pragma mark - 2018H2新需求
// 品牌主色，主按钮等积极引导元素
#define color_brand_primary HEX_COLOR(0x2DAAF3)
// 品牌辅色，一些背景等基础色彩感元素
#define color_brand_secondary HEX_COLOR(0x373F54)

// 标题文字、主要文本信息
#define color_neutral_charcoal_dark HEX_COLOR(0x242a34)
// 次级文本、组件框Label、按钮
#define color_neutral_charcoal_medium HEX_COLOR(0x53627C)
// 描述文本、次级文本Label
#define color_neutral_charcoal_light HEX_COLOR(0x78849C)
// 不可用状态文字、文本框Placeholder、辅助标识性图标
#define color_neutral_charcoal_lighter HEX_COLOR(0xA6AEBC)
// 文本框、按钮等组件边框、不可用状态图标
#define color_neutral_grey_medium HEX_COLOR(0xBDC3CD)
// 不可用状态按钮-->
#define color_neutral_grey HEX_COLOR(0xD8DDE8)
// 卡片托盘等容器的边框色、分割线
#define color_neutral_grey_light HEX_COLOR(0xE6EAF2)
// 表格表单等的标题背景，如PM Checklsit的Group Title
#define color_neutral_grey_light2 HEX_COLOR(0xEAEEF4)
// 背景色
#define color_neutral_grey_lighter HEX_COLOR(0xF3F6FA)
// 背景
#define color_neutral_grey_light3 HEX_COLOR(0xfbfcfd)
// 卡片托盘等内容承载区基础色
#define color_neutral_white HEX_COLOR(0xFFFFFF)

// 引导元素，如文本框激活时的边框
#define color_functional_blue HEX_COLOR(0x2C86FF)
// 提示信息、超链接文本
#define color_functional_blue_dark HEX_COLOR(0x2979FF)
// 成功文字
#define color_functional_green_dark HEX_COLOR(0x00865A)
// 成功元素，如托盘、图表、背景
#define color_functional_green HEX_COLOR(0x02B376)
// 成功元素，如托盘、图表、背景
#define color_functional_green2 HEX_COLOR(0x01AB71)
// 错误文字
#define color_functional_red_dark HEX_COLOR(0xE70F08)
// 失败元素，如托盘、图表、背景
#define color_functional_red HEX_COLOR(0xF83A00)
// 失败元素，如托盘、图表、背景
#define color_functional_red2 HEX_COLOR(0xED3700)
// 警告文字
#define color_functional_orange_dark HEX_COLOR(0xF07300)
// 警告元素，如托盘、图表、背景
#define color_functional_orange HEX_COLOR(0xFF9300)
// 警告元素，如托盘、图表、背景
#define color_functional_orange2 HEX_COLOR(0xF58D00)


#define color_functional_979ba2 HEX_COLOR(0x979ba2)
#define color_functional_ced3db HEX_COLOR(0xced3db)
#define color_functional_f6b421 HEX_COLOR(0xf6b421)
#define color_functional_8794ff HEX_COLOR(0x8794ff)
#define color_functional_ac7acd HEX_COLOR(0xac7acd)
#define color_functional_37c0cd HEX_COLOR(0x37c0cd)
#define color_functional_40bf94 HEX_COLOR(0x40bf94)
#define color_functional_1c2b4d HEX_COLOR(0x1c2b4d)
#define color_functional_009df8 HEX_COLOR(0x009df8)
#define color_functional_d1d4dd HEX_COLOR(0xd1d4dd)
#define color_functional_b5c1d1 HEX_COLOR(0xb5c1d1)
#define color_functional_08d755 HEX_COLOR(0x08d755)
#define color_functional_ceffee HEX_COLOR(0xceffee)
#define color_functional_fee7e0 HEX_COLOR(0xfee7e0)
#define color_functional_fff4e5 HEX_COLOR(0xfff4e5)


// 表格单元格Line的颜色
#define color_selectTable_line_gray HEX_COLOR(0xdde2eb)
// 文本框、按钮等组件一种背景默认色
#define color_neutral_labelorbtn_backgroundColor HEX_COLOR(0xe8f2ff)
// 文本框、按钮等组件一种背景选中色
#define color_neutral_labelorbtn_select_backgroundColor HEX_COLOR(0xf3f4f8)

#define color_functional_485465 HEX_COLOR(0x485465)

#pragma mark - android 8位颜色
#define color_functional_4c2daaf3 HEX_COLOR_Android_8(0x4c2daaf3)
#define color_functional_4cf83a00 HEX_COLOR_Android_8(0x4cf83a00)
#define color_functional_14ffffff HEX_COLOR_Android_8(0x14ffffff)



