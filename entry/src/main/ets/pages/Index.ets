import router from '@ohos.router';
import { cityView } from '../view/cityView';
import getweatherUtil from "../viewmodel/getWeatherUtil";
import { WeatherModel } from "../viewmodel/WeatherModel";
import { themeColor1, themeColor2, themeColor3, themeColor4, themeColor5, themeColor6, themeColor7, themeColor8, themeColor9, themeColor10, themeColor11, themeColor12, themeColor13 } from '../view/theme';

@Entry
@Component
struct Index {
  @State cityCodeList: number[] = [350213, 440300];
  @State cityNameList: string[] = [];
  @State cityWeatherList: Array<WeatherModel> = [];
  @State cityIndex: number = 0;
  @State currentColors: Array<[number, number]> = themeColor1;  // 初始为 themeColor1

  tabController: TabsController = new TabsController();

  // 当前主题索引
  private currentIndex: number = 0;  // 初始为 themeColor1
  // 切换主题的方法
  private changeTheme() {
    // 按顺序循环切换主题
    this.currentIndex = (this.currentIndex + 1) % 13;  // 0 -> 1 -> 2 -> ... -> 0

    // 根据索引切换到对应的主题
    switch (this.currentIndex) {
      case 0: this.currentColors = themeColor1; break;
      case 1: this.currentColors = themeColor2; break;
      case 2: this.currentColors = themeColor3; break;
      case 3: this.currentColors = themeColor4; break;
      case 4: this.currentColors = themeColor5; break;
      case 5: this.currentColors = themeColor6; break;
      case 6: this.currentColors = themeColor7; break;
      case 7: this.currentColors = themeColor8; break;
      case 8: this.currentColors = themeColor9; break;
      case 9: this.currentColors = themeColor10; break;
      case 10: this.currentColors = themeColor11; break;
      case 11: this.currentColors = themeColor12; break;
      case 12: this.currentColors = themeColor13; break;
    }

    // 打印当前颜色主题以调试
    console.log("当前颜色主题:", JSON.stringify(this.currentColors));
  }

  // 获取数据
  aboutToAppear() {
    this.initData()
  }

  // 初始化方法
  async initData() {
    let result: Array<WeatherModel> = await getweatherUtil.getWeathers(this.cityCodeList)

    for (let i = 0; i < result.length; i++) {
      let ACityWeather = new WeatherModel()
      ACityWeather = result[i]
      this.cityWeatherList.push(ACityWeather)
      let cityName = this.cityWeatherList[i].forecasts[0].city
      this.cityNameList.push(cityName)
    }
  }

  @Builder
  tabBuild(index: number) {
    Circle({ width: 12, height: 12 })
      .fill(this.cityIndex === index ? Color.White : Color.Gray)
      .opacity(0.7);
  }


  onPageShow() {
    // 获取跳转时传递的参数
    let params = router.getParams();

    if (params && params["Codes"]) {
      // 如果接收到有效参数，则初始化
      this.cityCodeList = params["Codes"];
      this.cityWeatherList = [];
      this.cityNameList = [];
      this.initData();
    }
  }

  build() {
    Column() {
      // 顶部操作区，增加间距，按钮排列更合理
      Row() {
        Button("添加城市")
          .fontSize(21)
          .fontColor(Color.White)
          .opacity(0.9)
          .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
          .margin({ right: 7, bottom: 30 })
          .padding({ top: 50, bottom: 20, left: 15, right: 15 })
          .onClick(() => {
            router.pushUrl({
              url: `pages/AddCity`,
              params: {
                codes: this.cityCodeList,
                names: this.cityNameList,
                currentColors: this.currentColors
              }
            })
          })

        Text("幻想天气")
          .fontSize(30)
          .fontColor(Color.White)
          .fontWeight("bold")  // 字体加粗，使其更突出
          .opacity(0.6)
        Button("删除城市")
          .fontSize(21)
          .fontColor(Color.White)
          .opacity(0.9)
          .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
          .margin({ left: 7, bottom: 30 })
          .padding({ top: 50, bottom: 20, left: 15, right: 15 })
          .onClick(() => {
            AlertDialog.show({ title: "提示！",
              message: `确定删除${this.cityNameList[this.cityIndex]}`,
              confirm: {
                value: "确定",
                action: () => {
                  this.cityNameList = this.cityNameList.filter(item => item !== this.cityNameList[this.cityIndex])
                  this.cityCodeList = this.cityCodeList.filter(item => item !== this.cityCodeList[this.cityIndex])
                  this.cityWeatherList = this.cityWeatherList.filter(item => item !== this.cityWeatherList[this.cityIndex])

                }


              }
            })
          })
      }
      .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
      .borderRadius(10)
      .height("8%")
      .width("100%")
      .justifyContent(FlexAlign.Center)  // 水平居中，使按钮靠近

      Row(){
        Button("换肤")
          .fontSize(21)
          .fontColor(Color.White)
          .opacity(0.9)
          .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
          .margin({ left:0,top:10,bottom: -20 })
          .padding({ top: 10,bottom: 10, left: 10, right: 10 })
          .onClick(() => {
            this.changeTheme()
          })

        Text(this.cityNameList[this.cityIndex]).fontSize(40).fontColor(Color.Yellow).fontWeight(FontWeight.Bold)
          .margin({ left:0,top:10,bottom: -25 })
          .padding({ top: 0,bottom: -10, left: 30, right: 10 })
          .opacity(0.7)
          .onClick(() => {

          })

        Button("关于")
          .fontSize(21)
          .fontColor(Color.White)
          .opacity(0.9)
          .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
          .margin({ left:20,top:10,bottom: -20 })
          .padding({ top: 10,bottom: 10, left: 10, right: 10 })
          .onClick(() => {
            router.pushUrl({
              url: `pages/about`,
              params: {
                codes: this.cityCodeList,
                names: this.cityNameList,
                currentColors: this.currentColors
              }
            })
          })
      }
      .justifyContent(FlexAlign.Center)  // 水平居中，使按钮靠近



      // 标签区，调整Tab背景色和字体
      Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
        ForEach(this.cityWeatherList, (cityWeather: WeatherModel) => {

          TabContent() {
            cityView({casts: cityWeather.forecasts[0].casts, currentColors: this.currentColors})
          }.tabBar(this.tabBuild(this.cityWeatherList.findIndex(obj => obj === cityWeather)))
        })
      }.margin({top:10,bottom:10})
      .barWidth(60)
      .barHeight(50)
      .onChange((index: number) => {
        this.cityIndex = index
      })

      // 使用线性渐变作为背景
    }
    .width("100%")
    .height("100%")
    .linearGradient({
      angle: 45,  // 渐变角度，45度
      colors: this.currentColors
    })
    .padding({ top: 0, bottom: 10 })
  }
}
