//
//  double-point-chart.swift
//  doublepoint-chart
//

import Foundation
import SwiftUI

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
