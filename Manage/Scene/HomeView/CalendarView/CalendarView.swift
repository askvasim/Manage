//
//  CalendarView.swift
//  Manage
//
//  Created by Vasim Khan on 10/23/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    
    private var weekDays: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.shortWeekdaySymbols
    }
    
    private func datesForCurrentWeek() -> [Date] {
        let calendar = Calendar.current
        let today = currentDate
        let weekday = calendar.component(.weekday, from: today)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - calendar.firstWeekday), to: today)!
        
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    private func isCurrentDate(_ date: Date) -> Bool {
        Calendar.current.isDate(date, inSameDayAs: currentDate)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }

    var body: some View {
        VStack(spacing: 10) {
            // Header: "This Week" and "See all"
            HStack {
                Text("This Week")
                    .font(Font.custom("Roboto-Medium", size: 18))
                    .foregroundColor(.appPrimaryFont)
                Spacer()
                
                Text("See all")
                    .font(Font.custom("Roboto-Medium", size: 16))
                    .foregroundColor(.appPrimaryFont)
            }
            .padding(.top, 25)
            .padding(.horizontal, 20)
            
            // Days of the Week
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day.prefix(3).uppercased())
                        .font(Font.custom("Roboto-Regular", size: 12))
                        .foregroundColor(.appGrayFontColor)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            // Dates for the current week
            HStack {
                ForEach(datesForCurrentWeek(), id: \.self) { date in
                    Text(formattedDate(date))
                        .font(.system(size: 16, weight: .medium))
                        .frame(minWidth: 36, idealWidth: 36, maxWidth: 36, minHeight: 36, idealHeight: 36, maxHeight: 36)
                        .padding(0)
                        .background(isCurrentDate(date) ? Color.appPrimaryFont : Color.clear)
                        .foregroundColor(isCurrentDate(date) ? Color.appPrimary : Color.appPrimaryFont)
                        .cornerRadius(12)
                }
            }
            
            Spacer()
            
        }
        .frame(height: 164)
        .background(.appGrayBackground)
        .cornerRadius(20)
        .padding(.horizontal, 25)
        
    }
}

#Preview {
    CalendarView()
}
