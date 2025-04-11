import {WeatherModel} from "../viewmodel/WeatherModel"
import http from '@ohos.net.http';

class getWeatherUtil{
  //发送一个url
  getWeather(cityCode:number){
    return new Promise<WeatherModel>((resolve,reject)=>{
      let request = http.createHttp()
      let url = `https://restapi.amap.com/v3/weather/weatherInfo?city=${cityCode}&key=adfb53596f9d9b1f37295e65cf43a388&extensions=all`
      let result = request.request(url)

      result.then((res)=>{
        if(res.responseCode === 200){
         // console.log(res.result.toString());
          resolve(JSON.parse(res.result.toString()))
        }
      }).catch((err)=>{
        console.log(err)
      })
    })
  }
  //发送多个url一并返回
  async getWeathers(cityCodes:Array<number>){
    let promises :Array<Promise<WeatherModel>> = []
    let weatherModels :Array<WeatherModel> = []
    for(let i = 0;i<cityCodes.length;i++)
    {
      promises.push(this.getWeather(cityCodes[i]))
    }
    await Promise.all(promises).then(result=>{
      for(const element of result){
        console.log(element.forecasts[0].city+element.forecasts[0].casts[0].dayweather)
      }
      weatherModels = result
    })
    return weatherModels
  }
}

let getweatherUtil = new getWeatherUtil()
export default getweatherUtil as getWeatherUtil