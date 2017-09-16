//
//  Weather.swift
//  MarsWeather
//
//  Created by Enzo Antonino on 16/09/2017.
//  Copyright © 2017 Enzo Antonino. All rights reserved.
//

import ObjectMapper


class WeatherResponse: Mappable {
    
    var report: Weather?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        report <- map["report"]
    }
}

class Weather: Mappable {
    
    var terrestrialDate: Date?
    var marsDate: Int?
    var marsSeason: Double?
    var minTemp: Double?
    var minTempFahrenheit: Double?
    var maxTemp: Double?
    var maxTempFahrenheit: Double?
    var pressure: Double?
    var pressureString: String?
    var absHumidity: String?
    var windSpeed: Double?
    var windDirection: String?
    var atmoOpacity: String?
    var season: String?
    var sunrise: Date?
    var sunset: Date?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        terrestrialDate <- (map["terrestrial_date"], TerrestrialDateTransform())
        marsDate <- map["sol"]
        marsSeason <- map["ls"]
        minTemp <- map["min_temp"]
        minTempFahrenheit <- map["min_temp_fahrenheit"]
        maxTemp <- map["max_temp"]
        maxTempFahrenheit <- map["max_temp_fahrenheit"]
        pressure <- map["pressure"]
        pressureString <- map["pressure_string"]
        absHumidity <- map["abs_humidity"]
        windSpeed <- map["wind_speed"]
        windDirection <- map["wind_direction"]
        atmoOpacity <- map["atmo_opacity"]
        season <- map["season"]
        sunrise <- (map["sunrise"], DateTransform())
        sunset <- (map["sunset"], DateTransform())
    }
    
    class DateTransform: TransformType {
        
        func transformFromJSON(_ value: Any?) -> Date? {
            if let date = value as? String {
                let dateFromServer = DateFormatter()
                dateFromServer.locale = NSLocale.current
                dateFromServer.timeZone = TimeZone.current
                //2017-09-12T22:51:00Z
                dateFromServer.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                return dateFromServer.date(from: date)
            }
            return nil
        }
        
        func transformToJSON(_ value: Date?) -> String? {
            return nil
        }
    }
    
    class TerrestrialDateTransform: TransformType {
        
        func transformFromJSON(_ value: Any?) -> Date? {
            if let date = value as? String {
                let dateFromServer = DateFormatter()
                dateFromServer.locale = NSLocale.current
                dateFromServer.timeZone = TimeZone.current
                //2017-09-12
                dateFromServer.dateFormat = "yyyy-MM-dd"
                return dateFromServer.date(from: date)
            }
            return nil
        }
        
        func transformToJSON(_ value: Date?) -> String? {
            return nil
        }
    }


    
}
