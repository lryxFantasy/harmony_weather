import { casts } from "../viewmodel/casts";
// 设置基础字体大小
const baseFontSize = 23;
@Component
export struct cityView {

  // 当前城市天气
  casts: casts[] = []
  currentColors: Array<[number, number]> = []

  @Builder weatherImage(dayweather: string) {
    if (dayweather === "晴") {
      Image($r('app.media.sun')).width(40).height(40).objectFit(ImageFit.Contain)
    }
    if (dayweather === "多云" || dayweather === "阴") {
      Image($r("app.media.cloud")).width(40).height(40).objectFit(ImageFit.Contain)
    }
    if (dayweather.includes("雨")) {
      Image($r("app.media.rain")).width(40).height(40).objectFit(ImageFit.Contain)
    }
  }

  build() {
    // 单个 tabcontent 展示的所有内容
    Column() {
      ForEach(this.casts, (cast: casts) => {
        if (cast === this.casts[0]) {
          // 上半部分：图片 + 当天天气
          Row() {

            if (cast.dayweather === "晴") {
              Image($r('app.media.sun')).width(260).objectFit(ImageFit.Contain)
            }
            if (cast.dayweather === "多云" || cast.dayweather === "阴") {
              Image($r("app.media.cloud")).width(260).objectFit(ImageFit.Contain)
            }
            if (cast.dayweather.includes("雨")) {
              Image($r("app.media.rain")).width(260).objectFit(ImageFit.Contain)
            }
          }.height("30%")
          .margin({top:30})

          // 天气与温度
          Column() {
            // 天气和温度
            Row(){
              Text("今日天气").fontSize(30).fontColor(Color.White).fontWeight(FontWeight.Bold)
            }
            Row() {
              Text(cast.dayweather).fontSize(25).fontColor(Color.White).fontWeight(FontWeight.Bold)
              Text("  " + cast.daytemp + "°~ " + cast.nighttemp + "°")
                .fontSize(25)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
                .margin({right:20})
              Text(cast.daypower + "级"+cast.daywind + "风  ").fontSize(25).fontColor(Color.White).fontWeight(FontWeight.Bold)

            }

          }.margin({ top: 10 })
        }
      })

      // 近期天气列表
      Column() {
        Text("未来天气").fontSize(29).fontColor(Color.White).margin({ top: 10 }).fontWeight(FontWeight.Bold)

        // 横排展示未来天气
        Column() {
          ForEach(this.casts, (cast: casts) => {
            Row() {
              // 显示日期
              Text(cast.date.substring(5))  // 显示日期
                .fontSize(20)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
                .margin({ right: 10 }) // 调整间距



              // 显示天气
              Text(cast.dayweather.length < 2 ? cast.dayweather + "天" : cast.dayweather)
                .fontSize(
                    cast.dayweather.length <= 2
                    ? baseFontSize  // 一个或两个字保持基础大小
                    : Math.max(baseFontSize - (cast.dayweather.length - 2) * 3, 12)  // 三个字及以上减少字体，最小为12
                )
                .fontColor(Color.White)
                .fontWeight(FontWeight.Normal)
                .padding({ left: 15, right: 15 }) // 设置左右间距



              // 显示天气图标
              this.weatherImage(cast.dayweather)

              // 显示白天气温
              Text(cast.daytemp < 10 && cast.daytemp > -10 ? cast.daytemp.toString() + "  °" : cast.daytemp.toString() + "°")
                .fontSize(20)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
                .padding({ left: 10 })

             Text("---")
               .fontSize(20)
               .fontColor(Color.White)
               .fontWeight(FontWeight.Bold)
               .margin({ left:10,right: 10 }) // 调整间距

              // 显示夜间气温
              Text(cast.nighttemp.toString() + "°")
                .fontSize(20)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)

            }
            .height("60%")
            .width("90%")
            .padding({ top: 10, bottom: 10 })
          })
        }
        .width("100%")
        .height("35%")
        .justifyContent(FlexAlign.SpaceAround)

      }
      .height("40%")
      .width("90%")
      .margin({ top: 20 })
      .backgroundColor("rgba(0, 0, 0, 0.2)")  // 半透明，透明度为50%
      .borderRadius(15)  // 圆角半径为15
      .opacity(0.9)

    }
    .width("100%")
    .height("100%")
    .backgroundColor("0x87CEEB")  // 背景颜色设置为天蓝色
  }
}