//
//  ContentView.swift
//  SwiftUI-AnimatingParticles
//
//  Created by mobiiworld on 14/06/23.
//

import SwiftUI

struct ContentView: View {
    @State var start = false
    @State var endAnimation = false
    @State private var selectedEffects = 0


    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Animated Particles")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(height: 45)
                
                Picker("", selection: $selectedEffects) {
                    Text("Snow Fleak").tag(0)
                    Text("Birthday").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(15)
                
                if selectedEffects == 0{
                    SnowFleakView()
                        .scaleEffect(start ? 1 : 0,anchor: .top)
                        .opacity(start && !endAnimation ? 1 : 0)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Image("snowman")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300,height: 300)
                        
                        Button {
                            doAnimation()
                        } label: {
                            Text("Snow Fall")
                                .kerning(2)
                                .fontWeight(.bold)
                                .padding(.horizontal,50)
                                .padding(.vertical,12)
                                .background(.cyan)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                        .disabled(start)
                    }
                } else if selectedEffects == 1{
                    EmitterView()
                        .scaleEffect(start ? 1 : 0,anchor: .top)
                        .opacity(start && !endAnimation ? 1 : 0)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Image("birthdayBoy")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300,height: 300)
                        Button {
                            doAnimation()
                        } label: {
                            Text("Wish Me")
                                .kerning(2)
                                .fontWeight(.bold)
                                .padding(.horizontal,50)
                                .padding(.vertical,12)
                                .background(.cyan)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                        .disabled(start)
                    }
                }
            }
        }
    }
    
    func doAnimation() {
        withAnimation(.spring()) {
            start = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation(.easeInOut(duration: 1.5)) {
                endAnimation = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                start = false
                endAnimation = false
            }
        }
    }
}


//Global Function For Getting Size
func getRect() -> CGRect {
    return UIScreen.main.bounds
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Emit Particle View
//CAEmitter Layer From UIKit
struct EmitterView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        //Emitter Layer
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func createEmitterCells() -> [CAEmitterCell] {
        var emitterCells: [CAEmitterCell] = []
        for index in 1...12 {
            let cell = CAEmitterCell()
            cell.contents = UIImage.init(named: getImage(index: index))?.cgImage
            cell.color = getColor().cgColor
            cell.birthRate = 4.5
            cell.lifetime = 20
            cell.velocity = 120
            cell.scale = 0.2
            cell.scaleRange = 0.3
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            cell.yAcceleration = 40
            emitterCells.append(cell)
        }
        return emitterCells
    }
    
    func getColor()->UIColor {
        let color:[UIColor] = [.systemRed,.systemBlue,.systemPink,.systemMint,.systemYellow,.systemGreen,.systemPurple,.systemOrange]
        
        return color.randomElement() ?? UIColor.red
    }
    
    func getImage(index: Int)->String {
        if index < 4 {
            return "square"
        } else if index > 5 && index <= 8 {
            return "circle"
        } else {
            return "triangle"
        }
    }
}

//Snow Fleak View
struct SnowFleakView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        //Emitter Layer
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    
    func createEmitterCells() -> [CAEmitterCell] {
        var emitterCells: [CAEmitterCell] = []
        for _ in 1...12 {
            let cell = CAEmitterCell()
            cell.color = Color.white.cgColor
            cell.contents = UIImage.init(named: "snowflake")?.cgImage
            cell.birthRate = 4.5
            cell.lifetime = 20
            cell.velocity = 120
            cell.scale = 0.2
            cell.scaleRange = 0.3
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            cell.yAcceleration = 40
            emitterCells.append(cell)
        }
        return emitterCells
    }
}
