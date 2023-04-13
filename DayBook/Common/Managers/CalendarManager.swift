//
//  CalendarManager.swift
//  DayBook
//
//  Created by Сергей Золотухин on 09.04.2023.
//

import UIKit

protocol CalendarManagerProtocol {
    func plusMonth(date: Date) -> Date
    func minusMonth(date: Date) -> Date
    func monthString(date: Date) -> String
    func yearString(date: Date) -> String
    func daysInMonth(date: Date) -> Int
    func dayOfMonth(date: Date) -> Int
    func firstOfMonth(date: Date) -> Date?
    func weekDay(date: Date) -> Int
    func dayNumberFromFullDate(date: Date?) -> String
    func isDatesEqual(firstDate: Date?, secondDate: Date?) -> Bool
    func timeFromFullDate(date: Date) -> String
    func hourFromFullDate(date: Date) -> String
    func saveDateInTimeStamp(date: Date) -> TimeInterval
    func fetchDateFromTimeStamp(ti: TimeInterval) -> String
}

final class CalendarManager {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
}

extension CalendarManager: CalendarManagerProtocol {
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    // название месяца
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    // название года
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    // Количество дней в месяце
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // номер дня в месяце
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    // номер первого дня в месяце (на основе года и месяца)
    func firstOfMonth(date: Date) -> Date? {
        
        let components = calendar.dateComponents([.year, .month], from: date)
        let day = calendar.date(from: components)!

        dateFormatter.timeZone = TimeZone(secondsFromGMT: +3)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let newDate = dateFormatter.string(from: day)
        let dateDate = dateFormatter.date(from: newDate)

        return dateDate
    }
    
    // номер первого дня месяца в неделе
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        var emptyFields = components.weekday! + 6
        if emptyFields >= 7 {
            emptyFields -= 7
        }
        return emptyFields
    }
    
    //Строковое значение номера дня из полной даты с учетом таймзоны
    func dayNumberFromFullDate(date: Date?) -> String {
        guard let date = date else {
            return ""
        }

        let component = calendar.component(.day, from: date)
        
        return String(component)
    }
    
    func isDatesEqual(firstDate: Date?, secondDate: Date?) -> Bool {
        guard let firstDate = firstDate,
              let secondDate = secondDate else {
            return false
        }

        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let firstDateString = dateFormatter.string(from: firstDate)
        let secondDateString = dateFormatter.string(from: secondDate)
        return firstDateString == secondDateString
    }
    
    //Строковое значение времени дня из полной даты с учетом таймзоны
    func timeFromFullDate(date: Date) -> String {
        dateFormatter.dateFormat = "H:mm"
//        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    //Строковое значение часа из полной даты с учетом таймзоны
    func hourFromFullDate(date: Date) -> String {
        dateFormatter.dateFormat = "H"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    //Сохраняем дату в формате TimeStamp
    func saveDateInTimeStamp(date: Date) -> TimeInterval {
        let timeStamp = date.timeIntervalSince1970
        return timeStamp
    }
    
    //Получаем строковое значение даты из timeStamp с учетом часового пояса
    func fetchDateFromTimeStamp(ti: TimeInterval) -> String {
        let dateFromUnix = Date(timeIntervalSince1970: ti)
        dateFormatter.dateFormat = "MM dd YYYY HH:mm"
        dateFormatter.timeZone = .current
        let dateString = dateFormatter.string(from: dateFromUnix)
        return dateString
    }
}
