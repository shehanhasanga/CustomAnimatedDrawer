//
//  ContentView.swift
//  AnimatedDrawer
//
//  Created by shehan karunarathna on 2022-02-11.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu:Bool = false
    @State var animateBG :Bool = false
    @State var animatePath :Bool = false
    var body: some View {
       
        ZStack{
            VStack(spacing:10){
                HStack{
                    Button{
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){
                            animatePath.toggle()
                        }
                        withAnimation (.spring().delay(0.1)){
                            showMenu.toggle()
                        }
                        withAnimation {
                            animateBG.toggle()
                        }
                        
                        
                        
                       
                    }label: {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.system(size: 45))
                            .shadow(color: .orange, radius: 10, x: 0, y: 0)
                    }
                    
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 45))
                            .shadow(color: .orange, radius: 10, x: 0, y: 0)
                    }
                }
                .overlay(
                Text("Stories")
                    .font(.title2)
                    .bold()
                )
                .foregroundColor(.orange.opacity(0.8))
                
                .padding()
              
                
                
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        
                    }
                }
                   
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [.black,.blue], startPoint: .bottom, endPoint: .top)
            )
            
            Color.black.opacity(animateBG ? 0.2 : 0)
                .ignoresSafeArea()
            
            MenuView(showMenu: $showMenu, animateBG: $animateBG, animatePath: $animatePath)
                .offset(x: showMenu ? 0 : -400)
           
           
           
           
        }
        
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

@ViewBuilder
func MenuButton(title:String, image:String, offset:CGFloat) -> some View {
    Button{
        
    }label: {
        HStack{
            Image(systemName: image)
                .font(.system(size: 25))
            Text(title)
                .font(.system(size: 17))
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
        .padding(.vertical)
       
    }
    .offset(x:offset)
}

struct MenuView: View {
    @Binding var showMenu:Bool
    @Binding var animateBG :Bool
    @Binding var animatePath :Bool
    var body: some View {
        ZStack{
            BlurView(style: .systemUltraThinMaterial)
            Color.blue.opacity(0.2)
            
            VStack(alignment:.leading, spacing:25){
                Button{
                    showMenu.toggle()
                    animateBG.toggle()
                    animatePath.toggle()
                }label: {
                    Image(systemName: "xmark.circle")
                }
                .foregroundColor(.white)
               
                
                MenuButton(title: "title1", image: "xmark", offset: 10)
                MenuButton(title: "title1", image: "xmark", offset: 10)
                MenuButton(title: "title1", image: "xmark", offset: 10)
                
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .padding()
            .padding(.top, getsafearea().top)
            .padding(.bottom, getsafearea().bottom)
        }
        .clipShape(MenuShape(value: animatePath ? 150 : 0))
        .background(
            MenuShape(value: animatePath ? 150 : 0)
                .stroke(
                    .linearGradient(.init(colors: [.blue,.black]), startPoint: .bottom,
                                    endPoint: .top),
                    lineWidth: 20
                )
                
        )
        .ignoresSafeArea()
    }
}
struct MenuShape: Shape {
    var value : CGFloat
    
    var animatableData : CGFloat{
        get{return value}
        set{value = newValue}
    }
    func path(in rect: CGRect) -> Path {
        var height = rect.height
        var width = rect.width - 100
        return Path { path in
            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            path.move(to: CGPoint(x: width, y: 0))
            path.addCurve(to: CGPoint(x: width, y: height + 100), control1: CGPoint(x: width + value, y: height / 3), control2: CGPoint(x: width - value, y: height / 2))
        }
    }
    
   
}

extension View {
    
    func getsafearea () -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return .zero}
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {return .zero
        }
        
        return safeArea
    }
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
    
}
