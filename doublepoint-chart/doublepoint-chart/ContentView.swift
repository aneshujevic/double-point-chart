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

struct DoublePointChart: View {
    @State var points: [LabeledDoublePoints]
    @State var width: Int
    @State var height: Int
    @State var spacing: Int
    @State var selectedColor: Color
    @State var unselectedColor: Color
    @State var backgroundColor: Color?
    @State var barColor: Color
    @State var textColor: Color
    @State private var minLowPoint: CGFloat
    @State private var maxHighPoint: CGFloat
    @State private var pointHeight: CGFloat
    @State private var selectedId: Int
    
    init(points: [LabeledDoublePoints], width: Int, height: Int, spacing: Int, selectedId: Int, selectedColor: Color, unselectedColor: Color, backgroundColor: Color, barColor: Color, textColor: Color) {
        _points = State(initialValue: points)
        _width = State(initialValue: width)
        _height = State(initialValue: height)
        _spacing = State(initialValue: spacing)
        _selectedColor = State(initialValue: selectedColor)
        _unselectedColor = State(initialValue: unselectedColor)
        _backgroundColor = State(initialValue: backgroundColor)
        _minLowPoint = State(initialValue: points.min {a, b in a.lowPoint < b.lowPoint}!.lowPoint as CGFloat)
        _maxHighPoint = State(initialValue: points.max {a, b in a.highPoint < b.highPoint}!.highPoint as CGFloat)
        _pointHeight = State(initialValue: CGFloat(height - 20)/(_maxHighPoint.wrappedValue - _minLowPoint.wrappedValue))
        _selectedId = State(initialValue: selectedId)
        _barColor = State(initialValue: barColor)
        _textColor = State(initialValue: textColor)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backgroundColor)
                HStack(alignment: .center) {
                    Spacer()
                    ForEach(points, id: \.id) { point in
                        VStack {
                            doublePointBar(height: height, point: point, barColor: barColor, maxHighPoint: maxHighPoint, minLowPoint: minLowPoint, pointHeight: pointHeight, selectedColor: selectedId == point.id ? selectedColor : unselectedColor, selected: selectedId == point.id, textColor: textColor)
                            Text(point.label)
                                .font(.system(size:20))
                                .foregroundColor(selectedId == point.id ? selectedColor : textColor)
                        }
                        Spacer()
                            .frame(width: CGFloat(spacing))
                    }
                    Spacer()
                }
                .padding(5)
            }
        }.frame(height: CGFloat(height + 25))
    }
}

struct LabeledDoublePoints: Identifiable {
    var id: Int
    var label: String
    var lowPoint: CGFloat
    var highPoint: CGFloat
    
    init(id: Int, label: String, lowPoint: CGFloat, highPoint: CGFloat) {
        self.id = id
        self.lowPoint = lowPoint
        self.highPoint = highPoint
        self.label = label
    }
}

struct doublePointBar: View {
    @State var height: Int
    @State var point: LabeledDoublePoints
    @State var barColor: Color
    @State var maxHighPoint: CGFloat
    @State var minLowPoint: CGFloat
    @State var pointHeight: CGFloat
    @State var selectedColor: Color
    @State var selected: Bool
    @State var textColor: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(barColor)
                .frame(width:1, height: CGFloat(height - 20))
            VStack{
                Spacer()
                    .frame(height: pointHeight * (maxHighPoint - point.highPoint))
                Rectangle()
                    .foregroundColor(selectedColor)
                    .frame(width:3, height: (point.highPoint - point.lowPoint) * CGFloat(pointHeight))
                Spacer()
                    .frame(height: pointHeight * (point.lowPoint - minLowPoint))
            }.frame(height: CGFloat(height - 20))
            
            if (selected) {
                VStack {
                    Text("\(point.highPoint, specifier: "%.2f")")
                        .font(.system(size: 15))
                        .foregroundColor(textColor)
                    Spacer()
                        .frame(height:(point.highPoint - point.lowPoint) * CGFloat(pointHeight) - 5)
                    Text("\(point.lowPoint, specifier: "%.2f")")        .font(.system(size: 15))
                        .foregroundColor(textColor)
                    Spacer()
                        .frame(height: (point.highPoint - point.lowPoint) * CGFloat(pointHeight))
                }
            }
        }.frame(height: CGFloat(height - 20))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
