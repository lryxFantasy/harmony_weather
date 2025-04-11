import router from '@ohos.router';
@Entry
@Component
struct AddCity {
  @State cityCodeList :number[] = []
  @State cityNameList :string[] = []
  @State currentColors: Array<[number, number]> = []
  @State AllCityCodeList: Array<number> =
    [350213, 110000, 310000, 440100, 440300, 330100, 120000, 320100, 500000];
  @State AllCityNameList: Array<string> =
    ["翔安区", "北京市", "上海市", "广州市", "深圳市", "杭州市", "天津市", "南京市", "重庆市"];

  onPageShow(){
    let params = router.getParams()
    this.cityCodeList = params["codes"]
    this.cityNameList = params["names"]
    this.currentColors = params["currentColors"]

  }

  build() {
      Column() {
        Row(){
          Text("城市列表").fontSize(35).fontColor(Color.White)
          Blank()
          Button("返回主页").fontSize(26).backgroundColor("")
        }.height("10%").width("95%")
        .onClick(()=>{
          router.back({
            url:"pages/Index",
            params:{
              Codes:this.cityCodeList
            }
          })
        })
        Column(){
          List(){
            ForEach(this.AllCityNameList,(name:string)=>{
              ListItem(){
                if(this.cityNameList.includes(name)){
                  Column(){
                    Row(){
                      Text(name).fontSize(35).fontColor(Color.Gray).width("60%").opacity(0.6)
                        .margin({top:20,left:30})
                      Text("已添加").fontSize(18).opacity(0.3)
                        .margin({top:25})
                    }.width("100%")
                    Blank()
                    Divider().strokeWidth(5)
                  }.height("14%").width("100%").margin({top:20}).backgroundColor(Color.White).opacity(0.6)
                }else{
                  Column(){
                    Row(){
                      Text(name).fontSize(35).fontColor(Color.White).width("60%")
                        .margin({top:20,left:30})
                      Button("添加").backgroundColor("rgba(255, 255, 255, 0.3)")  // 设置透明的灰色背景
                        .fontSize(18)
                        .margin({ right: 5 ,top: 20})
                        .onClick(() => {
                          //根据name 获取所在索引
                          let index = this.AllCityNameList.findIndex(obj => obj === name)
                          console.log("index:"+index)
                          //根据索引获得 城市对应的编码
                          let cityCode: number = this.AllCityCodeList[index]
                          console.log("cityCode= "+cityCode)
                          //将编码加入列表
                          this.cityCodeList.push(cityCode)
                          this.cityNameList.push(name)
                          console.log(this.cityCodeList.toString())
                        })
                    }.width("100%")
                    Blank()
                    Divider().strokeWidth(5)

                  }.height("14%").width("100%").margin({top:20})
                }

              }
            })
          }

        }.width("100%").height("90%")

      }.width("100%").height("100%")
      .linearGradient({
        angle: 45,  // 渐变角度，45度
        colors: this.currentColors
      })


  }
}
