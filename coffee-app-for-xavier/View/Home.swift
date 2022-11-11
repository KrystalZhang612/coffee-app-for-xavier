//
//  Home.swift
//  coffee-app-for-xavier
//
//  Created by Krystal Zhang on 11/10/22.
//

import SwiftUI

struct Home: View {
    
    //MARK: GESTURE PROPERTIES
    @State var offsetY: CGFloat = 0
    @State var currentIndex: CGFloat = 0
    var body: some View {
        GeometryReader{
            let size = $0.size
            //MARK: SINCE CARD SIZE IS THE SIZE OF THE SCREEN WIDTH
            let cardSize = size.width
            //bottom gradient background
            LinearGradient(colors: [
                .clear,
                Color("Brown").opacity(0.2),
                Color("Brown").opacity(0.45),
                Color("Brown")
            ], startPoint: .top, endPoint: .bottom)
            .frame(height: 300)
            .frame(maxHeight: .infinity,alignment: .bottom)
            .ignoresSafeArea()
            
            //MARK: header view
            HeaderView()
        
            VStack(spacing: 0){
                ForEach(coffees){ coffee in
                    CoffeeView(coffee: coffee, size: size)
                }
            }
            .frame(width: size.width)
            .padding(.top,size.height - cardSize)
            .offset(y: offsetY)
            .offset(y: -currentIndex * cardSize)
        }
        .coordinateSpace(name: "SCROLL")
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged({ value in
                    //SLOWING DOWNN THE GESTURE
                    offsetY = value.translation.height * 0.4
                }).onEnded({ value in
                    let translation = value.translation.height
                    withAnimation(.easeInOut){
                    
                    if translation > 0 {
                        //250 UPDATE FOR LOCAL USAGE
                        if currentIndex > 0 && translation > 250 {
                            currentIndex -= 1
                        }
                    } else{
                        if currentIndex < CGFloat(coffees.count - 1) && -translation > 250 {
                            currentIndex += 1
                        }
                    }
                        offsetY = .zero
                    }
                    
                })
        )
        .preferredColorScheme(.light)
    }
    @ViewBuilder
    func HeaderView() -> some View{
        VStack{
            HStack{
                Button{
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                }
                Spacer()
                Button{
                    
                }label: {
                    Image("Cart")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
            //aimated slider
            GeometryReader {
                let size = $0.size
                
                HStack(spacing:0){
                    ForEach(coffees) {coffee in
                        VStack(spacing: 15){
                            Text(coffee.title)
                                .font(.title.bold())
                                .multilineTextAlignment(.center)
                            Text(coffee.price)
                                .font(.title)
                        }
                        .frame(width: size.width)
                    }
                }
                .offset(x:currentIndex * -size.width)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8), value: currentIndex)
            }
            .padding(.top, -5)
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: Coffee view
struct CoffeeView: View{
    
    var coffee: Coffee
    var size: CGSize
    var body: some View{
        let cardSize = size.width * 1
        //MARK: bottom gradient background
        
        //since card width
        //add extra scaling size
        let maxCardsDisplaySize = size.width * 4
        
        GeometryReader{proxy in
            let _size = proxy.size
            //MARK: SCALING ANIMATION
            //current card offset tree-max
            let offset = proxy.frame(in: .named("SCROLL")).minY - (size.height - cardSize )
            let scale = offset <= 0 ? (offset / maxCardsDisplaySize) : 0
            let reducedScale = 1 + scale
            let currentCardScale = offset / cardSize
            

            Image(coffee.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: _size.width, height: _size.height)
                //to avoid warning
            //MARK: UPFDATING ANCHOR BASED ON THE CURRENT CARD SCALE
                .scaleEffect(reducedScale < 0 ? 0.001 : reducedScale, anchor: .init(x: 0.5, y : 1 - (currentCardScale/2.4)))
            //MARK: WHEN IT COMWES FROM BOTTOM ANIMATE AS USUAL
                .scaleEffect(offset > 0 ? 1 + currentCardScale : 1 , anchor: .top)
            //MARK: REMOVE THE EXCESSIVE NEXT VIEW
                .offset(y: offset > 0 ? currentCardScale * 200 : 0 )
            //making it more compact
                .offset(y: currentCardScale * -130)
            
        }
        .frame(height: cardSize)
    }
}
