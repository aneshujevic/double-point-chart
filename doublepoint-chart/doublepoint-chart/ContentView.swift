//
//  ContentView.swift
//  doublepoint-chart
//


import SwiftUI

struct ContentView: View {
    @State private var points: [LabeledDoublePoints] = [
        LabeledDoublePoints(id: 1, label: "1", lowPoint: 2, highPoint: 5),
        LabeledDoublePoints(id: 2, label: "2", lowPoint: 2, highPoint: 3),
        LabeledDoublePoints(id: 3, label: "3", lowPoint: 6, highPoint: 10),
        LabeledDoublePoints(id: 4, label: "4", lowPoint: 2, highPoint: 5),
        LabeledDoublePoints(id: 5, label: "5", lowPoint: 2, highPoint: 3),
        LabeledDoublePoints(id: 6, label: "6", lowPoint: 6, highPoint: 10),
        LabeledDoublePoints(id: 7, label: "7", lowPoint: 2, highPoint: 5),
        LabeledDoublePoints(id: 8, label: "8", lowPoint: 2, highPoint: 3),
        LabeledDoublePoints(id: 9, label: "9", lowPoint: 6, highPoint: 10),
        LabeledDoublePoints(id: 10, label: "10", lowPoint: 2, highPoint: 5),
        LabeledDoublePoints(id: 11, label: "11", lowPoint: 2, highPoint: 3),
        LabeledDoublePoints(id: 12, label: "12", lowPoint: 6, highPoint: 10)
    ]
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            DoublePointChart(points: points, width: 300, height: 100, spacing: 10, selectedId: 6, selectedColor: .orange, unselectedColor: .gray, backgroundColor: Color(UIColor(named: "grayish")!), barColor: Color(UIColor(named:"darkgray")!), textColor: .white)
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
