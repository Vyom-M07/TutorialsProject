//
//  ContentView.swift
//  FISD Tutorials
//
//  Created by Sohan Mekala on 10/15/23.
//

import Foundation
import SwiftUI


extension Color {
    init(hex: UInt) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}



struct LoginPage: View {
    
    @State private var id: String = ""
    @State private var pass: String = ""
    @State private var isLogged: Bool = false

    
    var body: some View {
        ZStack {
            //title
            Text("ClassCompass")
                .offset(x: 0, y: -110)
                .font(.system(size: 36))
            //logo
            Image("logo")
                .resizable()
                .offset(x: 0, y: -175)
                .frame(width: 200, height: 100)
            
            //id number box
            RoundedRectangle(cornerRadius:10)
                    .offset(x: 0, y: -20)
                    .frame(width: 200, height: 40)
                    .foregroundColor(Color(hex: 0x70a5fa))
            
            //pasword box
            RoundedRectangle(cornerRadius:10)
                    .offset(x: 0, y: 30)
                    .frame(width: 200, height: 40)
                    .foregroundColor(Color(hex: 0x70a5fa))
            
            //id number text field
            TextField("ID Number",text: $id)
                .frame(width: 170, height: 50)
                .offset(x: 0, y: -19)
                .padding()
            
            //password text field
            SecureField("Password",text: $pass)
                .frame(width: 170, height: 50)
                .offset(x: 0, y: 30)
                .padding()
            
            //login box
            RoundedRectangle(cornerRadius:10)
                    .offset(x: 0, y: 120)
                    .frame(width: 180, height: 40)
                    .foregroundColor(Color(hex: 0x8cfa8c))
            
            
            //login button
            Button("Login with HAC") {

                loginWorked(u: id, p: pass)
                
            }
            .bold()
            .offset(x: 0, y: 120)
            .font(.system(size: 20))
            .foregroundColor(Color.black)
            
            
        }
        .fullScreenCover(isPresented: $isLogged, content: {
                    HomePage()
        })
    }
    
    func loginWorked(u: String, p: String) {
        let url = URL(string: "https://friscoisdhacapi.vercel.app/api/info")!

        // Define parameters for the request (username and password)
        let params = ["username": u, "password": p]

        // Construct URL with query parameters
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }

        // Create a URLRequest with the constructed URL
        let request = URLRequest(url: components.url!)



        // Create a URLSessionDataTask to perform the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle any errors that occurred during the request
            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                isLogged = false
                return
            }

            isLogged = (httpResponse.statusCode == 200)

        }

        // Start the URLSessionDataTask
        task.resume()
    }
}




struct HomePage: View{
    var body: some View {
        ZStack {
                Text("Welcome to the Home Page!")
                .font(.system(size: 24))
                .padding()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
