import router from '@ohos.router';
@Entry
@Component
struct about {
  @State cityCodeList: number[] = Array.from({ length: 50 }, (_, i) => 100 + i);
  @State cityNameList: string[] = Array.from({ length: 50 }, (_, i) => `城市 ${i + 1}`);
  @State currentColors: Array<[number, number]> = [
    [0xFFD700, 0], // 金黄色
    [0x1E90FF, 1.0] // 道奇蓝色
  ]; // 示例的颜色数组，初始化时包含金黄色和道奇蓝色

  onPageShow(){
    let params = router.getParams()
    this.cityCodeList = params["codes"]
    this.cityNameList = params["names"]
    this.currentColors = params["currentColors"]
  }

  build() {
    Column() {
      // 顶部操作区，增加间距，按钮排列更合理
      Row() {
        Text("关于").fontSize(35).fontColor(Color.White)
          .margin({left:20})
        Blank()
        Button("返回主页")
          .fontSize(21)
          .fontColor(Color.White)
          .opacity(0.9)
          .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
          .margin({ left: 20, bottom: 30 })
          .padding({ top: 50, bottom: 20, left: 15, right: 15 })
          .onClick(()=>{
            router.back({
              url:"pages/Index",
              params:{
                Codes:this.cityCodeList
              }
            })
          })
      }
      .backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
      .borderRadius(10)
      .height("8%")
      .width("100%")
      .justifyContent(FlexAlign.Center)  // 水平居中，使按钮靠近
      // 中间新增文字区域
      Text("幻想天气app"+"\n"+"v1.2.0")
        .fontSize(50)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50, bottom: 20 })
        .padding({ left: 20, right: 20 })
        .textAlign(TextAlign.Center)
      Divider()
      Text("本程序由厦门大学@Fantasy开发\n基于高德天气api")
        .fontSize(29)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10, bottom: 20 })
        .padding({ left: 20, right: 20 })
        .textAlign(TextAlign.Center)
        .opacity(0.6)
      Divider()
      Text("目前添加到app的城市数据：")
        .fontSize(23)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 10, bottom: 20 })
        .padding({left:-10})
      Column(){
        // 动态显示传递的城市信息
        List(){
          ForEach(this.cityCodeList, (code, index) => {
            ListItem(){
              Text(`城市代码: ${code}, 城市名称: ${this.cityNameList[index] || "未知"}`)
                .fontSize(20)
                .fontColor(Color.White)
                .margin({ top: 10, bottom: 10 })
                .textAlign(TextAlign.Start)
            }

          })
        }.width("100%").height("50%").padding({left:20})
      }.width("100%").height("90%")


      // 使用线性渐变作为背景
    }
    .width("100%")
    .height("100%")
    .linearGradient({
      angle: -45,  // 渐变角度，45度
      colors: this.currentColors
    })
    .padding({ top: 0, bottom: 10 })
  }
}
